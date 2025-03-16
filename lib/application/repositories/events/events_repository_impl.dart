import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../data/events/events_gateway.dart';
import '../../mappers/event_mapper.dart';
import '../../models/cost.dart';
import '../../models/event.dart';
import 'events_repository.dart';

class EventsRepositoryImpl implements EventsRepository {
  EventsRepositoryImpl(this._uuid, this._gateway);

  final Uuid _uuid;
  final EventsGateway _gateway;

  Map<String, EventModel>? _cache;
  _ModifiedEvent? _modifiedEvent;

  @override
  Future<Iterable<EventModel>> getEvents() async {
    await _loadEvents();
    return _cache!.values;
  }

  Future<void> _loadEvents({bool refresh = false}) async {
    if (!refresh && _cache != null) {
      return;
    }
    final data = await _gateway.loadEvents();
    final eventModels = data.map(EventMapper.eventFromData);
    // Fill the cache
    _cache?.clear();
    _cache ??= {};
    for (final e in eventModels) {
      _cache![e.eventId] = e;
    }
  }

  @override
  EventModel createEvent() {
    final event = EventModel(
      eventId: _uuid.v4(),
      title: null,
      description: null,
      coverUrl: null,
      location: null,
      cost: const CostModel(number: 0, currency: Currency.rub),
      occurringAt: DateTime.now().add(const Duration(days: 1)),
      onlineEvent: false,
    );
    _addToCache(event);
    _modifiedEvent = _ModifiedEvent(event.eventId, true);
    return event;
  }

  Future<void> _addToCache(EventModel model) async {
    await _loadEvents();
    _cache![model.eventId] = model;
  }

  @override
  Future<void> modifyEvent(EventModel event) => _addToCache(event);

  @override
  Future<void> save() async {
    if (_cache == null) {
      // Events have to be loaded at least, otherwise there is nothing to save
      return;
    }
    final event = _modifiedEvent;
    if (event == null) {
      // Nothing modified, so nothing to save
      return;
    }
    final eventModel = _cache![event.eventId];
    if (eventModel == null) {
      // Event not found in the cache
      return;
    }
    final eventRequest = EventMapper.eventRequestFromModel(eventModel);
    if (event.isNewlyCreated) {
      await _gateway.addEvent(event.eventId, eventRequest);
    }
    _modifiedEvent = null;
  }

  @override
  Future<Option<EventModel>> getOneEvent(String eventId) async {
    await _loadEvents();
    return Option.fromNullable(_cache![eventId]);
  }
}

class _ModifiedEvent {
  _ModifiedEvent(this.eventId, this.isNewlyCreated);
  final String eventId;
  final bool isNewlyCreated;
}
