import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/repositories/auth/otp_login_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/otp_login_state.dart';

class OtpLoginCubit extends Cubit<OtpLoginState> {
  OtpLoginCubit(this._repository)
    : super(
        OtpLoginState(
          request: const LoadedState.init(),
          verify: const LoadedState.init(),
          code: '',
        ),
      );

  final OtpLoginRepository _repository;

  String? _validateEmail(String email) =>
      (email.contains('@innopolis.university') ||
          email.contains('@innopolis.ru'))
      ? null
      : 'The email must contain either "innopolis.university" or "innopolis.ru"';

  Future<void> requestOtp({
    required String email,
  }) async {
    if (email.isEmpty) {
      emit(state.copyWith(
        request: const LoadedState.error('Please enter your email'),
      ));
      return;
    }
    final emailError = _validateEmail(email);
    if (emailError != null) {
      emit(state.copyWith(request: LoadedState.error(emailError)));
      return;
    }
    emit(state.copyWith(request: const LoadedState.loading()));
    final result = await _repository.requestOtp(email: email);
    emit(state.copyWith(
      request: result.match(
        LoadedState.error,
        (_) => const LoadedState.data(unit),
      ),
    ));
  }

  void sinkCode(String code) => emit(state.copyWith(code: code));

  void checkCode() {
    if (_codeIsValid) {
      _rawVerify();
    }
  }

  Future<void> verifyOtp() async {
    if (!_codeIsValid) {
      emit(state.copyWith(
        verify: const LoadedState.error('Please enter a valid 6-digit code'),
      ));
      return;
    }
    await _rawVerify();
  }

  Future<void> _rawVerify() async {
    emit(state.copyWith(verify: const LoadedState.loading()));
    final result = await _repository.verifyOtp(state.code);
    emit(state.copyWith(
      verify: result.match(
        LoadedState.error,
        (_) => const LoadedState.data(unit),
      ),
    ));
  }

  bool get _codeIsValid =>
      state.code.length == 6 && RegExp(r'^\d{6}$').hasMatch(state.code);

  /// Resets both request and verify states so the flow can restart.
  void reset() => emit(OtpLoginState(
    request: const LoadedState.init(),
    verify: const LoadedState.init(),
    code: '',
  ));
}
