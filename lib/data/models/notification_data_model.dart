import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_data_model.freezed.dart';
part 'notification_data_model.g.dart';

@freezed
class NotificationDataModel with _$NotificationDataModel {
  factory NotificationDataModel({
    required String id,
    @JsonKey(name: 'event_id') required String eventId,
    required String title,
    required String location,
    required DateTime datetime,
    required bool read,
  }) = _NotificationDataModel;

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataModelFromJson(json);
}
