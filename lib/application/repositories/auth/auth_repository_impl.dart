import 'package:fpdart/fpdart.dart';

import '../../../data/auth/auth_gateway.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authGateway);

  final AuthGateway _authGateway;

  @override
  Future<Either<String, Unit>> authorize(String login, String password) =>
      _authGateway.authorize(login, password);
}
