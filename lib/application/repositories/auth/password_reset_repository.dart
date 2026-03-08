import 'package:fpdart/fpdart.dart';

abstract interface class PasswordResetRepository {
  /// Requests a password reset email. Always reports success to avoid
  /// account enumeration — even when the email is not registered.
  Future<Either<String, Unit>> requestReset(String email);

  /// Confirms the new password using the token from the reset email link.
  Future<Either<String, Unit>> confirmReset({
    required String token,
    required String newPassword,
  });
}
