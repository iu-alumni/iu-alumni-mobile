import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../data/events/events_gateway.dart';
import '../../../util/logger.dart';
import '../../mappers/event_mapper.dart';
import '../../models/cost.dart';
import '../../models/event.dart';
import '../../models/user_status.dart';
import '../users/users_repository.dart';
import 'events_repository.dart';

class EventsRepositoryImpl implements EventsRepository {
  EventsRepositoryImpl(this._uuid, this._gateway, this._usersRepository);

  final Uuid _uuid;
  final EventsGateway _gateway;
  final UsersRepository _usersRepository;

  Map<String, EventModel>? _cache;
  Set<String>? _owned;
  Set<String>? _participated;
  EventModel? _modifiedEvent;

  @override
  Future<Iterable<EventModel>> getEvents() async {
    await _loadEvents();
    return _cache!.values;
  }

  Future<Option<String>> _myId() async {
    final me = await _usersRepository.loadMe();
    return me.map((p) => p.profileId);
  }

  Future<void> _loadEvents({bool refresh = false}) async {
    if (!refresh && _cache != null) {
      return;
    }
    final data = await _gateway.loadEvents();
    final myId = await _myId();
    final eventModels = data.map(EventMapper.eventFromData(myId.toNullable()));
    // Fill the cache
    _cache?.clear();
    _owned?.clear();
    _participated?.clear();
    _cache ??= {};
    _owned ??= {};
    _participated ??= {};
    for (final e in eventModels) {
      _cache![e.eventId] = e;
      if (e.userStatus case UserAuthor()) {
        _owned!.add(e.eventId);
      } else if (e.userStatus case UserNotAuthor(participant: true)) {
        _participated!.add(e.eventId);
      }
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
      participantsIds: const ISet.empty(),
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

  Future<Option<String>> _mutateAndSave(EventModel event) async {
    final eventRequest = EventMapper.eventRequestFromModel(event);
    // Has event already been in the created ever (otherwise it is new)
    if (_cache!.containsKey(event.eventId)) {
      final success = await _gateway.updateEvent(event.eventId, eventRequest);
      if (success) {
        // Update the event in the cache on success
        _cache![event.eventId] = event;
        // When modified, the event ID stays the same
        return Option.of(event.eventId);
      }
      // The event modification was not successful, none for the error state
      return const None();
    } else {
      // Event not found in the cache, so it is a new event
      final newId = await _gateway.addEvent(eventRequest);
      // Load personal profile to add the ID of the creator
      final myProfile = await _usersRepository.loadMe();
      // Update the event ID by the one server responded with
      newId.map((eid) {
        _cache![eid] = event.copyWith(
          eventId: eid,
          participantsIds: [
            if (myProfile case Some(:final value)) value.profileId,
          ].toISet(),
        );
        _owned!.add(eid);
      });
      return newId;
    }
  }

  @override
  Future<Option<String>> save() async {
    final event = _modifiedEvent;
    if (event == null) {
      // Nothing modified, so nothing to save
      return const None();
    }
    _modifiedEvent = null;
    return _mutateAndSave(_fixEvent(event));
  }

  @override
  Future<Option<EventModel>> getOneEvent(String eventId) async {
    await _loadEvents();
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
      _owned?.remove(eventId);
    }
  }

  @override
  Future<Option<EventModel>> participate(String eventId) async {
    final maybeMyId = await _myId();
    if (maybeMyId case Some(value: final myId)) {
      final success = await _gateway.participate(eventId, myId);
      if (_cache?[eventId] case final EventModel event when success) {
        if (event.userStatus case UserNotAuthor status) {
          _cache?[eventId] = event.copyWith(
            userStatus: status.copyWith(participant: success),
            participantsIds: event.participantsIds.add(myId),
          );
          _participated?.add(eventId);
        }
      }
      await _loadEvents();
      return Option.tryCatch(() => _cache![eventId]!);
    }
    return const None();
  }

  @override
  Future<Option<EventModel>> leave(String eventId) async {
    final maybeMyId = await _myId();
    if (maybeMyId case Some(value: final myId)) {
      final success = await _gateway.leave(eventId, myId);
      if (_cache?[eventId] case final EventModel event when success) {
        if (event.userStatus case UserNotAuthor status) {
          _cache?[eventId] = event.copyWith(
            userStatus: status.copyWith(participant: !success),
            participantsIds: event.participantsIds.remove(myId),
          );
          _participated?.remove(eventId);
        }
      }
      await _loadEvents();
      return Option.of(_cache![eventId]!);
    }
    return const None();
  }

  @override
  Future<Iterable<EventModel>> getEventsIOwn() async {
    if (_owned case final owned?) {
      if (_cache case final events?) {
        return events.values.where((e) => owned.contains(e.eventId));
      }
    }
    final data = await _gateway.eventsIOwn();
    final myId = await _myId();
    return data.map(EventMapper.eventFromData(myId.toNullable()));
  }

  // @override
  // Future<Iterable<EventModel>> getEventsIParticipateIn() async {
  //   if (_participated case final participated?) {
  //     if (_cache case final events?) {
  //       return events.values.where((e) => participated.contains(e.eventId));
  //     }
  //   }
  //   final mid = await _myId();
  //   return mid.match(() => const [], getEventsWhereParticipate);
  // }

  @override
  Future<Iterable<EventModel>> getEventsWhereParticipate(String uid) async {
    final mid = await _myId();
    if (mid.match(() => false, (myId) => myId == uid)) {
      if (_participated case final participated?) {
        if (_cache case final events?) {
          logger.d('Using cache to fetch events where the user participated');
          return events.values.where((e) => participated.contains(e.eventId));
        }
      }
    }
    logger.d('Loading participated events for $uid');
    final data = await _gateway.eventsWhereParticipate(uid);
    return data.map(EventMapper.eventFromData(uid));
  }
}
