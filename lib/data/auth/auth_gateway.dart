import 'package:fpdart/fpdart.dart';

abstract interface class AuthGateway {
  Future<Either<String, Unit>> authorize(String email, String password);
  Future<Either<String, Unit>> verify(
    String email,
    String password,
    String graduationYear,
    String firstName,
  );
}
