import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<String, Unit>> authorize(String login, String password);
  Future<Either<String, Unit>> verify(
    String login,
    String password,
    String gradYear,
    String firstName,
  );
}
