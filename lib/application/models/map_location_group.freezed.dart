// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_location_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MapLocationGroup _$MapLocationGroupFromJson(Map<String, dynamic> json) {
  return _MapLocationGroup.fromJson(json);
}

/// @nodoc
mixin _$MapLocationGroup {
  String get country => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this MapLocationGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MapLocationGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapLocationGroupCopyWith<MapLocationGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapLocationGroupCopyWith<$Res> {
  factory $MapLocationGroupCopyWith(
    MapLocationGroup value,
    $Res Function(MapLocationGroup) then,
  ) = _$MapLocationGroupCopyWithImpl<$Res, MapLocationGroup>;
  @useResult
  $Res call({String country, String city, double lat, double lng, int count});
}

/// @nodoc
class _$MapLocationGroupCopyWithImpl<$Res, $Val extends MapLocationGroup>
    implements $MapLocationGroupCopyWith<$Res> {
  _$MapLocationGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapLocationGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? country = null,
    Object? city = null,
    Object? lat = null,
    Object? lng = null,
    Object? count = null,
  }) {
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
            lat:
                null == lat
                    ? _value.lat
                    : lat // ignore: cast_nullable_to_non_nullable
                        as double,
            lng:
                null == lng
                    ? _value.lng
                    : lng // ignore: cast_nullable_to_non_nullable
                        as double,
            count:
                null == count
                    ? _value.count
                    : count // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MapLocationGroupImplCopyWith<$Res>
    implements $MapLocationGroupCopyWith<$Res> {
  factory _$$MapLocationGroupImplCopyWith(
    _$MapLocationGroupImpl value,
    $Res Function(_$MapLocationGroupImpl) then,
  ) = __$$MapLocationGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String country, String city, double lat, double lng, int count});
}

/// @nodoc
class __$$MapLocationGroupImplCopyWithImpl<$Res>
    extends _$MapLocationGroupCopyWithImpl<$Res, _$MapLocationGroupImpl>
    implements _$$MapLocationGroupImplCopyWith<$Res> {
  __$$MapLocationGroupImplCopyWithImpl(
    _$MapLocationGroupImpl _value,
    $Res Function(_$MapLocationGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapLocationGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? country = null,
    Object? city = null,
    Object? lat = null,
    Object? lng = null,
    Object? count = null,
  }) {
    return _then(
      _$MapLocationGroupImpl(
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
        lat:
            null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                    as double,
        lng:
            null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                    as double,
        count:
            null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MapLocationGroupImpl implements _MapLocationGroup {
  const _$MapLocationGroupImpl({
    required this.country,
    required this.city,
    required this.lat,
    required this.lng,
    required this.count,
  });

  factory _$MapLocationGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapLocationGroupImplFromJson(json);

  @override
  final String country;
  @override
  final String city;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final int count;

  @override
  String toString() {
    return 'MapLocationGroup(country: $country, city: $city, lat: $lat, lng: $lng, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapLocationGroupImpl &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, country, city, lat, lng, count);

  /// Create a copy of MapLocationGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapLocationGroupImplCopyWith<_$MapLocationGroupImpl> get copyWith =>
      __$$MapLocationGroupImplCopyWithImpl<_$MapLocationGroupImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MapLocationGroupImplToJson(this);
  }
}

abstract class _MapLocationGroup implements MapLocationGroup {
  const factory _MapLocationGroup({
    required final String country,
    required final String city,
    required final double lat,
    required final double lng,
    required final int count,
  }) = _$MapLocationGroupImpl;

  factory _MapLocationGroup.fromJson(Map<String, dynamic> json) =
      _$MapLocationGroupImpl.fromJson;

  @override
  String get country;
  @override
  String get city;
  @override
  double get lat;
  @override
  double get lng;
  @override
  int get count;

  /// Create a copy of MapLocationGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapLocationGroupImplCopyWith<_$MapLocationGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
