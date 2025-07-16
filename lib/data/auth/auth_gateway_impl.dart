import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../application/models/register_request.dart';
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
      TaskEither<String, Either<String, Unit>>.tryCatch(() async {
        final response = await _dio.post(
          Paths.login,
          data: {'email': email, 'password': password},
          options: _dioOptionsManager.opts(withToken: false),
        );
        final data = response.data as Map<String, dynamic>;
        if (data['access_token'] case final token?) {
          _tokenManager.set(token);
          return Either.of(unit);
        }
        return Left(data['detail'] ?? 'Unknown Error');
      }, (e, _) => '$e').flatMap(TaskEither.fromEither).run();

  @override
  Future<Either<String, Either<Unit, Unit>>> register(
    RegisterRequest request,
  ) async {
    try {
      final resp = await _dio.post(
        Paths.register,
        data: request.toJson(),
        options: _dioOptionsManager.opts(withToken: false),
      );
      if (resp.statusCode == 201) {
        return const Right(Left(unit));
      }
      return const Right(Right(unit));
    } on DioException catch (e) {
      if (e.response case final r?) {
        if (r.data case final Map<String, dynamic> data) {
          if (data['detail'] case final String detail) {
            return Left(detail);
          }
          if (data['detail'] case final List details) {
            return Left(
              details
                  .map((d) => d is Map<String, dynamic> ? d['msg'] : null)
                  .nonNulls
                  .join('\n'),
            );
          }
        }
      }
      return Left('${e.message}');
    } catch (e) {
      return Left('$e');
    }
  }

  @override
  Future<Either<String, Unit>> sendCode(String email) =>
      TaskEither<String, Unit>.tryCatch(() async {
        await _dio.post(
          Paths.resend,
          data: {'email': email},
          options: _dioOptionsManager.opts(withToken: false),
        );
        return unit;
      }, (e, _) => '$e').run();

  @override
  Future<Either<String, Unit>> verifyCode({
    required String email,
    required String code,
  }) => TaskEither<String, Either<String, Unit>>.tryCatch(() async {
    final response = await _dio.post(
      Paths.verify,
      data: {'email': email, 'verification_code': code},
      options: _dioOptionsManager.opts(withToken: false),
    );
    final data = response.data as Map<String, dynamic>;
    if (data['access_token'] case final token?) {
      _tokenManager.set(token);
      return Either.of(unit);
    }
    return Left(data['detail'] ?? 'Unknown Error');
  }, (e, _) => '$e').flatMap(TaskEither.fromEither).run();
}
