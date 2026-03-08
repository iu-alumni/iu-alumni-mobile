import 'package:fpdart/fpdart.dart';

import '../../../data/auth/auth_gateway.dart';
import 'password_reset_repository.dart';

class PasswordResetRepositoryImpl implements PasswordResetRepository {
  PasswordResetRepositoryImpl(this._authGateway);

  final AuthGateway _authGateway;

  @override
  Future<Either<String, Unit>> requestReset(String email) =>
      _authGateway.passwordResetRequest(email);

  @override
  Future<Either<String, Unit>> confirmReset({
    required String token,
    required String newPassword,
  }) => _authGateway.passwordResetConfirm(
    token: token,
    newPassword: newPassword,
  );
}
