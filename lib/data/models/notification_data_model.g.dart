// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationDataModelImpl _$$NotificationDataModelImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationDataModelImpl(
  id: json['id'] as String,
  eventId: json['event_id'] as String,
  title: json['title'] as String,
  location: json['location'] as String,
  datetime: DateTime.parse(json['datetime'] as String),
  read: json['read'] as bool,
);

Map<String, dynamic> _$$NotificationDataModelImplToJson(
  _$NotificationDataModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'event_id': instance.eventId,
  'title': instance.title,
  'location': instance.location,
  'datetime': instance.datetime.toIso8601String(),
  'read': instance.read,
};
