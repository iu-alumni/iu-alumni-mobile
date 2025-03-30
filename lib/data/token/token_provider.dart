import 'package:fpdart/fpdart.dart';

class TokenProvider {
  Option<String> _token = const None();

  Option<String> get token => _token;

  void set(String token) => _token = Option.of(token);
}
