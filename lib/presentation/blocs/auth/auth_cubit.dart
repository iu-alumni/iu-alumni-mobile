import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../common/models/loaded_state.dart';

class AuthCubit extends Cubit<LoadedState> {
  AuthCubit(
    this._authRepository,
    this._reporter,
  ) : super(const LoadedState.init());

  final AuthRepository _authRepository;
  final Reporter _reporter;

  String? _validateEmail(String email) => email.contains('@innopolis.')
      ? null
      : 'The email must have the "innopolis" mail server';

  Future<void> authorize(String login, String password) async {
    final error = _validateEmail(login);
    if (error != null) {
      _reporter.reportAuthError(error, AppLocation.authScreen);
      emit(LoadedState.error(error));
      return;
    }
    emit(const LoadedState.loading());
    final result = await _authRepository.authorize(login, password);
    emit(
      result.match(
        (e) {
          final errorMsg =
              'If you are an alumnus and haven\'t created an account in this app yet, proceed with registration';
          _reporter.reportAuthError(errorMsg, AppLocation.authScreen);
          return LoadedState.error(errorMsg);
        },
        (_) {
          _reporter.reportAuthSuccessful(AppLocation.authScreen);
          return const LoadedState.data(unit);
        },
      ),
    );
  }
}
