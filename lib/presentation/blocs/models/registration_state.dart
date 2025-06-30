import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/models/loaded_state.dart';

part 'registration_state.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const RegistrationState._();

  const factory RegistrationState({
    required LoadedState<bool> verification,
    String? firstName,
    String? lastName,
    int? graduationYear,
    String? email,
    String? password,
    String? telegram,
  }) = _RegistrationState;
}
