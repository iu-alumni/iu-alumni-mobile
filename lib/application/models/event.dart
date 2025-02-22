import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
class EventModel with _$EventModel {

  factory EventModel({
    required String title,
    required String description,
    required String location,
    required DateTime occurringAt,
  }) = _EventModel;
}