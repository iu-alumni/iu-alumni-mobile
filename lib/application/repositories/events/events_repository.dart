import 'package:fpdart/fpdart.dart';

import '../../models/event.dart';

abstract interface class EventsRepository {
  Future<Iterable<EventModel>> getEvents();

  Future<Iterable<EventModel>> getEventsIOwn();

  // Future<Iterable<EventModel>> getEventsIParticipateIn();

  Future<Iterable<EventModel>> getEventsWhereParticipate(String uid);

  Future<Option<EventModel>> getOneEvent(String eventId);

  EventModel createEvent();

  void modifyEvent(EventModel event);

  Future<void> deleteEvent(String eventId);

  Future<Option<String>> save();

  Future<Option<EventModel>> participate(String eventId);

  Future<Option<EventModel>> leave(String eventId);
}
