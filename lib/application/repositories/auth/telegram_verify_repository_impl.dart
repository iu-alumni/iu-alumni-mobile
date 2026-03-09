import 'package:fpdart/fpdart.dart';

import '../../../data/auth/auth_gateway.dart';
import 'telegram_verify_repository.dart';

class TelegramVerifyRepositoryImpl implements TelegramVerifyRepository {
  TelegramVerifyRepositoryImpl(this._authGateway);

  final AuthGateway _authGateway;

  @override
  Future<Either<String, Unit>> requestVerification() =>
      _authGateway.telegramVerifyRequest();
}
