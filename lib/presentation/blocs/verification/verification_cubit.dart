import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/loaded_state.dart';

class VerificationState {
  VerificationState({
    required this.verification,
    this.birthDate,
    this.graduationYear,
  });
  final LoadedState verification;
  final int? graduationYear;
  final DateTime? birthDate;
}

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit()
      : super(VerificationState(verification: const LoadedState.init()));

  void verify(String email, String password) {}

  void setGradYear(int year) => emit(
        VerificationState(
          verification: state.verification,
          graduationYear: year,
          birthDate: state.birthDate,
        ),
      );

  void setBirthDate(DateTime birthDate) => emit(
        VerificationState(
          verification: state.verification,
          graduationYear: state.graduationYear,
          birthDate: birthDate,
        ),
      );
}
