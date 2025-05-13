import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../application/models/event.dart';
import '../../../application/models/profile.dart';
import '../../common/models/loaded_state.dart';

part 'one_event_state.freezed.dart';

@freezed
class OneEventState with _$OneEventState {
  const factory OneEventState({
    required LoadedState<Unit> saveState,
    required Option<EventModel> event,
    required bool userStatusLoading,
    required LoadedState<Iterable<Profile>> participants,
  }) = _OneEventState;
}
