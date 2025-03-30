import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../paths.dart';
import '../token/token_provider.dart';
import 'auth_gateway.dart';

class AuthGatewayImpl implements AuthGateway {
  AuthGatewayImpl(this._dio, this._tokenProvider);

  final TokenProvider _tokenProvider;
  final Dio _dio;

  @override
  Future<Either<String, Unit>> authorize(String email, String password) =>
      TaskEither<String, Unit>.tryCatch(() async {
        final response = await _dio.post(
          Paths.login,
          data: {'email': email, 'password': password},
        );
        final data = response.data as Map<String, dynamic>;
        if (data['access_token'] case final token?) {
          _tokenProvider.set(token);
          return unit;
        }
        return data['detail'] ?? 'Unknown Error';
      }, (e, _) => '$e').run();
}
