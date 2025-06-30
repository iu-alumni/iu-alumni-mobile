// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'code_verification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CodeVerificationState {
  /// bool verification reflects if the verification was complete. When a user
  /// requests manual verification, the request needs to be confirmed on the
  /// administrator side
  LoadedState<Unit> get verification => throw _privateConstructorUsedError;
  LoadedState<Unit> get resend => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  /// Create a copy of CodeVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CodeVerificationStateCopyWith<CodeVerificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodeVerificationStateCopyWith<$Res> {
  factory $CodeVerificationStateCopyWith(CodeVerificationState value,
          $Res Function(CodeVerificationState) then) =
      _$CodeVerificationStateCopyWithImpl<$Res, CodeVerificationState>;
  @useResult
  $Res call(
      {LoadedState<Unit> verification, LoadedState<Unit> resend, String code});

  $LoadedStateCopyWith<Unit, $Res> get verification;
  $LoadedStateCopyWith<Unit, $Res> get resend;
}

/// @nodoc
class _$CodeVerificationStateCopyWithImpl<$Res,
        $Val extends CodeVerificationState>
    implements $CodeVerificationStateCopyWith<$Res> {
  _$CodeVerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CodeVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verification = null,
    Object? resend = null,
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      verification: null == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as LoadedState<Unit>,
      resend: null == resend
          ? _value.resend
          : resend // ignore: cast_nullable_to_non_nullable
              as LoadedState<Unit>,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of CodeVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoadedStateCopyWith<Unit, $Res> get verification {
    return $LoadedStateCopyWith<Unit, $Res>(_value.verification, (value) {
      return _then(_value.copyWith(verification: value) as $Val);
    });
  }

  /// Create a copy of CodeVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoadedStateCopyWith<Unit, $Res> get resend {
    return $LoadedStateCopyWith<Unit, $Res>(_value.resend, (value) {
      return _then(_value.copyWith(resend: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CodeVerificationStateImplCopyWith<$Res>
    implements $CodeVerificationStateCopyWith<$Res> {
  factory _$$CodeVerificationStateImplCopyWith(
          _$CodeVerificationStateImpl value,
          $Res Function(_$CodeVerificationStateImpl) then) =
      __$$CodeVerificationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadedState<Unit> verification, LoadedState<Unit> resend, String code});

  @override
  $LoadedStateCopyWith<Unit, $Res> get verification;
  @override
  $LoadedStateCopyWith<Unit, $Res> get resend;
}

/// @nodoc
class __$$CodeVerificationStateImplCopyWithImpl<$Res>
    extends _$CodeVerificationStateCopyWithImpl<$Res,
        _$CodeVerificationStateImpl>
    implements _$$CodeVerificationStateImplCopyWith<$Res> {
  __$$CodeVerificationStateImplCopyWithImpl(_$CodeVerificationStateImpl _value,
      $Res Function(_$CodeVerificationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CodeVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verification = null,
    Object? resend = null,
    Object? code = null,
  }) {
    return _then(_$CodeVerificationStateImpl(
      verification: null == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as LoadedState<Unit>,
      resend: null == resend
          ? _value.resend
          : resend // ignore: cast_nullable_to_non_nullable
              as LoadedState<Unit>,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CodeVerificationStateImpl implements _CodeVerificationState {
  const _$CodeVerificationStateImpl(
      {required this.verification, required this.resend, required this.code});

  /// bool verification reflects if the verification was complete. When a user
  /// requests manual verification, the request needs to be confirmed on the
  /// administrator side
  @override
  final LoadedState<Unit> verification;
  @override
  final LoadedState<Unit> resend;
  @override
  final String code;

  @override
  String toString() {
    return 'CodeVerificationState(verification: $verification, resend: $resend, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeVerificationStateImpl &&
            (identical(other.verification, verification) ||
                other.verification == verification) &&
            (identical(other.resend, resend) || other.resend == resend) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, verification, resend, code);

  /// Create a copy of CodeVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CodeVerificationStateImplCopyWith<_$CodeVerificationStateImpl>
      get copyWith => __$$CodeVerificationStateImplCopyWithImpl<
          _$CodeVerificationStateImpl>(this, _$identity);
}

abstract class _CodeVerificationState implements CodeVerificationState {
  const factory _CodeVerificationState(
      {required final LoadedState<Unit> verification,
      required final LoadedState<Unit> resend,
      required final String code}) = _$CodeVerificationStateImpl;

  /// bool verification reflects if the verification was complete. When a user
  /// requests manual verification, the request needs to be confirmed on the
  /// administrator side
  @override
  LoadedState<Unit> get verification;
  @override
  LoadedState<Unit> get resend;
  @override
  String get code;

  /// Create a copy of CodeVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CodeVerificationStateImplCopyWith<_$CodeVerificationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
