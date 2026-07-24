import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String eventId,
    required String title,
    required String location,
    required DateTime datetime,
    required bool read,
  }) = _NotificationModel;
}
