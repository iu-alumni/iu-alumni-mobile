import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ui_alumni_mobile/data/common/dio_options_manager.dart';
import 'package:ui_alumni_mobile/data/events/events_gateway_impl.dart';
import 'package:ui_alumni_mobile/data/token/token_provider.dart';

class _TokenProvider extends TokenProvider {
  @override
  void clear() {}

  @override
  Future<void> init() async {}

  @override
  Option<String> get token => const Some('test-token');
}

class _CoverFallbackAdapter implements HttpClientAdapter {
  final requestedPaths = <String>[];

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestedPaths.add(options.uri.path);
    if (options.uri.path.endsWith('/cover')) {
      return ResponseBody.fromString(
        jsonEncode({'detail': 'temporary cover route failure'}),
        503,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }
    return ResponseBody.fromString(
      jsonEncode({'cover': 'base64-cover'}),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

void main() {
  test('falls back to the full event when the cover endpoint fails', () async {
    final adapter = _CoverFallbackAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://api.example.test'))
      ..httpClientAdapter = adapter;
    final gateway = EventsGatewayImpl(dio, DioOptionsManager(_TokenProvider()));

    final cover = await gateway.loadCover('event-1');

    expect(cover, 'base64-cover');
    expect(adapter.requestedPaths, [
      '/api/v1/events/event-1/cover',
      '/api/v1/events/event-1',
    ]);
  });
}
