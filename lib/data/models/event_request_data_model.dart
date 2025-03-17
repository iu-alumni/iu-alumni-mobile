import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_request_data_model.freezed.dart';
part 'event_request_data_model.g.dart';

@freezed
class EventRequestDataModel with _$EventRequestDataModel {

  factory EventRequestDataModel({
    required String title,
    required String description,
    required String location,
    required DateTime datetime,
    required int cost,
    @JsonKey(name: 'is_online') required bool isOnline,
    required String cover,
  }) = _EventRequestDataModel;

  factory EventRequestDataModel.fromJson(Map<String, dynamic> json) => _$EventRequestDataModelFromJson(json);
}