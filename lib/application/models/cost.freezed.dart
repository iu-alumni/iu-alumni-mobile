// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cost.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CostModel {
  double get number => throw _privateConstructorUsedError;
  Currency get currency => throw _privateConstructorUsedError;

  /// Create a copy of CostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CostModelCopyWith<CostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostModelCopyWith<$Res> {
  factory $CostModelCopyWith(CostModel value, $Res Function(CostModel) then) =
      _$CostModelCopyWithImpl<$Res, CostModel>;
  @useResult
  $Res call({double number, Currency currency});
}

/// @nodoc
class _$CostModelCopyWithImpl<$Res, $Val extends CostModel>
    implements $CostModelCopyWith<$Res> {
  _$CostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? currency = null,
  }) {
    return _then(_value.copyWith(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CostModelImplCopyWith<$Res>
    implements $CostModelCopyWith<$Res> {
  factory _$$CostModelImplCopyWith(
          _$CostModelImpl value, $Res Function(_$CostModelImpl) then) =
      __$$CostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double number, Currency currency});
}

/// @nodoc
class __$$CostModelImplCopyWithImpl<$Res>
    extends _$CostModelCopyWithImpl<$Res, _$CostModelImpl>
    implements _$$CostModelImplCopyWith<$Res> {
  __$$CostModelImplCopyWithImpl(
      _$CostModelImpl _value, $Res Function(_$CostModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? currency = null,
  }) {
    return _then(_$CostModelImpl(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency,
    ));
  }
}

/// @nodoc

class _$CostModelImpl implements _CostModel {
  const _$CostModelImpl({required this.number, required this.currency});

  @override
  final double number;
  @override
  final Currency currency;

  @override
  String toString() {
    return 'CostModel(number: $number, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CostModelImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number, currency);

  /// Create a copy of CostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CostModelImplCopyWith<_$CostModelImpl> get copyWith =>
      __$$CostModelImplCopyWithImpl<_$CostModelImpl>(this, _$identity);
}

abstract class _CostModel implements CostModel {
  const factory _CostModel(
      {required final double number,
      required final Currency currency}) = _$CostModelImpl;

  @override
  double get number;
  @override
  Currency get currency;

  /// Create a copy of CostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CostModelImplCopyWith<_$CostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
