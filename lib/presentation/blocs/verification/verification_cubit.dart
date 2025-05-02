import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../common/models/loaded_state.dart';
import '../models/verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this._authRepository, this._reporter)
      : super(
          VerificationState(verification: const LoadedState.init()),
        );

  final AuthRepository _authRepository;
  final Reporter _reporter;

  String? _validateEmail(String email) => email.contains('@innopolis.')
      ? null
      : 'The email must have the "innopolis" mail server';

  String? _validatePassword(String pass) => pass.length < 8
      ? 'The password needs to contain at least 8 characters'
      : null;

  (String, String, String, String)? _verificationData() => switch ((
        state.email,
        state.password,
        state.graduationYear,
        state.firstName
      )) {
        (final a?, final b?, final c?, final d?) => (a, b, '$c', d),
        _ => null,
      };

  void verify() async {
    final data = _verificationData();
    if (data == null) {
      emit(
        state.copyWith(
          verification: const LoadedState.error(
            'Please, specify all fields to complete the verification',
          ),
        ),
      );
      return;
    }
    if (_validateEmail(data.$1) case final error?) {
      _reporter.reportAuthError(error, AppLocation.verificationScreen);
      emit(state.copyWith(verification: LoadedState.error(error)));
      return;
    }
    if (_validatePassword(data.$2) case final error?) {
      _reporter.reportAuthError(error, AppLocation.verificationScreen);
      emit(state.copyWith(verification: LoadedState.error(error)));
      return;
    }
    emit(state.copyWith(verification: const LoadedState.loading()));
    final result = await _authRepository.verify(
      data.$1,
      data.$2,
      data.$3,
      data.$4,
    );
    emit(
      state.copyWith(
        verification: result.match(
          (_) {
            final error = 'Could not verify you';
            _reporter.reportAuthError(error, AppLocation.verificationScreen);
            return LoadedState.error(error);
          },
          (_) {
            _reporter.reportAuthSuccessful(AppLocation.verificationScreen);
            return const LoadedState.data(unit);
          },
        ),
      ),
    );
  }

  void setEmail(String email) => emit(state.copyWith(email: email));

  void setPassword(String password) => emit(state.copyWith(password: password));

  void setGradYear(int year) => emit(
        state.copyWith(graduationYear: year),
      );

  void setFirstName(String firstName) => emit(
        state.copyWith(firstName: firstName),
      );
}
