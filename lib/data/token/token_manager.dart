import 'package:flutter/foundation.dart';
import 'package:flutter_encrypt_plus/flutter_encrypt_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/logger.dart';
import '../secrets/secrets_manager.dart';

class TokenManager {
  TokenManager(this._secureStorage, this._sharedPrefs, this._secretsManager);

  static const _tokenKey = 'iu-alumni-access-token';

  final FlutterSecureStorage _secureStorage;
  final SharedPreferencesAsync _sharedPrefs;
  final SecretsManager _secretsManager;

  Option<String> _token = const None();

  Future<Option<String>> _tokenWeb() async {
    final maybeToken = await _sharedPrefs.getString(_tokenKey);
    return Option.Do((mb) {
      final salt = mb(Option.fromNullable(_secretsManager.webSalt));
      final token = mb(Option.fromNullable(maybeToken));
      return encrypt.decodeString(token, salt);
    });
  }

  Future<Option<String>> _tokenMobile() async =>
      Option.fromNullable(await _secureStorage.read(key: _tokenKey));

  Future<void> init() async {
    final fun = kIsWeb || kIsWasm ? _tokenWeb : _tokenMobile;
    _token = await fun();
    logger.d('TOKEN STORED: $token');
  }

  Option<String> get token => _token;

  void _setWeb(String value) {
    final salt = _secretsManager.webSalt;
    if (salt == null) {
      logger.e('SALT wan\'t found in env');
      return;
    }
    final encr = encrypt.encodeString(value, salt);
    _sharedPrefs.setString(_tokenKey, encr);
    logger.d('TOKEN SET: $value, encr as $encr');
  }

  void _setMobile(String value) {
    _secureStorage.write(key: _tokenKey, value: value);
  }

  void set(String token) {
    _token = Option.of(token);
    final fun = kIsWeb || kIsWasm ? _setWeb : _setMobile;
    fun(token);
  }

  void clear() {
    _token = const None();
    _secureStorage.delete(key: _tokenKey);
  }
}
