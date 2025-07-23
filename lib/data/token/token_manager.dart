import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

import '../../util/logger.dart';

class TokenManager {
  TokenManager(this._secureStorage);

  static const _tokenKey = 'iu-alumni-access-token';

  final FlutterSecureStorage _secureStorage;

  Option<String> _token = const None();

  Future<void> init() async {
    _token = Option.fromNullable(await _secureStorage.read(key: _tokenKey));
    logger.d('TOKEN STORED: $token');
  }

  Option<String> get token => _token;

  void set(String token) {
    _token = Option.of(token);
    _secureStorage.write(key: _tokenKey, value: token);
  }

  void clear() {
    _token = const None();
    _secureStorage.delete(key: _tokenKey);
  }
}
