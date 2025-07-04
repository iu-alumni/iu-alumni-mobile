import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../common/dio_options_manager.dart';
import '../models/event_data_model.dart';
import '../models/event_request_data_model.dart';
import '../paths.dart';
import '../secrets/secrets_manager.dart';
import 'events_gateway.dart';

class EventsGatewayImpl implements EventsGateway {
  EventsGatewayImpl(this._dio, this._optionsManager, this._secretsManager);

  final Dio _dio;
  final DioOptionsManager _optionsManager;
  final SecretsManager _secretsManager;

  @override
  Future<Option<String>> addEvent(EventRequestDataModel event) async {
    final result = await TaskEither.tryCatch(
      () async {
        final data = jsonEncode(event.toJson());
        final response = await _dio.post(
          Paths.events(_secretsManager.hostPath),
          data: data,
          options: _optionsManager.opts(),
        );
        final json = response.data as Map<String, dynamic>;
        return json['id'] as String;
      },
      (e, _) => '$e',
    ).run();
    return result.toOption();
  }

  @override
  Future<Iterable<EventDataModel>> loadEvents() =>
      TaskEither.tryCatch(() async {
        final resp = await _dio.get(
          Paths.events(_secretsManager.hostPath),
          options: _optionsManager.opts(),
        );
        final list = resp.data as List;
        return list.cast<Map<String, dynamic>>().map(EventDataModel.fromJson);
      }, (e, _) => '$e')
          .match<Iterable<EventDataModel>>((_) => [], identity)
          .run();

  @override
  Future<bool> deleteEvent(String eventId) async {
    final result = await TaskEither.tryCatch(
      () => _dio.delete(
        Paths.eventWithId(_secretsManager.hostPath, eventId),
        options: _optionsManager.opts(),
      ),
      (e, _) => '$e',
    ).run();
    return result.isRight();
  }

  @override
  Future<bool> updateEvent(String eventId, EventRequestDataModel event) async {
    final result = await TaskEither.tryCatch(
      () async {
        final requestModel = event.toJson();
        requestModel['datetime'] = null;
        await _dio.put(
          Paths.eventWithId(_secretsManager.hostPath, eventId),
          options: _optionsManager.opts(),
          data: jsonEncode(requestModel),
        );
      },
      (e, _) => '$e',
    ).run();
    return result.isRight();
  }

  @override
  Future<bool> participate(String eventId, String userId) async {
    final result = await TaskEither.tryCatch(
      () => _dio.post(
        Paths.participants(_secretsManager.hostPath, eventId),
        options: _optionsManager.opts(),
        queryParameters: {'participant_id': userId},
      ),
      (e, _) => '$e',
    ).run();
    return result.isRight();
  }

  @override
  Future<bool> leave(String eventId, String userId) async {
    final result = await TaskEither.tryCatch(
      () => _dio.post(
        Paths.leave(_secretsManager.hostPath, eventId),
        options: _optionsManager.opts(),
        queryParameters: {'participant_id': userId},
      ),
      (e, _) => '$e',
    ).run();
    return result.isRight();
  }

  @override
  Future<Iterable<EventDataModel>> eventsIOwn() =>
      TaskEither.tryCatch(() async {
        final resp = await _dio.get(
          Paths.eventsOwner(_secretsManager.hostPath),
          options: _optionsManager.opts(),
        );
        final list = resp.data as List;
        return list.cast<Map<String, dynamic>>().map(EventDataModel.fromJson);
      }, (e, _) => '$e')
          .match<Iterable<EventDataModel>>((_) => [], identity)
          .run();

  @override
  Future<Iterable<EventDataModel>> eventsWhereParticipate(String userId) =>
      TaskEither.tryCatch(() async {
        final resp = await _dio.get(
          Paths.eventsWhereParticipant(_secretsManager.hostPath, userId),
          options: _optionsManager.opts(),
        );
        final list = resp.data as List;
        return list.cast<Map<String, dynamic>>().map(EventDataModel.fromJson);
      }, (e, _) => '$e')
          .match<Iterable<EventDataModel>>((_) => [], identity)
          .run();
}
