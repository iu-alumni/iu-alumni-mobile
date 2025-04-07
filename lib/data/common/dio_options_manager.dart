import 'package:dio/dio.dart';

import '../token/token_provider.dart';

class DioOptionsManager {
  DioOptionsManager(this._tokenProvider);

  final TokenProvider _tokenProvider;

  String? get _token => _tokenProvider.token.toNullable();

  Options opts({bool withToken = true}) => Options(
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          if (_token case final tkn? when withToken)
            'Authorization': 'Bearer $tkn',
        },
      );
}
