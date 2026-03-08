import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/repositories/auth/password_reset_repository.dart';
import '../../common/models/loaded_state.dart';

/// Manages the password reset confirmation step (token from email link).
/// Emits [LoadedState.data] when the password was updated successfully.
class PasswordResetConfirmCubit extends Cubit<LoadedState<Unit>> {
  PasswordResetConfirmCubit(this._repository)
    : super(const LoadedState.init());

  final PasswordResetRepository _repository;

  Future<void> confirmReset({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      emit(const LoadedState.error('Please fill in both password fields'));
      return;
    }
    if (newPassword != confirmPassword) {
      emit(const LoadedState.error('Passwords do not match'));
      return;
    }
    if (newPassword.length < 8) {
      emit(const LoadedState.error('Password must be at least 8 characters'));
      return;
    }
    if (token.isEmpty) {
      emit(const LoadedState.error('Reset token is missing. Please use the link from your email.'));
      return;
    }
    emit(const LoadedState.loading());
    final result = await _repository.confirmReset(
      token: token,
      newPassword: newPassword,
    );
    emit(
      result.match(
        LoadedState.error,
        (_) => const LoadedState.data(unit),
      ),
    );
  }
}
