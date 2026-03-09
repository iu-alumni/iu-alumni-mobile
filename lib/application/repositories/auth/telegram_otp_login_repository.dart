import 'package:fpdart/fpdart.dart';

abstract interface class TelegramOtpLoginRepository {
  Future<Either<String, Unit>> requestOtp({required String email});
  Future<Either<String, Unit>> verifyOtp(String code);
}
