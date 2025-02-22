import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../application/models/event.dart';

part 'events_list_state.freezed.dart';

@freezed
sealed class EventsListState with _$EventsListState {
  const factory EventsListState.none() = EventsListStateNone;
  const factory EventsListState.loading() = EventsListStateLoading;
  const factory EventsListState.data({
    required IList<EventModel> events,
  }) = EventsListStateData;
  const factory EventsListState.error({required String msg}) =
      EventsListStateError;
}
