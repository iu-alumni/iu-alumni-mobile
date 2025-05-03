import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/models/loaded_state.dart';

part 'verification_state.freezed.dart';

@freezed
class VerificationState with _$VerificationState {
  const factory VerificationState({
    required LoadedState<Unit> verification,
    String? firstName,
    int? graduationYear,
    String? email,
    String? password,
  }) = _VerificationState;
}
