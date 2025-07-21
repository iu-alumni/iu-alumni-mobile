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
      state.code.length == 6 && state.code.contains(RegExp('[0-9]'));

  void sinkCode(String code) => emit(state.copyWith(code: code));

  void checkCode() {
    if (_codeIsOk) {
      _rawVerify();
    }
  }

  Future<void> verify() async {
    if (!_codeIsOk) {
      emit(
        state.copyWith(
          verification: const LoadedState.error(
            'Verification code is incorrect',
          ),
        ),
      );
      return;
    }
    await _rawVerify();
  }

  Future<void> _rawVerify() async {
    emit(state.copyWith(verification: const LoadedState.loading()));
    final result = await _repo.verifyCode(state.code);
    emit(
      state.copyWith(
        verification: result.match(
          (e) => LoadedState.error(e ?? 'Code was not verified'),
          LoadedState.data,
        ),
      ),
    );
  }

  Future<void> resend() async {
    emit(state.copyWith(resend: const LoadedState.loading()));
    final result = await _repo.sendCode();
    emit(
      state.copyWith(
        resend: result.match(
          (e) => LoadedState.error(e ?? 'Could not resend the code'),
          LoadedState.data,
        ),
      ),
    );
  }

  void setEmail(String email) => _repo.setEmail(email);

  void dispose() {
    emit(
      CodeVerificationState(
        verification: const LoadedState.init(),
        resend: const LoadedState.init(),
        code: '',
      ),
    );
    _repo.cleanEmail();
  }
}
