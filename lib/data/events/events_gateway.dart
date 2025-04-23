import '../models/event_data_model.dart';
import '../models/event_request_data_model.dart';

abstract interface class EventsGateway {
  Future<Iterable<EventDataModel>> loadEvents();
  Future<void> addEvent(EventRequestDataModel event);
  Future<bool> updateEvent(String eventId, EventRequestDataModel event);
  Future<bool> deleteEvent(String eventId);
  Future<bool> participate(String eventId, String userId);
}
