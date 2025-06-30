import 'package:fpdart/fpdart.dart';

import '../../../data/auth/auth_gateway.dart';
import '../../../util/logger.dart';
import '../../models/register_request.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authGateway);

  final AuthGateway _authGateway;

  String? _registrationEmail;

  @override
  Future<Either<String, Unit>> authorize(String login, String password) =>
      _authGateway.authorize(login, password);

  @override
  Future<Either<String, Unit>> register(RegisterRequest request) async {
    final result = await _authGateway.register(request);
    if (result.isRight()) {
      // Save the email for future code verification
      _registrationEmail = request.email;
    }
    return result;
  }

  @override
  Future<Either<String, Unit>> sendCode() async {
    if (_registrationEmail case final s?) {
      return _authGateway.sendCode(s);
    }
    final error = 'Registration email was not saved somehow';
    logger.w(error);
    return Left(error);
  }

  @override
  Future<Either<String, Unit>> verifyCode(String code) async {
    if (_registrationEmail case final s?) {
      return _authGateway.verifyCode(email: s, code: code);
    }
    final error = 'Registration email was not saved somehow';
    logger.w(error);
    return Left(error);
  }

  @override
  void cleanEmail() {
    _registrationEmail = null;
  }
}
