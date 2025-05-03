// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VerificationState {
  LoadedState<Unit> get verification => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  int? get graduationYear => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerificationStateCopyWith<VerificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationStateCopyWith<$Res> {
  factory $VerificationStateCopyWith(
          VerificationState value, $Res Function(VerificationState) then) =
      _$VerificationStateCopyWithImpl<$Res, VerificationState>;
  @useResult
  $Res call(
      {LoadedState<Unit> verification,
      String? firstName,
      int? graduationYear,
      String? email,
      String? password});

  $LoadedStateCopyWith<Unit, $Res> get verification;
}

/// @nodoc
class _$VerificationStateCopyWithImpl<$Res, $Val extends VerificationState>
    implements $VerificationStateCopyWith<$Res> {
  _$VerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verification = null,
    Object? firstName = freezed,
    Object? graduationYear = freezed,
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      verification: null == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as LoadedState<Unit>,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      graduationYear: freezed == graduationYear
          ? _value.graduationYear
          : graduationYear // ignore: cast_nullable_to_non_nullable
              as int?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoadedStateCopyWith<Unit, $Res> get verification {
    return $LoadedStateCopyWith<Unit, $Res>(_value.verification, (value) {
      return _then(_value.copyWith(verification: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VerificationStateImplCopyWith<$Res>
    implements $VerificationStateCopyWith<$Res> {
  factory _$$VerificationStateImplCopyWith(_$VerificationStateImpl value,
          $Res Function(_$VerificationStateImpl) then) =
      __$$VerificationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadedState<Unit> verification,
      String? firstName,
      int? graduationYear,
      String? email,
      String? password});

  @override
  $LoadedStateCopyWith<Unit, $Res> get verification;
}

/// @nodoc
class __$$VerificationStateImplCopyWithImpl<$Res>
    extends _$VerificationStateCopyWithImpl<$Res, _$VerificationStateImpl>
    implements _$$VerificationStateImplCopyWith<$Res> {
  __$$VerificationStateImplCopyWithImpl(_$VerificationStateImpl _value,
      $Res Function(_$VerificationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verification = null,
    Object? firstName = freezed,
    Object? graduationYear = freezed,
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_$VerificationStateImpl(
      verification: null == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as LoadedState<Unit>,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      graduationYear: freezed == graduationYear
          ? _value.graduationYear
          : graduationYear // ignore: cast_nullable_to_non_nullable
              as int?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$VerificationStateImpl implements _VerificationState {
  const _$VerificationStateImpl(
      {required this.verification,
      this.firstName,
      this.graduationYear,
      this.email,
      this.password});

  @override
  final LoadedState<Unit> verification;
  @override
  final String? firstName;
  @override
  final int? graduationYear;
  @override
  final String? email;
  @override
  final String? password;

  @override
  String toString() {
    return 'VerificationState(verification: $verification, firstName: $firstName, graduationYear: $graduationYear, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationStateImpl &&
            (identical(other.verification, verification) ||
                other.verification == verification) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.graduationYear, graduationYear) ||
                other.graduationYear == graduationYear) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, verification, firstName, graduationYear, email, password);

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationStateImplCopyWith<_$VerificationStateImpl> get copyWith =>
      __$$VerificationStateImplCopyWithImpl<_$VerificationStateImpl>(
          this, _$identity);
}

abstract class _VerificationState implements VerificationState {
  const factory _VerificationState(
      {required final LoadedState<Unit> verification,
      final String? firstName,
      final int? graduationYear,
      final String? email,
      final String? password}) = _$VerificationStateImpl;

  @override
  LoadedState<Unit> get verification;
  @override
  String? get firstName;
  @override
  int? get graduationYear;
  @override
  String? get email;
  @override
  String? get password;

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationStateImplCopyWith<_$VerificationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
