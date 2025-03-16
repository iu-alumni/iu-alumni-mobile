import 'package:fpdart/fpdart.dart';

import '../../models/event.dart';

abstract interface class EventsRepository {
  Future<Iterable<EventModel>> getEvents();

  Future<Option<EventModel>> getOneEvent(String eventId);

  EventModel createEvent();

  Future<void> modifyEvent(EventModel event);

  Future<void> save();
}