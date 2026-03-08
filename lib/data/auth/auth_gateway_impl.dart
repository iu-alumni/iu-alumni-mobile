import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ui_alumni_mobile/util/logger.dart';

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
      final data = resp.data as Map<String, dynamic>;
      final msg = data['message'] as String;
      return Right(
        msg.contains('manual') ? const Left(unit) : const Right(unit),
      );
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
  Future<Either<String?, Unit>> sendCode(String email) async {
    try {
      await _dio.post(
        Paths.resend,
        data: {'email': email},
        options: _dioOptionsManager.opts(withToken: false),
      );
      return const Right(unit);
    } on DioException catch (e, st) {
      logger.e('Error while resending the code', error: e, stackTrace: st);
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final detail = data['detail'];
        return Left(detail);
      }
      return const Left(null);
    }
  }

  @override
  Future<Either<String?, Unit>> verifyCode({
    required String email,
    required String code,
  }) async {
    try {
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
      return const Left(null);
    } on DioException catch (e, st) {
      logger.e('Error while resending the code', error: e, stackTrace: st);
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final detail = data['detail'];
        return Left(detail);
      }
      return const Left(null);
    }
  }

  @override
  Future<Either<String, String>> loginOtpRequest({
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        Paths.loginOtpRequest,
        data: {'email': email},
        options: _dioOptionsManager.opts(withToken: false),
      );
      final data = response.data as Map<String, dynamic>;
      if (data['session_token'] case final String token) {
        return Right(token);
      }
      return const Left('Unexpected response from server');
    } on DioException catch (e, st) {
      logger.e('Error requesting OTP', error: e, stackTrace: st);
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final detail = data['detail'];
        if (detail is String) return Left(detail);
      }
      return Left(e.message ?? 'Unknown error');
    } catch (e) {
      return Left('$e');
    }
  }

  @override
  Future<Either<String, Unit>> loginOtpVerify({
    required String sessionToken,
    required String code,
  }) async {
    try {
      final response = await _dio.post(
        Paths.loginOtpVerify,
        data: {'session_token': sessionToken, 'code': code},
        options: _dioOptionsManager.opts(withToken: false),
      );
      final data = response.data as Map<String, dynamic>;
      if (data['access_token'] case final String token) {
        _tokenManager.set(token);
        return Either.of(unit);
      }
      return const Left('Unexpected response from server');
    } on DioException catch (e, st) {
      logger.e('Error verifying OTP', error: e, stackTrace: st);
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final detail = data['detail'];
        if (detail is String) return Left(detail);
      }
      return Left(e.message ?? 'Unknown error');
    } catch (e) {
      return Left('$e');
    }
  }

  @override
  Future<Either<String, Unit>> passwordResetRequest(String email) async {
    try {
      await _dio.post(
        Paths.passwordResetRequest,
        data: {'email': email},
        options: _dioOptionsManager.opts(withToken: false),
      );
      return Either.of(unit);
    } on DioException catch (e, st) {
      logger.e('Error requesting password reset', error: e, stackTrace: st);
      return Left(e.message ?? 'Unknown error');
    } catch (e) {
      return Left('$e');
    }
  }

  @override
  Future<Either<String, Unit>> passwordResetConfirm({
    required String token,
    required String newPassword,
  }) async {
    try {
      await _dio.post(
        Paths.passwordResetConfirm,
        data: {'token': token, 'new_password': newPassword},
        options: _dioOptionsManager.opts(withToken: false),
      );
      return Either.of(unit);
    } on DioException catch (e, st) {
      logger.e('Error confirming password reset', error: e, stackTrace: st);
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final detail = data['detail'];
        if (detail is String) return Left(detail);
      }
      return Left(e.message ?? 'Unknown error');
    } catch (e) {
      return Left('$e');
    }
  }
}
