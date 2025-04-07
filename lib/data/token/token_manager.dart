import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

class TokenManager {
  TokenManager(this._secureStorage);

  static const _prefKey = 'ui-alumni-access-token';

  final FlutterSecureStorage _secureStorage;

  Option<String> _token = const None();

  Future<void> init() async {
    final token = await _secureStorage.read(key: _prefKey);
    _token = Option.fromNullable(token);
  }

  Option<String> get token => _token;

  void set(String token) {
    _token = Option.of(token);
    _secureStorage.write(key: _prefKey, value: token);
  }
}
