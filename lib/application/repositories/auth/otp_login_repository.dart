import 'package:fpdart/fpdart.dart';

abstract interface class OtpLoginRepository {
  /// Requests an OTP code by validating email only.
  /// On success, stores the session_token internally for the verify step.
  Future<Either<String, Unit>> requestOtp({
    required String email,
  });

  /// Verifies the OTP code using the stored session_token.
  Future<Either<String, Unit>> verifyOtp(String code);
}
