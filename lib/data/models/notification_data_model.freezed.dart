// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationDataModel _$NotificationDataModelFromJson(
  Map<String, dynamic> json,
) {
  return _NotificationDataModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationDataModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_id')
  String get eventId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get datetime => throw _privateConstructorUsedError;
  bool get read => throw _privateConstructorUsedError;

  /// Serializes this NotificationDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationDataModelCopyWith<NotificationDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDataModelCopyWith<$Res> {
  factory $NotificationDataModelCopyWith(
    NotificationDataModel value,
    $Res Function(NotificationDataModel) then,
  ) = _$NotificationDataModelCopyWithImpl<$Res, NotificationDataModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'event_id') String eventId,
    String title,
    String location,
    DateTime datetime,
    bool read,
  });
}

/// @nodoc
class _$NotificationDataModelCopyWithImpl<
  $Res,
  $Val extends NotificationDataModel
>
    implements $NotificationDataModelCopyWith<$Res> {
  _$NotificationDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? title = null,
    Object? location = null,
    Object? datetime = null,
    Object? read = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            eventId:
                null == eventId
                    ? _value.eventId
                    : eventId // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            location:
                null == location
                    ? _value.location
                    : location // ignore: cast_nullable_to_non_nullable
                        as String,
            datetime:
                null == datetime
                    ? _value.datetime
                    : datetime // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            read:
                null == read
                    ? _value.read
                    : read // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationDataModelImplCopyWith<$Res>
    implements $NotificationDataModelCopyWith<$Res> {
  factory _$$NotificationDataModelImplCopyWith(
    _$NotificationDataModelImpl value,
    $Res Function(_$NotificationDataModelImpl) then,
  ) = __$$NotificationDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'event_id') String eventId,
    String title,
    String location,
    DateTime datetime,
    bool read,
  });
}

/// @nodoc
class __$$NotificationDataModelImplCopyWithImpl<$Res>
    extends
        _$NotificationDataModelCopyWithImpl<$Res, _$NotificationDataModelImpl>
    implements _$$NotificationDataModelImplCopyWith<$Res> {
  __$$NotificationDataModelImplCopyWithImpl(
    _$NotificationDataModelImpl _value,
    $Res Function(_$NotificationDataModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? title = null,
    Object? location = null,
    Object? datetime = null,
    Object? read = null,
  }) {
    return _then(
      _$NotificationDataModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        eventId:
            null == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        location:
            null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                    as String,
        datetime:
            null == datetime
                ? _value.datetime
                : datetime // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        read:
            null == read
                ? _value.read
                : read // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationDataModelImpl implements _NotificationDataModel {
  _$NotificationDataModelImpl({
    required this.id,
    @JsonKey(name: 'event_id') required this.eventId,
    required this.title,
    required this.location,
    required this.datetime,
    required this.read,
  });

  factory _$NotificationDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationDataModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'event_id')
  final String eventId;
  @override
  final String title;
  @override
  final String location;
  @override
  final DateTime datetime;
  @override
  final bool read;

  @override
  String toString() {
    return 'NotificationDataModel(id: $id, eventId: $eventId, title: $title, location: $location, datetime: $datetime, read: $read)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationDataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.read, read) || other.read == read));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, eventId, title, location, datetime, read);

  /// Create a copy of NotificationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationDataModelImplCopyWith<_$NotificationDataModelImpl>
  get copyWith =>
      __$$NotificationDataModelImplCopyWithImpl<_$NotificationDataModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationDataModelImplToJson(this);
  }
}

abstract class _NotificationDataModel implements NotificationDataModel {
  factory _NotificationDataModel({
    required final String id,
    @JsonKey(name: 'event_id') required final String eventId,
    required final String title,
    required final String location,
    required final DateTime datetime,
    required final bool read,
  }) = _$NotificationDataModelImpl;

  factory _NotificationDataModel.fromJson(Map<String, dynamic> json) =
      _$NotificationDataModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'event_id')
  String get eventId;
  @override
  String get title;
  @override
  String get location;
  @override
  DateTime get datetime;
  @override
  bool get read;

  /// Create a copy of NotificationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationDataModelImplCopyWith<_$NotificationDataModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
