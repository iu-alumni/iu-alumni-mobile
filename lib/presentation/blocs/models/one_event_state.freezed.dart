// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'one_event_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OneEventState {
  LoadedState<Unit> get saveState => throw _privateConstructorUsedError;
  Option<EventModel> get event => throw _privateConstructorUsedError;
  bool get userStatusLoading => throw _privateConstructorUsedError;

  /// Create a copy of OneEventState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OneEventStateCopyWith<OneEventState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OneEventStateCopyWith<$Res> {
  factory $OneEventStateCopyWith(
          OneEventState value, $Res Function(OneEventState) then) =
      _$OneEventStateCopyWithImpl<$Res, OneEventState>;
  @useResult
  $Res call(
      {LoadedState<Unit> saveState,
      Option<EventModel> event,
      bool userStatusLoading});

  $LoadedStateCopyWith<Unit, $Res> get saveState;
}

/// @nodoc
class _$OneEventStateCopyWithImpl<$Res, $Val extends OneEventState>
    implements $OneEventStateCopyWith<$Res> {
  _$OneEventStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OneEventState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveState = null,
    Object? event = null,
    Object? userStatusLoading = null,
  }) {
    return _then(_value.copyWith(
      saveState: null == saveState
          ? _value.saveState
          : saveState // ignore: cast_nullable_to_non_nullable
              as LoadedState<Unit>,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Option<EventModel>,
      userStatusLoading: null == userStatusLoading
          ? _value.userStatusLoading
          : userStatusLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of OneEventState
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
abstract class _$$OneEventStateImplCopyWith<$Res>
    implements $OneEventStateCopyWith<$Res> {
  factory _$$OneEventStateImplCopyWith(
          _$OneEventStateImpl value, $Res Function(_$OneEventStateImpl) then) =
      __$$OneEventStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadedState<Unit> saveState,
      Option<EventModel> event,
      bool userStatusLoading});

  @override
  $LoadedStateCopyWith<Unit, $Res> get saveState;
}

/// @nodoc
class __$$OneEventStateImplCopyWithImpl<$Res>
    extends _$OneEventStateCopyWithImpl<$Res, _$OneEventStateImpl>
    implements _$$OneEventStateImplCopyWith<$Res> {
  __$$OneEventStateImplCopyWithImpl(
      _$OneEventStateImpl _value, $Res Function(_$OneEventStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OneEventState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saveState = null,
    Object? event = null,
    Object? userStatusLoading = null,
  }) {
    return _then(_$OneEventStateImpl(
      saveState: null == saveState
          ? _value.saveState
          : saveState // ignore: cast_nullable_to_non_nullable
              as LoadedState<Unit>,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Option<EventModel>,
      userStatusLoading: null == userStatusLoading
          ? _value.userStatusLoading
          : userStatusLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OneEventStateImpl implements _OneEventState {
  const _$OneEventStateImpl(
      {required this.saveState,
      required this.event,
      required this.userStatusLoading});

  @override
  final LoadedState<Unit> saveState;
  @override
  final Option<EventModel> event;
  @override
  final bool userStatusLoading;

  @override
  String toString() {
    return 'OneEventState(saveState: $saveState, event: $event, userStatusLoading: $userStatusLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OneEventStateImpl &&
            (identical(other.saveState, saveState) ||
                other.saveState == saveState) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.userStatusLoading, userStatusLoading) ||
                other.userStatusLoading == userStatusLoading));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, saveState, event, userStatusLoading);

  /// Create a copy of OneEventState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OneEventStateImplCopyWith<_$OneEventStateImpl> get copyWith =>
      __$$OneEventStateImplCopyWithImpl<_$OneEventStateImpl>(this, _$identity);
}

abstract class _OneEventState implements OneEventState {
  const factory _OneEventState(
      {required final LoadedState<Unit> saveState,
      required final Option<EventModel> event,
      required final bool userStatusLoading}) = _$OneEventStateImpl;

  @override
  LoadedState<Unit> get saveState;
  @override
  Option<EventModel> get event;
  @override
  bool get userStatusLoading;

  /// Create a copy of OneEventState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OneEventStateImplCopyWith<_$OneEventStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
