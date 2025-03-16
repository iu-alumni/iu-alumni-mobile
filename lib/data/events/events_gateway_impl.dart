import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../models/event_data_model.dart';
import '../models/event_request_data_model.dart';
import '../paths.dart';
import 'events_gateway.dart';

class EventsGatewayImpl implements EventsGateway {
  EventsGatewayImpl(this._dio);

  final Dio _dio;

  @override
  Future<void> addEvent(String eid, EventRequestDataModel event) =>
      TaskOption.tryCatch(() async {
        final resp = await _dio.put(
          Paths.eventWithId(eid),
          data: jsonEncode(event),
        );
        print('Response: ${resp.data}');
      }).run();

  @override
  Future<Iterable<EventDataModel>> loadEvents() =>
      TaskOption.tryCatch(() async {
        final resp = await _dio.get(Paths.events);
        final list = jsonDecode(resp.data) as List;
        return list.cast<Map<String, dynamic>>().map(EventDataModel.fromJson);
      }).match<Iterable<EventDataModel>>(() => [], identity).run();
}
