// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_location_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapLocationGroupImpl _$$MapLocationGroupImplFromJson(
  Map<String, dynamic> json,
) => _$MapLocationGroupImpl(
  country: json['country'] as String,
  city: json['city'] as String,
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$$MapLocationGroupImplToJson(
  _$MapLocationGroupImpl instance,
) => <String, dynamic>{
  'country': instance.country,
  'city': instance.city,
  'lat': instance.lat,
  'lng': instance.lng,
  'count': instance.count,
};
