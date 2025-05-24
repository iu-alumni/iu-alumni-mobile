import 'package:flutter/foundation.dart';
import 'package:flutter_encrypt_plus/flutter_encrypt_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/logger.dart';

class TokenManager {
  TokenManager(this._secureStorage, this._sharedPrefs);

  static const _tokenKey = 'ui-alumni-access-token';
  static const _webSalt = String.fromEnvironment('ui_alumni_web_salt');

  final FlutterSecureStorage _secureStorage;
  final SharedPreferencesAsync _sharedPrefs;

  Option<String> _token = const None();

  Future<Option<String>> _tokenWeb() async {
    final token = await _sharedPrefs.getString(_tokenKey);
    return Option.fromNullable(token).map(
      (t) => encrypt.decodeString(t, _webSalt),
    );
  }

  Future<Option<String>> _tokenMobile() async =>
      Option.fromNullable(await _secureStorage.read(key: _tokenKey));

  Future<void> init() async {
    final fun = kIsWeb || kIsWasm ? _tokenWeb : _tokenMobile;
    _token = await fun();
    logger.d("TOKEN STORED: $token");
  }

  Option<String> get token => _token;

  void _setWeb(String value) {
    final encr = encrypt.encodeString(value, _webSalt);
    _sharedPrefs.setString(_tokenKey, encr);
    logger.d("TOKEN SET: $value, encr as $encr");
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
