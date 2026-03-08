import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/repositories/auth/password_reset_repository.dart';
import '../../common/models/loaded_state.dart';

/// Manages the "Forgot password?" request step.
/// Emits [LoadedState.data] when the email was submitted successfully —
/// the user should then be told to check their inbox.
class PasswordResetRequestCubit extends Cubit<LoadedState<Unit>> {
  PasswordResetRequestCubit(this._repository)
    : super(const LoadedState.init());

  final PasswordResetRepository _repository;

  Future<void> requestReset(String email) async {
    if (email.isEmpty) {
      emit(const LoadedState.error('Please enter your email address'));
      return;
    }
    emit(const LoadedState.loading());
    final result = await _repository.requestReset(email);
    emit(
      result.match(
        LoadedState.error,
        (_) => const LoadedState.data(unit),
      ),
    );
  }

  void reset() => emit(const LoadedState.init());
}
