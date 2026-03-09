import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/repositories/auth/telegram_otp_login_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/telegram_otp_login_state.dart';

class TelegramOtpLoginCubit extends Cubit<TelegramOtpLoginState> {
  TelegramOtpLoginCubit(this._repository)
    : super(
        TelegramOtpLoginState(
          request: const LoadedState.init(),
          verify: const LoadedState.init(),
          code: '',
        ),
      );

  final TelegramOtpLoginRepository _repository;

  String? _validateEmail(String email) =>
      (email.contains('@innopolis.university') ||
          email.contains('@innopolis.ru'))
      ? null
      : 'The email must contain either "innopolis.university" or "innopolis.ru"';

  Future<void> requestOtp({required String email}) async {
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

  void reset() => emit(TelegramOtpLoginState(
    request: const LoadedState.init(),
    verify: const LoadedState.init(),
    code: '',
  ));
}
