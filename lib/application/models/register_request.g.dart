// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$$RegisterRequestImplToJson(
  _$RegisterRequestImpl instance,
) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'password': instance.password,
  'manual_verification': instance.manualVerification,
  if (instance.gradYear case final value?) 'graduation_year': value,
  'role': instance.role,
  'telegram_alias': instance.telegram,
};
