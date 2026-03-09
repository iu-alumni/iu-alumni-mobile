import 'package:fpdart/fpdart.dart';

abstract interface class TelegramVerifyRepository {
  Future<Either<String, Unit>> requestVerification();
}
