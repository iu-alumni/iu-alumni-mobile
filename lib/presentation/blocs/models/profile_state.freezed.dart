// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileState {
  LoadedState<Profile> get profile => throw _privateConstructorUsedError;
  LoadedState<IList<EventModel>> get ownedEvents =>
      throw _privateConstructorUsedError;
  LoadedState<IList<EventModel>> get participatedEvents =>
      throw _privateConstructorUsedError;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call(
      {LoadedState<Profile> profile,
      LoadedState<IList<EventModel>> ownedEvents,
      LoadedState<IList<EventModel>> participatedEvents});

  $LoadedStateCopyWith<Profile, $Res> get profile;
  $LoadedStateCopyWith<IList<EventModel>, $Res> get ownedEvents;
  $LoadedStateCopyWith<IList<EventModel>, $Res> get participatedEvents;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? ownedEvents = null,
    Object? participatedEvents = null,
  }) {
    return _then(_value.copyWith(
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as LoadedState<Profile>,
      ownedEvents: null == ownedEvents
          ? _value.ownedEvents
          : ownedEvents // ignore: cast_nullable_to_non_nullable
              as LoadedState<IList<EventModel>>,
      participatedEvents: null == participatedEvents
          ? _value.participatedEvents
          : participatedEvents // ignore: cast_nullable_to_non_nullable
              as LoadedState<IList<EventModel>>,
    ) as $Val);
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoadedStateCopyWith<Profile, $Res> get profile {
    return $LoadedStateCopyWith<Profile, $Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoadedStateCopyWith<IList<EventModel>, $Res> get ownedEvents {
    return $LoadedStateCopyWith<IList<EventModel>, $Res>(_value.ownedEvents,
        (value) {
      return _then(_value.copyWith(ownedEvents: value) as $Val);
    });
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoadedStateCopyWith<IList<EventModel>, $Res> get participatedEvents {
    return $LoadedStateCopyWith<IList<EventModel>, $Res>(
        _value.participatedEvents, (value) {
      return _then(_value.copyWith(participatedEvents: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileStateImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ProfileStateImplCopyWith(
          _$ProfileStateImpl value, $Res Function(_$ProfileStateImpl) then) =
      __$$ProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadedState<Profile> profile,
      LoadedState<IList<EventModel>> ownedEvents,
      LoadedState<IList<EventModel>> participatedEvents});

  @override
  $LoadedStateCopyWith<Profile, $Res> get profile;
  @override
  $LoadedStateCopyWith<IList<EventModel>, $Res> get ownedEvents;
  @override
  $LoadedStateCopyWith<IList<EventModel>, $Res> get participatedEvents;
}

/// @nodoc
class __$$ProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileStateImpl>
    implements _$$ProfileStateImplCopyWith<$Res> {
  __$$ProfileStateImplCopyWithImpl(
      _$ProfileStateImpl _value, $Res Function(_$ProfileStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? ownedEvents = null,
    Object? participatedEvents = null,
  }) {
    return _then(_$ProfileStateImpl(
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as LoadedState<Profile>,
      ownedEvents: null == ownedEvents
          ? _value.ownedEvents
          : ownedEvents // ignore: cast_nullable_to_non_nullable
              as LoadedState<IList<EventModel>>,
      participatedEvents: null == participatedEvents
          ? _value.participatedEvents
          : participatedEvents // ignore: cast_nullable_to_non_nullable
              as LoadedState<IList<EventModel>>,
    ));
  }
}

/// @nodoc

class _$ProfileStateImpl implements _ProfileState {
  const _$ProfileStateImpl(
      {required this.profile,
      required this.ownedEvents,
      required this.participatedEvents});

  @override
  final LoadedState<Profile> profile;
  @override
  final LoadedState<IList<EventModel>> ownedEvents;
  @override
  final LoadedState<IList<EventModel>> participatedEvents;

  @override
  String toString() {
    return 'ProfileState(profile: $profile, ownedEvents: $ownedEvents, participatedEvents: $participatedEvents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStateImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.ownedEvents, ownedEvents) ||
                other.ownedEvents == ownedEvents) &&
            (identical(other.participatedEvents, participatedEvents) ||
                other.participatedEvents == participatedEvents));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, profile, ownedEvents, participatedEvents);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      __$$ProfileStateImplCopyWithImpl<_$ProfileStateImpl>(this, _$identity);
}

abstract class _ProfileState implements ProfileState {
  const factory _ProfileState(
          {required final LoadedState<Profile> profile,
          required final LoadedState<IList<EventModel>> ownedEvents,
          required final LoadedState<IList<EventModel>> participatedEvents}) =
      _$ProfileStateImpl;

  @override
  LoadedState<Profile> get profile;
  @override
  LoadedState<IList<EventModel>> get ownedEvents;
  @override
  LoadedState<IList<EventModel>> get participatedEvents;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
