import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'cost.dart';
import 'user_status.dart';

part 'event.freezed.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String eventId,
    required UserStatus userStatus,
    required String? title,
    required String? description,
    required String? coverBytes,
    required String? location,
    required CostModel cost,
    required DateTime occurringAt,
    required bool onlineEvent,
    required ISet<String> participantsIds,
    required bool pendingApproval,
  }) = _EventModel;
}
