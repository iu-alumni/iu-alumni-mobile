import 'package:fpdart/fpdart.dart';

import '../models/event_data_model.dart';
import '../models/event_request_data_model.dart';

abstract interface class EventsGateway {
  Future<Iterable<EventDataModel>> loadEvents();
  Future<Option<String>> addEvent(EventRequestDataModel event);
  Future<bool> updateEvent(String eventId, EventRequestDataModel event);
  Future<bool> deleteEvent(String eventId);
  Future<bool> participate(String eventId, String userId);
  Future<bool> leave(String eventId, String userId);
  Future<Iterable<EventDataModel>> eventsIOwn();
  Future<Iterable<EventDataModel>> eventsWhereParticipate(String userId);
}
