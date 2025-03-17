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
  EventModel? _modifiedEvent;

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
    _modifiedEvent = event;
    return event;
  }

  EventModel _fixEvent(EventModel model) => model.copyWith(
        title: model.title == null || model.title!.isEmpty
            ? 'Untitled'
            : model.title,
      );

  @override
  void modifyEvent(EventModel event) {
    _modifiedEvent = event;
  }

  Future<void> _mutateAndSave(EventModel event) async {
    final isOldEvent = _cache!.containsKey(event.eventId);
    _cache![event.eventId] = event;
    final eventRequest = EventMapper.eventRequestFromModel(event);
    if (isOldEvent) {
      // TODO update an event
    } else {
      // Event not found in the cache, so it is a new event
      await _gateway.addEvent(eventRequest);
    }
  }

  @override
  Future<void> save() async {
    await _loadEvents();
    final event = _modifiedEvent;
    if (event == null) {
      // Nothing modified, so nothing to save
      return;
    }
    _modifiedEvent = null;
    _mutateAndSave(_fixEvent(event));
  }

  @override
  Future<Option<EventModel>> getOneEvent(String eventId) async {
    await _loadEvents();
    return Option.fromNullable(_cache![eventId]);
  }
}
