import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../common/dio_options_manager.dart';
import '../models/event_data_model.dart';
import '../models/event_request_data_model.dart';
import '../paths.dart';
import 'events_gateway.dart';

class EventsGatewayImpl implements EventsGateway {
  EventsGatewayImpl(this._dio, this._optionsManager);

  final Dio _dio;
  final DioOptionsManager _optionsManager;

  @override
  Future<void> addEvent(EventRequestDataModel event) =>
      TaskOption.tryCatch(() async {
        final data = jsonEncode(event.toJson());
        await _dio.post(
          Paths.events,
          data: data,
          options: _optionsManager.opts(),
        );
      }).run();

  @override
  Future<Iterable<EventDataModel>> loadEvents() =>
      TaskEither.tryCatch(() async {
        final resp = await _dio.get(
          Paths.events,
          options: _optionsManager.opts(),
        );
        final list = resp.data as List;
        return list.cast<Map<String, dynamic>>().map(EventDataModel.fromJson);
      }, (e, _) => '$e')
          .match<Iterable<EventDataModel>>((_) => [], identity)
          .run();

  @override
  Future<bool> deleteEvent(String eventId) => TaskEither.tryCatch(() async {
        await _dio.delete(
          Paths.eventWithId(eventId),
          options: _optionsManager.opts(),
        );
        return true;
      }, (e, _) => '$e').match((_) => false, identity).run();

  @override
  Future<bool> updateEvent(String eventId, EventRequestDataModel event) =>
      TaskEither.tryCatch(() async {
        final requestModel = event.toJson();
        requestModel['datetime'] = null;
        await _dio.put(
          Paths.eventWithId(eventId),
          options: _optionsManager.opts(),
          data: jsonEncode(requestModel),
        );
        return true;
      }, (e, _) => '$e').match((_) => false, identity).run();

  @override
  Future<bool> participate(String eventId, String userId) =>
      TaskEither.tryCatch(() async {
        await _dio.post(
          Paths.participants(eventId),
          options: _optionsManager.opts(),
          queryParameters: {'participant_id': userId},
        );
        return true;
      }, (e, _) => '$e').match((_) => false, identity).run();
}
