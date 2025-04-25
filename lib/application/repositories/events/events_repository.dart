import 'package:fpdart/fpdart.dart';

import '../../models/event.dart';

abstract interface class EventsRepository {
  Future<Iterable<EventModel>> getEvents(Option<String> myId);

  Future<Option<EventModel>> getOneEvent(String eventId, Option<String> myId);

  EventModel createEvent();

  void modifyEvent(EventModel event);

  Future<void> deleteEvent(String eventId);

  Future<bool> save();

  Future<EventModel> participate(String eventId, String myId);
}
