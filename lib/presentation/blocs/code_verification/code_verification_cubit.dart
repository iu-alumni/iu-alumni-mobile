import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/code_verification_state.dart';

class CodeVerificationCubit extends Cubit<CodeVerificationState> {
  CodeVerificationCubit(this._repo)
      : super(
          CodeVerificationState(
            verification: const LoadedState.init(),
            resend: const LoadedState.init(),
            code: '',
          ),
        );

  final AuthRepository _repo;

  bool get _codeIsOk =>
      state.code.length == 6 && state.code.contains(RegExp(r'[0-9]'));

  void sinkCode(String code) => emit(state.copyWith(code: code));

  void checkCode() {
    if (_codeIsOk) {
      _rawVerify();
    }
  }

  void verify() async {
    if (!_codeIsOk) {
      emit(
        state.copyWith(
          verification:
              const LoadedState.error('Verification code is incorrect'),
        ),
      );
      return;
    }
    _rawVerify();
  }

  void _rawVerify() async {
    emit(state.copyWith(verification: const LoadedState.loading()));
    final result = await _repo.verifyCode(state.code);
    emit(
      state.copyWith(
        verification: result.match(
          (_) => const LoadedState.error('Code was not verified'),
          LoadedState.data,
        ),
      ),
    );
  }

  void resend() async {
    emit(state.copyWith(resend: const LoadedState.loading()));
    final result = await _repo.sendCode();
    emit(
      state.copyWith(
        resend: result.match(
          (_) => const LoadedState.error('Could not resend the code'),
          LoadedState.data,
        ),
      ),
    );
  }
}
