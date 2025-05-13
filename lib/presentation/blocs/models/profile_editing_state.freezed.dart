// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_editing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileEditingState {
  Option<Profile> get profile => throw _privateConstructorUsedError;
  LoadedState<Unit> get saveState => throw _privateConstructorUsedError;

  /// Create a copy of ProfileEditingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileEditingStateCopyWith<ProfileEditingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEditingStateCopyWith<$Res> {
  factory $ProfileEditingStateCopyWith(
          ProfileEditingState value, $Res Function(ProfileEditingState) then) =
      _$ProfileEditingStateCopyWithImpl<$Res, ProfileEditingState>;
  @useResult
  $Res call({Option<Profile> profile, LoadedState<Unit> saveState});

  $LoadedStateCopyWith<Unit, $Res> get saveState;
}

/// @nodoc
class _$ProfileEditingStateCopyWithImpl<$Res, $Val extends ProfileEditingState>
    implements $ProfileEditingStateCopyWith<$Res> {
  _$ProfileEditingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileEditingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? saveState = null,
  }) {
    return _then(_value.copyWith(
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Option<Profile>,
      saveState: null == saveState
          ? _value.saveState
          : saveState // ignore: cast_nullable_to_non_nullable
              as LoadedState<Unit>,
    ) as $Val);
  }

  /// Create a copy of ProfileEditingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoadedStateCopyWith<Unit, $Res> get saveState {
    return $LoadedStateCopyWith<Unit, $Res>(_value.saveState, (value) {
      return _then(_value.copyWith(saveState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileEditingStateImplCopyWith<$Res>
    implements $ProfileEditingStateCopyWith<$Res> {
  factory _$$ProfileEditingStateImplCopyWith(_$ProfileEditingStateImpl value,
          $Res Function(_$ProfileEditingStateImpl) then) =
      __$$ProfileEditingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Option<Profile> profile, LoadedState<Unit> saveState});

  @override
  $LoadedStateCopyWith<Unit, $Res> get saveState;
}

/// @nodoc
class __$$ProfileEditingStateImplCopyWithImpl<$Res>
    extends _$ProfileEditingStateCopyWithImpl<$Res, _$ProfileEditingStateImpl>
    implements _$$ProfileEditingStateImplCopyWith<$Res> {
  __$$ProfileEditingStateImplCopyWithImpl(_$ProfileEditingStateImpl _value,
      $Res Function(_$ProfileEditingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEditingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? saveState = null,
  }) {
    return _then(_$ProfileEditingStateImpl(
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Option<Profile>,
      saveState: null == saveState
          ? _value.saveState
          : saveState // ignore: cast_nullable_to_non_nullable
              as LoadedState<Unit>,
    ));
  }
}

/// @nodoc

class _$ProfileEditingStateImpl implements _ProfileEditingState {
  const _$ProfileEditingStateImpl(
      {required this.profile, required this.saveState});

  @override
  final Option<Profile> profile;
  @override
  final LoadedState<Unit> saveState;

  @override
  String toString() {
    return 'ProfileEditingState(profile: $profile, saveState: $saveState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileEditingStateImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.saveState, saveState) ||
                other.saveState == saveState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile, saveState);

  /// Create a copy of ProfileEditingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileEditingStateImplCopyWith<_$ProfileEditingStateImpl> get copyWith =>
      __$$ProfileEditingStateImplCopyWithImpl<_$ProfileEditingStateImpl>(
          this, _$identity);
}

abstract class _ProfileEditingState implements ProfileEditingState {
  const factory _ProfileEditingState(
      {required final Option<Profile> profile,
      required final LoadedState<Unit> saveState}) = _$ProfileEditingStateImpl;

  @override
  Option<Profile> get profile;
  @override
  LoadedState<Unit> get saveState;

  /// Create a copy of ProfileEditingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileEditingStateImplCopyWith<_$ProfileEditingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
