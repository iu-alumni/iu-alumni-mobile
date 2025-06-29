// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventModel {
  String get eventId => throw _privateConstructorUsedError;
  UserStatus get userStatus => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError; // TODO
  String? get coverBytes => throw _privateConstructorUsedError; // TODO
  String? get location => throw _privateConstructorUsedError;
  CostModel get cost => throw _privateConstructorUsedError;
  DateTime get occurringAt => throw _privateConstructorUsedError;
  bool get onlineEvent => throw _privateConstructorUsedError;
  ISet<String> get participantsIds => throw _privateConstructorUsedError;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventModelCopyWith<EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventModelCopyWith<$Res> {
  factory $EventModelCopyWith(
          EventModel value, $Res Function(EventModel) then) =
      _$EventModelCopyWithImpl<$Res, EventModel>;
  @useResult
  $Res call(
      {String eventId,
      UserStatus userStatus,
      String? title,
      String? description,
      String? coverBytes,
      String? location,
      CostModel cost,
      DateTime occurringAt,
      bool onlineEvent,
      ISet<String> participantsIds});

  $UserStatusCopyWith<$Res> get userStatus;
  $CostModelCopyWith<$Res> get cost;
}

/// @nodoc
class _$EventModelCopyWithImpl<$Res, $Val extends EventModel>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? userStatus = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? coverBytes = freezed,
    Object? location = freezed,
    Object? cost = null,
    Object? occurringAt = null,
    Object? onlineEvent = null,
    Object? participantsIds = null,
  }) {
    return _then(_value.copyWith(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userStatus: null == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      coverBytes: freezed == coverBytes
          ? _value.coverBytes
          : coverBytes // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as CostModel,
      occurringAt: null == occurringAt
          ? _value.occurringAt
          : occurringAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      onlineEvent: null == onlineEvent
          ? _value.onlineEvent
          : onlineEvent // ignore: cast_nullable_to_non_nullable
              as bool,
      participantsIds: null == participantsIds
          ? _value.participantsIds
          : participantsIds // ignore: cast_nullable_to_non_nullable
              as ISet<String>,
    ) as $Val);
  }

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserStatusCopyWith<$Res> get userStatus {
    return $UserStatusCopyWith<$Res>(_value.userStatus, (value) {
      return _then(_value.copyWith(userStatus: value) as $Val);
    });
  }

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CostModelCopyWith<$Res> get cost {
    return $CostModelCopyWith<$Res>(_value.cost, (value) {
      return _then(_value.copyWith(cost: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EventModelImplCopyWith<$Res>
    implements $EventModelCopyWith<$Res> {
  factory _$$EventModelImplCopyWith(
          _$EventModelImpl value, $Res Function(_$EventModelImpl) then) =
      __$$EventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String eventId,
      UserStatus userStatus,
      String? title,
      String? description,
      String? coverBytes,
      String? location,
      CostModel cost,
      DateTime occurringAt,
      bool onlineEvent,
      ISet<String> participantsIds});

  @override
  $UserStatusCopyWith<$Res> get userStatus;
  @override
  $CostModelCopyWith<$Res> get cost;
}

/// @nodoc
class __$$EventModelImplCopyWithImpl<$Res>
    extends _$EventModelCopyWithImpl<$Res, _$EventModelImpl>
    implements _$$EventModelImplCopyWith<$Res> {
  __$$EventModelImplCopyWithImpl(
      _$EventModelImpl _value, $Res Function(_$EventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? userStatus = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? coverBytes = freezed,
    Object? location = freezed,
    Object? cost = null,
    Object? occurringAt = null,
    Object? onlineEvent = null,
    Object? participantsIds = null,
  }) {
    return _then(_$EventModelImpl(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userStatus: null == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      coverBytes: freezed == coverBytes
          ? _value.coverBytes
          : coverBytes // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as CostModel,
      occurringAt: null == occurringAt
          ? _value.occurringAt
          : occurringAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      onlineEvent: null == onlineEvent
          ? _value.onlineEvent
          : onlineEvent // ignore: cast_nullable_to_non_nullable
              as bool,
      participantsIds: null == participantsIds
          ? _value.participantsIds
          : participantsIds // ignore: cast_nullable_to_non_nullable
              as ISet<String>,
    ));
  }
}

/// @nodoc

class _$EventModelImpl implements _EventModel {
  const _$EventModelImpl(
      {required this.eventId,
      required this.userStatus,
      required this.title,
      required this.description,
      required this.coverBytes,
      required this.location,
      required this.cost,
      required this.occurringAt,
      required this.onlineEvent,
      required this.participantsIds});

  @override
  final String eventId;
  @override
  final UserStatus userStatus;
  @override
  final String? title;
  @override
  final String? description;
// TODO
  @override
  final String? coverBytes;
// TODO
  @override
  final String? location;
  @override
  final CostModel cost;
  @override
  final DateTime occurringAt;
  @override
  final bool onlineEvent;
  @override
  final ISet<String> participantsIds;

  @override
  String toString() {
    return 'EventModel(eventId: $eventId, userStatus: $userStatus, title: $title, description: $description, coverBytes: $coverBytes, location: $location, cost: $cost, occurringAt: $occurringAt, onlineEvent: $onlineEvent, participantsIds: $participantsIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventModelImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userStatus, userStatus) ||
                other.userStatus == userStatus) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coverBytes, coverBytes) ||
                other.coverBytes == coverBytes) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.occurringAt, occurringAt) ||
                other.occurringAt == occurringAt) &&
            (identical(other.onlineEvent, onlineEvent) ||
                other.onlineEvent == onlineEvent) &&
            const DeepCollectionEquality()
                .equals(other.participantsIds, participantsIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      eventId,
      userStatus,
      title,
      description,
      coverBytes,
      location,
      cost,
      occurringAt,
      onlineEvent,
      const DeepCollectionEquality().hash(participantsIds));

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      __$$EventModelImplCopyWithImpl<_$EventModelImpl>(this, _$identity);
}

abstract class _EventModel implements EventModel {
  const factory _EventModel(
      {required final String eventId,
      required final UserStatus userStatus,
      required final String? title,
      required final String? description,
      required final String? coverBytes,
      required final String? location,
      required final CostModel cost,
      required final DateTime occurringAt,
      required final bool onlineEvent,
      required final ISet<String> participantsIds}) = _$EventModelImpl;

  @override
  String get eventId;
  @override
  UserStatus get userStatus;
  @override
  String? get title;
  @override
  String? get description; // TODO
  @override
  String? get coverBytes; // TODO
  @override
  String? get location;
  @override
  CostModel get cost;
  @override
  DateTime get occurringAt;
  @override
  bool get onlineEvent;
  @override
  ISet<String> get participantsIds;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
