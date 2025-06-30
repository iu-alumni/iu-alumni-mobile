import 'package:fpdart/fpdart.dart';

import '../../models/register_request.dart';

abstract interface class AuthRepository {
  Future<Either<String, Unit>> authorize(String login, String password);

  Future<Either<String, Unit>> register(RegisterRequest request);

  Future<Either<String, Unit>> verifyCode(String code);

  Future<Either<String, Unit>> sendCode();

  void cleanEmail();
}
