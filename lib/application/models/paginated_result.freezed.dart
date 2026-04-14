// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaginatedResult<T> _$PaginatedResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _PaginatedResult<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$PaginatedResult<T> {
  List<T> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_cursor')
  String? get nextCursor => throw _privateConstructorUsedError;

  /// Serializes this PaginatedResult to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedResultCopyWith<T, PaginatedResult<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedResultCopyWith<T, $Res> {
  factory $PaginatedResultCopyWith(
    PaginatedResult<T> value,
    $Res Function(PaginatedResult<T>) then,
  ) = _$PaginatedResultCopyWithImpl<T, $Res, PaginatedResult<T>>;
  @useResult
  $Res call({List<T> items, @JsonKey(name: 'next_cursor') String? nextCursor});
}

/// @nodoc
class _$PaginatedResultCopyWithImpl<T, $Res, $Val extends PaginatedResult<T>>
    implements $PaginatedResultCopyWith<T, $Res> {
  _$PaginatedResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? nextCursor = freezed}) {
    return _then(
      _value.copyWith(
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<T>,
            nextCursor:
                freezed == nextCursor
                    ? _value.nextCursor
                    : nextCursor // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedResultImplCopyWith<T, $Res>
    implements $PaginatedResultCopyWith<T, $Res> {
  factory _$$PaginatedResultImplCopyWith(
    _$PaginatedResultImpl<T> value,
    $Res Function(_$PaginatedResultImpl<T>) then,
  ) = __$$PaginatedResultImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<T> items, @JsonKey(name: 'next_cursor') String? nextCursor});
}

/// @nodoc
class __$$PaginatedResultImplCopyWithImpl<T, $Res>
    extends _$PaginatedResultCopyWithImpl<T, $Res, _$PaginatedResultImpl<T>>
    implements _$$PaginatedResultImplCopyWith<T, $Res> {
  __$$PaginatedResultImplCopyWithImpl(
    _$PaginatedResultImpl<T> _value,
    $Res Function(_$PaginatedResultImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? nextCursor = freezed}) {
    return _then(
      _$PaginatedResultImpl<T>(
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<T>,
        nextCursor:
            freezed == nextCursor
                ? _value.nextCursor
                : nextCursor // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$PaginatedResultImpl<T> implements _PaginatedResult<T> {
  const _$PaginatedResultImpl({
    required final List<T> items,
    @JsonKey(name: 'next_cursor') this.nextCursor,
  }) : _items = items;

  factory _$PaginatedResultImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$PaginatedResultImplFromJson(json, fromJsonT);

  final List<T> _items;
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'next_cursor')
  final String? nextCursor;

  @override
  String toString() {
    return 'PaginatedResult<$T>(items: $items, nextCursor: $nextCursor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedResultImpl<T> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    nextCursor,
  );

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedResultImplCopyWith<T, _$PaginatedResultImpl<T>> get copyWith =>
      __$$PaginatedResultImplCopyWithImpl<T, _$PaginatedResultImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$PaginatedResultImplToJson<T>(this, toJsonT);
  }
}

abstract class _PaginatedResult<T> implements PaginatedResult<T> {
  const factory _PaginatedResult({
    required final List<T> items,
    @JsonKey(name: 'next_cursor') final String? nextCursor,
  }) = _$PaginatedResultImpl<T>;

  factory _PaginatedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$PaginatedResultImpl<T>.fromJson;

  @override
  List<T> get items;
  @override
  @JsonKey(name: 'next_cursor')
  String? get nextCursor;

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedResultImplCopyWith<T, _$PaginatedResultImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
