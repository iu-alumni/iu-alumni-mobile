import 'package:fpdart/fpdart.dart';

import '../models/event_data_model.dart';
import '../../application/models/paginated_result.dart';
import '../models/event_request_data_model.dart';

abstract interface class EventsGateway {
  Future<PaginatedResult<EventDataModel>> loadEvents({String? cursor, int limit});
  Future<PaginatedResult<EventDataModel>> loadPendingEvents({String? cursor, int limit});
  Future<Option<String>> addEvent(EventRequestDataModel event);
  Future<bool> updateEvent(String eventId, EventRequestDataModel event);
  Future<bool> deleteEvent(String eventId);
  Future<bool> participate(String eventId, String userId);
  Future<bool> leave(String eventId, String userId);
  Future<Iterable<EventDataModel>> eventsIOwn();
  Future<Iterable<EventDataModel>> eventsWhereParticipate(String userId);
}
