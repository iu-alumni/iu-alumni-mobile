import 'package:fpdart/fpdart.dart';

import '../../models/event.dart';

abstract interface class EventsRepository {
  Future<Iterable<EventModel>> getEvents();

  Future<Option<EventModel>> getOneEvent(String eventId);

  EventModel createEvent();

  void modifyEvent(EventModel event);

  Future<void> deleteEvent(String eventId);

  Future<void> save();
}
