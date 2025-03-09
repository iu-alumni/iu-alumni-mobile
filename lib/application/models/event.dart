import 'package:freezed_annotation/freezed_annotation.dart';

import 'cost.dart';

part 'event.freezed.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String eventId,
    required String title,
    required String description,
    // TODO
    required String? coverUrl,
    required String location,
    required CostModel cost,
    required DateTime occurringAt,
  }) = _EventModel;
}
