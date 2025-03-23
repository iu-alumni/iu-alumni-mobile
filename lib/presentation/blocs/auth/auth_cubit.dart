import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState.idle());

  final AuthRepository _authRepository;

  Future<void> authorize(String login, String password) async {
    emit(const AuthState.loading());
    // final result = await _authRepository.authorize(login, password);
    await Future.delayed(const Duration(seconds: 1));
    final result = Either<String, Unit>.of(unit);
    emit(result.match(AuthState.error, (_) => const AuthState.authorized()));
  }
}
