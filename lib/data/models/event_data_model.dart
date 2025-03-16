import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_data_model.freezed.dart';
part 'event_data_model.g.dart';

@freezed
class EventDataModel with _$EventDataModel {
  factory EventDataModel({
    @JsonKey(name: 'id') required String eventId,
    @JsonKey(name: 'owner_id') required String ownerId,
    @JsonKey(name: 'participants_ids') required List<String> participantsIds,
    required String title,
    required String description,
    required String location,
    required DateTime datetime,
    required double cost,
    @JsonKey(name: 'is_online') required bool isOnline,
    required String cover,
  }) = _EventDataModel;

  factory EventDataModel.fromJson(Map<String, dynamic> json) =>
      _$EventDataModelFromJson(json);
}
