import 'package:fpdart/fpdart.dart';

abstract interface class AuthGateway {
  Future<Either<String, Unit>> authorize(String email, String password);
}