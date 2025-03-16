// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EventDataModel _$EventDataModelFromJson(Map<String, dynamic> json) {
  return _EventDataModel.fromJson(json);
}

/// @nodoc
mixin _$EventDataModel {
  @JsonKey(name: 'id')
  String get eventId => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_id')
  String get ownerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'participants_ids')
  List<String> get participantsIds => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get datetime => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_online')
  bool get isOnline => throw _privateConstructorUsedError;
  String get cover => throw _privateConstructorUsedError;

  /// Serializes this EventDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventDataModelCopyWith<EventDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventDataModelCopyWith<$Res> {
  factory $EventDataModelCopyWith(
          EventDataModel value, $Res Function(EventDataModel) then) =
      _$EventDataModelCopyWithImpl<$Res, EventDataModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String eventId,
      @JsonKey(name: 'owner_id') String ownerId,
      @JsonKey(name: 'participants_ids') List<String> participantsIds,
      String title,
      String description,
      String location,
      DateTime datetime,
      double cost,
      @JsonKey(name: 'is_online') bool isOnline,
      String cover});
}

/// @nodoc
class _$EventDataModelCopyWithImpl<$Res, $Val extends EventDataModel>
    implements $EventDataModelCopyWith<$Res> {
  _$EventDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? ownerId = null,
    Object? participantsIds = null,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? datetime = null,
    Object? cost = null,
    Object? isOnline = null,
    Object? cover = null,
  }) {
    return _then(_value.copyWith(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      participantsIds: null == participantsIds
          ? _value.participantsIds
          : participantsIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
              as double,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      cover: null == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventDataModelImplCopyWith<$Res>
    implements $EventDataModelCopyWith<$Res> {
  factory _$$EventDataModelImplCopyWith(_$EventDataModelImpl value,
          $Res Function(_$EventDataModelImpl) then) =
      __$$EventDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String eventId,
      @JsonKey(name: 'owner_id') String ownerId,
      @JsonKey(name: 'participants_ids') List<String> participantsIds,
      String title,
      String description,
      String location,
      DateTime datetime,
      double cost,
      @JsonKey(name: 'is_online') bool isOnline,
      String cover});
}

/// @nodoc
class __$$EventDataModelImplCopyWithImpl<$Res>
    extends _$EventDataModelCopyWithImpl<$Res, _$EventDataModelImpl>
    implements _$$EventDataModelImplCopyWith<$Res> {
  __$$EventDataModelImplCopyWithImpl(
      _$EventDataModelImpl _value, $Res Function(_$EventDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? ownerId = null,
    Object? participantsIds = null,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? datetime = null,
    Object? cost = null,
    Object? isOnline = null,
    Object? cover = null,
  }) {
    return _then(_$EventDataModelImpl(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      participantsIds: null == participantsIds
          ? _value._participantsIds
          : participantsIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
              as double,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      cover: null == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventDataModelImpl implements _EventDataModel {
  _$EventDataModelImpl(
      {@JsonKey(name: 'id') required this.eventId,
      @JsonKey(name: 'owner_id') required this.ownerId,
      @JsonKey(name: 'participants_ids')
      required final List<String> participantsIds,
      required this.title,
      required this.description,
      required this.location,
      required this.datetime,
      required this.cost,
      @JsonKey(name: 'is_online') required this.isOnline,
      required this.cover})
      : _participantsIds = participantsIds;

  factory _$EventDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventDataModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String eventId;
  @override
  @JsonKey(name: 'owner_id')
  final String ownerId;
  final List<String> _participantsIds;
  @override
  @JsonKey(name: 'participants_ids')
  List<String> get participantsIds {
    if (_participantsIds is EqualUnmodifiableListView) return _participantsIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantsIds);
  }

  @override
  final String title;
  @override
  final String description;
  @override
  final String location;
  @override
  final DateTime datetime;
  @override
  final double cost;
  @override
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @override
  final String cover;

  @override
  String toString() {
    return 'EventDataModel(eventId: $eventId, ownerId: $ownerId, participantsIds: $participantsIds, title: $title, description: $description, location: $location, datetime: $datetime, cost: $cost, isOnline: $isOnline, cover: $cover)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventDataModelImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other._participantsIds, _participantsIds) &&
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
  int get hashCode => Object.hash(
      runtimeType,
      eventId,
      ownerId,
      const DeepCollectionEquality().hash(_participantsIds),
      title,
      description,
      location,
      datetime,
      cost,
      isOnline,
      cover);

  /// Create a copy of EventDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventDataModelImplCopyWith<_$EventDataModelImpl> get copyWith =>
      __$$EventDataModelImplCopyWithImpl<_$EventDataModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventDataModelImplToJson(
      this,
    );
  }
}

abstract class _EventDataModel implements EventDataModel {
  factory _EventDataModel(
      {@JsonKey(name: 'id') required final String eventId,
      @JsonKey(name: 'owner_id') required final String ownerId,
      @JsonKey(name: 'participants_ids')
      required final List<String> participantsIds,
      required final String title,
      required final String description,
      required final String location,
      required final DateTime datetime,
      required final double cost,
      @JsonKey(name: 'is_online') required final bool isOnline,
      required final String cover}) = _$EventDataModelImpl;

  factory _EventDataModel.fromJson(Map<String, dynamic> json) =
      _$EventDataModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get eventId;
  @override
  @JsonKey(name: 'owner_id')
  String get ownerId;
  @override
  @JsonKey(name: 'participants_ids')
  List<String> get participantsIds;
  @override
  String get title;
  @override
  String get description;
  @override
  String get location;
  @override
  DateTime get datetime;
  @override
  double get cost;
  @override
  @JsonKey(name: 'is_online')
  bool get isOnline;
  @override
  String get cover;

  /// Create a copy of EventDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventDataModelImplCopyWith<_$EventDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
