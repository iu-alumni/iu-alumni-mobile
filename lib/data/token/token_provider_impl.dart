import 'package:fpdart/fpdart.dart';

import 'token_manager.dart';
import 'token_provider.dart';

class TokenProviderImpl extends TokenProvider {
  TokenProviderImpl(this._tokenManager);

  final TokenManager _tokenManager;

  @override
  Future<void> init() => _tokenManager.init();

  @override
  Option<String> get token => _tokenManager.token;
}
