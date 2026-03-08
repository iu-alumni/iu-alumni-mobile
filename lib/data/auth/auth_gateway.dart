import 'package:fpdart/fpdart.dart';

import '../../application/models/register_request.dart';

abstract interface class AuthGateway {
  Future<Either<String, Unit>> authorize(String email, String password);

  /// = Error message
  /// | Manual verification
  ///   | Success
  Future<Either<String, Either<Unit, Unit>>> register(RegisterRequest request);
  Future<Either<String?, Unit>> verifyCode({
    required String email,
    required String code,
  });
  Future<Either<String?, Unit>> sendCode(String email);

  /// Requests an OTP code to be sent via email.
  /// Returns the session_token needed to complete verification.
  Future<Either<String, String>> loginOtpRequest({
    required String email,
    required String password,
  });

  /// Verifies the OTP code and returns a JWT on success.
  Future<Either<String, Unit>> loginOtpVerify({
    required String sessionToken,
    required String code,
  });

  /// Requests a password reset link to be sent to the given email.
  /// Always succeeds (even if email not found) to prevent enumeration.
  Future<Either<String, Unit>> passwordResetRequest(String email);

  /// Confirms a password reset using the token from the email link.
  Future<Either<String, Unit>> passwordResetConfirm({
    required String token,
    required String newPassword,
  });
}
