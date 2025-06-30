import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/models/loaded_state.dart';

part 'code_verification_state.freezed.dart';

@freezed
class CodeVerificationState with _$CodeVerificationState {
  const factory CodeVerificationState({
    /// bool verification reflects if the verification was complete. When a user
    /// requests manual verification, the request needs to be confirmed on the
    /// administrator side
    required LoadedState<Unit> verification,
    required LoadedState<Unit> resend,
    required String code,
  }) = _CodeVerificationState;
}
