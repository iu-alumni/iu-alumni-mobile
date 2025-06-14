// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventDataModelImpl _$$EventDataModelImplFromJson(Map<String, dynamic> json) =>
    _$EventDataModelImpl(
      eventId: json['id'] as String,
      ownerId: json['owner_id'] as String,
      participantsIds: (json['participants_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      cost: (json['cost'] as num).toInt(),
      isOnline: json['is_online'] as bool,
      cover: json['cover'] as String?,
    );

Map<String, dynamic> _$$EventDataModelImplToJson(
        _$EventDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.eventId,
      'owner_id': instance.ownerId,
      'participants_ids': instance.participantsIds,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'datetime': instance.datetime.toIso8601String(),
      'cost': instance.cost,
      'is_online': instance.isOnline,
      'cover': instance.cover,
    };
