import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<String, Unit>> authorize(String login, String password);
}
