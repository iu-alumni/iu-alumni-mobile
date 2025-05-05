import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../application/models/event.dart';
import '../../../application/models/profile.dart';
import '../../common/models/loaded_state.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required bool myOwn,
    required LoadedState<Profile> profile,
    required LoadedState<IList<EventModel>> ownedEvents,
    required LoadedState<IList<EventModel>> participatedEvents,
  }) = _ProfileState;
}
