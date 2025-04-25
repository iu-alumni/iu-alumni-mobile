import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../common/models/loaded_state.dart';

class AuthCubit extends Cubit<LoadedState> {
  AuthCubit(this._authRepository) : super(const LoadedState.init());

  final AuthRepository _authRepository;

  String? _validateEmail(String email) => email.contains('@innopolis.')
      ? null
      : 'The email must have the "innopolis" mail server';

  Future<void> authorize(String login, String password) async {
    final error = _validateEmail(login);
    if (error != null) {
      emit(LoadedState.error(error));
      return;
    }
    emit(const LoadedState.loading());
    final result = await _authRepository.authorize(login, password);
    emit(
      result.match(
        (_) => const LoadedState.error(
          'If you are an alumnus and haven\'t created an account in this app, proceed with registration',
        ),
        (_) => const LoadedState.data(unit),
      ),
    );
  }
}
