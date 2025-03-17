// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_request_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventRequestDataModelImpl _$$EventRequestDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EventRequestDataModelImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      cost: (json['cost'] as num).toInt(),
      isOnline: json['is_online'] as bool,
      cover: json['cover'] as String,
    );

Map<String, dynamic> _$$EventRequestDataModelImplToJson(
        _$EventRequestDataModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'datetime': instance.datetime.toIso8601String(),
      'cost': instance.cost,
      'is_online': instance.isOnline,
      'cover': instance.cover,
    };
