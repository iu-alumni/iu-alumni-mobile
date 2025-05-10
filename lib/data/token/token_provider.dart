import 'package:fpdart/fpdart.dart';

abstract class TokenProvider {
  Future<void> init();

  Option<String> get token;

  void clear();
}
