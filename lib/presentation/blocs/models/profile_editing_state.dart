import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../application/models/profile.dart';
import '../../common/models/loaded_state.dart';

part 'profile_editing_state.freezed.dart';

@freezed
class ProfileEditingState with _$ProfileEditingState {
  const factory ProfileEditingState({
    required Option<Profile> profile,
    required LoadedState<Unit> saveState,
  }) = _ProfileEditingState;
}
