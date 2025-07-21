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
}
