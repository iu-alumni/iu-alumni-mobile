import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../application/models/register_request.dart';
import '../common/dio_options_manager.dart';
import '../paths.dart';
import '../secrets/secrets_manager.dart';
import '../token/token_manager.dart';
import 'auth_gateway.dart';

class AuthGatewayImpl implements AuthGateway {
  AuthGatewayImpl(
    this._dio,
    this._tokenManager,
    this._dioOptionsManager,
    this._secretsManager,
  );

  final TokenManager _tokenManager;
  final Dio _dio;
  final DioOptionsManager _dioOptionsManager;
  final SecretsManager _secretsManager;

  @override
  Future<Either<String, Unit>> authorize(String email, String password) =>
      TaskEither<String, Either<String, Unit>>.tryCatch(
        () async {
          final response = await _dio.post(
            Paths.login(_secretsManager.hostPath),
            data: {'email': email, 'password': password},
            options: _dioOptionsManager.opts(withToken: false),
          );
          final data = response.data as Map<String, dynamic>;
          if (data['access_token'] case final token?) {
            _tokenManager.set(token);
            return Either.of(unit);
          }
          return Left(data['detail'] ?? 'Unknown Error');
        },
        (e, _) => '$e',
      ).flatMap(TaskEither.fromEither).run();

  @override
  Future<Either<String, Unit>> register(RegisterRequest request) async {
    try {
      await _dio.post(
        Paths.register(_secretsManager.hostPath),
        data: request.toJson(),
        options: _dioOptionsManager.opts(withToken: false),
      );
      return const Right(unit);
    } on DioException catch (e) {
      if (e.response case final r?) {
        if (r.data case Map<String, dynamic> data) {
          if (data['detail'] case String detail) {
            return Left(detail);
          }
        }
      }
      return Left('${e.message}');
    }
  }

  @override
  Future<Either<String, Unit>> sendCode(String email) =>
      TaskEither<String, Unit>.tryCatch(
        () async {
          await _dio.post(
            Paths.resend(_secretsManager.hostPath),
            data: {'email': email},
            options: _dioOptionsManager.opts(withToken: false),
          );
          return unit;
        },
        (e, _) => '$e',
      ).run();

  @override
  Future<Either<String, Unit>> verifyCode({
    required String email,
    required String code,
  }) =>
      TaskEither<String, Either<String, Unit>>.tryCatch(
        () async {
          final response = await _dio.post(
            Paths.verify(_secretsManager.hostPath),
            data: {'email': email, 'verification_code': code},
            options: _dioOptionsManager.opts(withToken: false),
          );
          final data = response.data as Map<String, dynamic>;
          if (data['access_token'] case final token?) {
            _tokenManager.set(token);
            return Either.of(unit);
          }
          return Left(data['detail'] ?? 'Unknown Error');
        },
        (e, _) => '$e',
      ).flatMap(TaskEither.fromEither).run();
}
