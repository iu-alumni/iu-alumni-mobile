import 'package:fpdart/fpdart.dart';
import 'package:ui_alumni_mobile/util/logger.dart';

import '../../../data/auth/auth_gateway.dart';
import 'telegram_otp_login_repository.dart';

class TelegramOtpLoginRepositoryImpl implements TelegramOtpLoginRepository {
  TelegramOtpLoginRepositoryImpl(this._authGateway);

  final AuthGateway _authGateway;

  String? _sessionToken;

  @override
  Future<Either<String, Unit>> requestOtp({required String email}) async {
    final result = await _authGateway.loginTelegramOtpRequest(email: email);
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
    final result = await _authGateway.loginTelegramOtpVerify(
      sessionToken: token,
      code: code,
    );
    if (result.isRight()) {
      _sessionToken = null;
    }
    return result;
  }
}
