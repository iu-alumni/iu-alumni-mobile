// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      profileId: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      graduationYear: json['graduation_year'] as String,
      location: json['location'] as String?,
      biography: json['biography'] as String?,
      showLocation: json['show_location'] as bool,
      telegramAlias: json['telegram_alias'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.profileId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'graduation_year': instance.graduationYear,
      'location': instance.location,
      'biography': instance.biography,
      'show_location': instance.showLocation,
      'telegram_alias': instance.telegramAlias,
      'avatar': instance.avatar,
    };
