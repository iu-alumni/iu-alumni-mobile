import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/models/loaded_state.dart';

part 'registration_state.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    required LoadedState<bool> verification,
    String? firstName,
    String? lastName,
    int? graduationYear,
    // Radio selection. Defaults to 'alumni' so the existing UX (grad
    // year visible, required) stays put unless the user opts into the
    // Alumni Friend flow.
    @Default('alumni') String role,
    String? email,
    String? password,
    String? telegram,
  }) = _RegistrationState;
  const RegistrationState._();

  bool get isAlumniFriend => role == 'alumni_friend';
}
