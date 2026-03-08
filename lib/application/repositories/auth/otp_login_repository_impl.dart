import 'package:fpdart/fpdart.dart';
import 'package:ui_alumni_mobile/util/logger.dart';

import '../../../data/auth/auth_gateway.dart';
import 'otp_login_repository.dart';

class OtpLoginRepositoryImpl implements OtpLoginRepository {
  OtpLoginRepositoryImpl(this._authGateway);

  final AuthGateway _authGateway;

  String? _sessionToken;

  @override
  Future<Either<String, Unit>> requestOtp({
    required String email,
    required String password,
  }) async {
    final result = await _authGateway.loginOtpRequest(
      email: email,
      password: password,
    );
    return result.map((token) {
      _sessionToken = token;
      return unit;
    });
  }

  @override
  Future<Either<String, Unit>> verifyOtp(String code) async {
    final token = _sessionToken;
    if (token == null) {
      const error = 'Session token is missing. Please request the code again.';
      logger.w(error);
      return const Left(error);
    }
    final result = await _authGateway.loginOtpVerify(
      sessionToken: token,
      code: code,
    );
    if (result.isRight()) {
      _sessionToken = null;
    }
    return result;
  }
}
