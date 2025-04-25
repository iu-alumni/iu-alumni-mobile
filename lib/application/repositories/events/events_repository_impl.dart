import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../data/events/events_gateway.dart';
import '../../mappers/event_mapper.dart';
import '../../models/cost.dart';
import '../../models/event.dart';
import '../../models/user_status.dart';
import 'events_repository.dart';

class EventsRepositoryImpl implements EventsRepository {
  EventsRepositoryImpl(this._uuid, this._gateway);

  final Uuid _uuid;
  final EventsGateway _gateway;

  Map<String, EventModel>? _cache;
  EventModel? _modifiedEvent;

  @override
  Future<Iterable<EventModel>> getEvents(Option<String> myId) async {
    await _loadEvents(myId);
    return _cache!.values;
  }

  Future<void> _loadEvents(Option<String> myId, {bool refresh = false}) async {
    if (!refresh && _cache != null) {
      return;
    }
    final data = await _gateway.loadEvents();
    final eventModels = data.map(EventMapper.eventFromData(myId.toNullable()));
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
      userStatus: const UserStatus.author(),
      title: null,
      description: null,
      coverBytes: null,
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

  Future<bool> _mutateAndSave(EventModel event) async {
    // _cache![event.eventId] = event;
    final eventRequest = EventMapper.eventRequestFromModel(event);
    // Has event already been in the created ever (otherwise it is new)
    if (_cache!.containsKey(event.eventId)) {
      final success = await _gateway.updateEvent(event.eventId, eventRequest);
      if (success) {
        // Update the event in the cache on success
        _cache![event.eventId] = event;
      }
      return success;
    } else {
      // Event not found in the cache, so it is a new event
      final newId = await _gateway.addEvent(eventRequest);
      // Update the event ID by the one server responded
      newId.map((eid) {
        _cache![event.eventId] = event.copyWith(eventId: eid);
      });
      return newId.isSome();
    }
  }

  @override
  Future<bool> save() async {
    final event = _modifiedEvent;
    if (event == null) {
      // Nothing modified, so nothing to save
      return true;
    }
    _modifiedEvent = null;
    return _mutateAndSave(_fixEvent(event));
  }

  @override
  Future<Option<EventModel>> getOneEvent(
    String eventId,
    Option<String> myId,
  ) async {
    await _loadEvents(myId);
    return Option.fromNullable(_cache![eventId]);
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    final deletedModel = _cache!.remove(eventId);
    // TODO show an error in case of failure
    final success = await _gateway.deleteEvent(eventId);
    if (!success && deletedModel != null) {
      // Return the deleted event back if it wasn't deleted
      _cache?[eventId] = deletedModel;
    }
  }

  @override
  Future<EventModel> participate(String eventId, String myId) async {
    final success = await _gateway.participate(eventId, myId);
    if (_cache?[eventId] case final EventModel event when success) {
      if (event.userStatus case UserNotAuthor status) {
        _cache?[eventId] = event.copyWith(
          userStatus: status.copyWith(participant: success),
        );
      }
    }
    await _loadEvents(Option.of(myId));
    return _cache![eventId]!;
  }
}
