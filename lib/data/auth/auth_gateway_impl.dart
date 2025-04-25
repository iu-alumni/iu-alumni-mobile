import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../common/dio_options_manager.dart';
import '../paths.dart';
import '../token/token_manager.dart';
import 'auth_gateway.dart';

class AuthGatewayImpl implements AuthGateway {
  AuthGatewayImpl(this._dio, this._tokenManager, this._dioOptionsManager);

  final TokenManager _tokenManager;
  final Dio _dio;
  final DioOptionsManager _dioOptionsManager;

  @override
  Future<Either<String, Unit>> authorize(String email, String password) =>
      TaskEither<String, Unit>.tryCatch(
        () async {
          final response = await _dio.post(
            Paths.login,
            data: {'email': email, 'password': password},
            options: _dioOptionsManager.opts(withToken: false),
          );
          final data = response.data as Map<String, dynamic>;
          if (data['access_token'] case final token?) {
            _tokenManager.set(token);
            return unit;
          }
          return data['detail'] ?? 'Unknown Error';
        },
        (e, _) => '$e',
      ).run();

  @override
  Future<Either<String, Unit>> verify(
    String email,
    String password,
    String graduationYear,
    String firstName,
  ) =>
      TaskEither<String, Unit>.tryCatch(
        () async {
          final response = await _dio.post(
            Paths.verify,
            data: {
              'email': email,
              'password': password,
              'graduation_year': graduationYear,
              'first_name': firstName,
            },
            options: _dioOptionsManager.opts(withToken: false),
          );
          final data = response.data as Map<String, dynamic>;
          if (data['access_token'] case final token?) {
            _tokenManager.set(token);
            return unit;
          }
          return data['detail'] ?? 'Unknown Error';
        },
        (e, _) => '$e',
      ).run();
}
