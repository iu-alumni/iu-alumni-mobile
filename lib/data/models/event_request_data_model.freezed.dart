// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_request_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EventRequestDataModel _$EventRequestDataModelFromJson(
    Map<String, dynamic> json) {
  return _EventRequestDataModel.fromJson(json);
}

/// @nodoc
mixin _$EventRequestDataModel {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get datetime => throw _privateConstructorUsedError;
  int get cost => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_online')
  bool get isOnline => throw _privateConstructorUsedError;
  String? get cover => throw _privateConstructorUsedError;

  /// Serializes this EventRequestDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventRequestDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventRequestDataModelCopyWith<EventRequestDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventRequestDataModelCopyWith<$Res> {
  factory $EventRequestDataModelCopyWith(EventRequestDataModel value,
          $Res Function(EventRequestDataModel) then) =
      _$EventRequestDataModelCopyWithImpl<$Res, EventRequestDataModel>;
  @useResult
  $Res call(
      {String title,
      String description,
      String location,
      DateTime datetime,
      int cost,
      @JsonKey(name: 'is_online') bool isOnline,
      String? cover});
}

/// @nodoc
class _$EventRequestDataModelCopyWithImpl<$Res,
        $Val extends EventRequestDataModel>
    implements $EventRequestDataModelCopyWith<$Res> {
  _$EventRequestDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventRequestDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? datetime = null,
    Object? cost = null,
    Object? isOnline = null,
    Object? cover = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      datetime: null == datetime
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventRequestDataModelImplCopyWith<$Res>
    implements $EventRequestDataModelCopyWith<$Res> {
  factory _$$EventRequestDataModelImplCopyWith(
          _$EventRequestDataModelImpl value,
          $Res Function(_$EventRequestDataModelImpl) then) =
      __$$EventRequestDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      String location,
      DateTime datetime,
      int cost,
      @JsonKey(name: 'is_online') bool isOnline,
      String? cover});
}

/// @nodoc
class __$$EventRequestDataModelImplCopyWithImpl<$Res>
    extends _$EventRequestDataModelCopyWithImpl<$Res,
        _$EventRequestDataModelImpl>
    implements _$$EventRequestDataModelImplCopyWith<$Res> {
  __$$EventRequestDataModelImplCopyWithImpl(_$EventRequestDataModelImpl _value,
      $Res Function(_$EventRequestDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventRequestDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? datetime = null,
    Object? cost = null,
    Object? isOnline = null,
    Object? cover = freezed,
  }) {
    return _then(_$EventRequestDataModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      datetime: null == datetime
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventRequestDataModelImpl implements _EventRequestDataModel {
  _$EventRequestDataModelImpl(
      {required this.title,
      required this.description,
      required this.location,
      required this.datetime,
      required this.cost,
      @JsonKey(name: 'is_online') required this.isOnline,
      required this.cover});

  factory _$EventRequestDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventRequestDataModelImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final String location;
  @override
  final DateTime datetime;
  @override
  final int cost;
  @override
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @override
  final String? cover;

  @override
  String toString() {
    return 'EventRequestDataModel(title: $title, description: $description, location: $location, datetime: $datetime, cost: $cost, isOnline: $isOnline, cover: $cover)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventRequestDataModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.cover, cover) || other.cover == cover));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, location,
      datetime, cost, isOnline, cover);

  /// Create a copy of EventRequestDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventRequestDataModelImplCopyWith<_$EventRequestDataModelImpl>
      get copyWith => __$$EventRequestDataModelImplCopyWithImpl<
          _$EventRequestDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventRequestDataModelImplToJson(
      this,
    );
  }
}

abstract class _EventRequestDataModel implements EventRequestDataModel {
  factory _EventRequestDataModel(
      {required final String title,
      required final String description,
      required final String location,
      required final DateTime datetime,
      required final int cost,
      @JsonKey(name: 'is_online') required final bool isOnline,
      required final String? cover}) = _$EventRequestDataModelImpl;

  factory _EventRequestDataModel.fromJson(Map<String, dynamic> json) =
      _$EventRequestDataModelImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  String get location;
  @override
  DateTime get datetime;
  @override
  int get cost;
  @override
  @JsonKey(name: 'is_online')
  bool get isOnline;
  @override
  String? get cover;

  /// Create a copy of EventRequestDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventRequestDataModelImplCopyWith<_$EventRequestDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
