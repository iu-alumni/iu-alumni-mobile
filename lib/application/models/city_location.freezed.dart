// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CityLocation _$CityLocationFromJson(Map<String, dynamic> json) {
  return _CityLocation.fromJson(json);
}

/// @nodoc
mixin _$CityLocation {
  String get country => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;

  /// Serializes this CityLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CityLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CityLocationCopyWith<CityLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityLocationCopyWith<$Res> {
  factory $CityLocationCopyWith(
    CityLocation value,
    $Res Function(CityLocation) then,
  ) = _$CityLocationCopyWithImpl<$Res, CityLocation>;
  @useResult
  $Res call({String country, String city});
}

/// @nodoc
class _$CityLocationCopyWithImpl<$Res, $Val extends CityLocation>
    implements $CityLocationCopyWith<$Res> {
  _$CityLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CityLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? country = null, Object? city = null}) {
    return _then(
      _value.copyWith(
            country:
                null == country
                    ? _value.country
                    : country // ignore: cast_nullable_to_non_nullable
                        as String,
            city:
                null == city
                    ? _value.city
                    : city // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CityLocationImplCopyWith<$Res>
    implements $CityLocationCopyWith<$Res> {
  factory _$$CityLocationImplCopyWith(
    _$CityLocationImpl value,
    $Res Function(_$CityLocationImpl) then,
  ) = __$$CityLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String country, String city});
}

/// @nodoc
class __$$CityLocationImplCopyWithImpl<$Res>
    extends _$CityLocationCopyWithImpl<$Res, _$CityLocationImpl>
    implements _$$CityLocationImplCopyWith<$Res> {
  __$$CityLocationImplCopyWithImpl(
    _$CityLocationImpl _value,
    $Res Function(_$CityLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CityLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? country = null, Object? city = null}) {
    return _then(
      _$CityLocationImpl(
        country:
            null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                    as String,
        city:
            null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CityLocationImpl implements _CityLocation {
  const _$CityLocationImpl({required this.country, required this.city});

  factory _$CityLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CityLocationImplFromJson(json);

  @override
  final String country;
  @override
  final String city;

  @override
  String toString() {
    return 'CityLocation(country: $country, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityLocationImpl &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, country, city);

  /// Create a copy of CityLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityLocationImplCopyWith<_$CityLocationImpl> get copyWith =>
      __$$CityLocationImplCopyWithImpl<_$CityLocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CityLocationImplToJson(this);
  }
}

abstract class _CityLocation implements CityLocation {
  const factory _CityLocation({
    required final String country,
    required final String city,
  }) = _$CityLocationImpl;

  factory _CityLocation.fromJson(Map<String, dynamic> json) =
      _$CityLocationImpl.fromJson;

  @override
  String get country;
  @override
  String get city;

  /// Create a copy of CityLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityLocationImplCopyWith<_$CityLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
