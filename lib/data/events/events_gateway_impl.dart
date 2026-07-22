import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../application/models/paginated_result.dart';
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
  Future<Either<String, String>> addEvent(EventRequestDataModel event) async {
    final result = await TaskEither.tryCatch(() async {
      final data = jsonEncode(event.toJson());
      final response = await _dio.post(
        Paths.events,
        data: data,
        options: _optionsManager.opts(),
      );
      final json = response.data as Map<String, dynamic>;
      return json['id'] as String;
    }, (e, _) => _extractErrorMessage(e)).run();
    return result;
  }

  @override
  Future<PaginatedResult<EventDataModel>> loadEvents({String? cursor, int limit = 50}) async {
    try {
      final resp = await _dio.get(
        Paths.events,
        options: _optionsManager.opts(),
        queryParameters: {
          if (cursor != null) 'cursor': cursor,
          'limit': limit,
        },
      );
      final data = resp.data;
      if (data is! Map<String, dynamic> || data['items'] is! List) {
        return const PaginatedResult(items: []);
      }
      return PaginatedResult.fromJson(
        data,
        (e) => EventDataModel.fromJson(e as Map<String, dynamic>),
      );
    } catch (_) {
      return const PaginatedResult(items: []);
    }
  }

  @override
  Future<PaginatedResult<EventDataModel>> loadPendingEvents({String? cursor, int limit = 50}) async {
    try {
      final resp = await _dio.get(
        Paths.eventsPending,
        options: _optionsManager.opts(),
        queryParameters: {
          if (cursor != null) 'cursor': cursor,
          'limit': limit,
        },
      );
      final data = resp.data;
      if (data is! Map<String, dynamic> || data['items'] is! List) {
        return const PaginatedResult(items: []);
      }
      return PaginatedResult.fromJson(
        data,
        (e) => EventDataModel.fromJson(e as Map<String, dynamic>),
      );
    } catch (_) {
      return const PaginatedResult(items: []);
    }
  }

  @override
  Future<bool> deleteEvent(String eventId) async {
    final result = await TaskEither.tryCatch(
      () => _dio.delete(
        Paths.eventWithId(eventId),
        options: _optionsManager.opts(),
      ),
      (e, _) => '$e',
    ).run();
    return result.isRight();
  }

  @override
  Future<Either<String, Unit>> updateEvent(
    String eventId,
    EventRequestDataModel event,
  ) async {
    final result = await TaskEither.tryCatch(() async {
      final requestModel = event.toJson();
      await _dio.put(
        Paths.eventWithId(eventId),
        options: _optionsManager.opts(),
        data: jsonEncode(requestModel),
      );
      return unit;
    }, (e, _) => _extractErrorMessage(e)).run();
    return result;
  }

  /// Turns a Dio/API failure into a message a user can act on.
  ///
  /// Mirrors the FastAPI error shapes: `{"detail": "..."}` for plain errors
  /// and `{"detail": [{"loc": [...], "msg": "..."}]}` for validation errors.
  String _extractErrorMessage(Object error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        final detail = data['detail'];
        if (detail is String) {
          return detail;
        }
        if (detail is List) {
          final messages = detail
              .whereType<Map<String, dynamic>>()
              .map((d) {
                final loc = d['loc'];
                final field = loc is List && loc.isNotEmpty
                    ? loc.last.toString()
                    : null;
                final msg = (d['msg'] as String?)?.replaceFirst(
                  'Value error, ',
                  '',
                );
                if (msg == null) {
                  return null;
                }
                return field != null ? '${_titleCase(field)}: $msg' : msg;
              })
              .nonNulls
              .toList();
          if (messages.isNotEmpty) {
            return messages.join('\n');
          }
        }
      }
      return switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          'The request timed out. Please check your connection and try again.',
        DioExceptionType.connectionError =>
          'Could not reach the server. Please check your connection.',
        _ => 'Something went wrong${error.response?.statusCode != null ? ' (${error.response!.statusCode})' : ''}.',
      };
    }
    return '$error';
  }

  String _titleCase(String field) =>
      field.isEmpty ? field : '${field[0].toUpperCase()}${field.substring(1)}';

  @override
  Future<bool> participate(String eventId, String userId) async {
    final result = await TaskEither.tryCatch(
      () => _dio.post(
        Paths.participants(eventId),
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
        Paths.leave(eventId),
        options: _optionsManager.opts(),
        queryParameters: {'participant_id': userId},
      ),
      (e, _) => '$e',
    ).run();
    return result.isRight();
  }

  @override
  Future<Iterable<EventDataModel>> eventsIOwn() => TaskEither.tryCatch(
    () async {
      final resp = await _dio.get(
        Paths.eventsOwner,
        options: _optionsManager.opts(),
      );
      final list = resp.data as List;
      return list.cast<Map<String, dynamic>>().map(EventDataModel.fromJson);
    },
    (e, _) => '$e',
  ).match<Iterable<EventDataModel>>((_) => [], identity).run();

  @override
  Future<Iterable<EventDataModel>> eventsWhereParticipate(String userId) =>
      TaskEither.tryCatch(
        () async {
          final resp = await _dio.get(
            Paths.eventsWhereParticipant(userId),
            options: _optionsManager.opts(),
          );
          final list = resp.data as List;
          return list.cast<Map<String, dynamic>>().map(EventDataModel.fromJson);
        },
        (e, _) => '$e',
      ).match<Iterable<EventDataModel>>((_) => [], identity).run();
}
