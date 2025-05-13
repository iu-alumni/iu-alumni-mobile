// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() author,
    required TResult Function(String authorId, bool participant) notAuthor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? author,
    TResult? Function(String authorId, bool participant)? notAuthor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? author,
    TResult Function(String authorId, bool participant)? notAuthor,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserAuthor value) author,
    required TResult Function(UserNotAuthor value) notAuthor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserAuthor value)? author,
    TResult? Function(UserNotAuthor value)? notAuthor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserAuthor value)? author,
    TResult Function(UserNotAuthor value)? notAuthor,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatusCopyWith<$Res> {
  factory $UserStatusCopyWith(
          UserStatus value, $Res Function(UserStatus) then) =
      _$UserStatusCopyWithImpl<$Res, UserStatus>;
}

/// @nodoc
class _$UserStatusCopyWithImpl<$Res, $Val extends UserStatus>
    implements $UserStatusCopyWith<$Res> {
  _$UserStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UserAuthorImplCopyWith<$Res> {
  factory _$$UserAuthorImplCopyWith(
          _$UserAuthorImpl value, $Res Function(_$UserAuthorImpl) then) =
      __$$UserAuthorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserAuthorImplCopyWithImpl<$Res>
    extends _$UserStatusCopyWithImpl<$Res, _$UserAuthorImpl>
    implements _$$UserAuthorImplCopyWith<$Res> {
  __$$UserAuthorImplCopyWithImpl(
      _$UserAuthorImpl _value, $Res Function(_$UserAuthorImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UserAuthorImpl implements UserAuthor {
  const _$UserAuthorImpl();

  @override
  String toString() {
    return 'UserStatus.author()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserAuthorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() author,
    required TResult Function(String authorId, bool participant) notAuthor,
  }) {
    return author();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? author,
    TResult? Function(String authorId, bool participant)? notAuthor,
  }) {
    return author?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? author,
    TResult Function(String authorId, bool participant)? notAuthor,
    required TResult orElse(),
  }) {
    if (author != null) {
      return author();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserAuthor value) author,
    required TResult Function(UserNotAuthor value) notAuthor,
  }) {
    return author(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserAuthor value)? author,
    TResult? Function(UserNotAuthor value)? notAuthor,
  }) {
    return author?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserAuthor value)? author,
    TResult Function(UserNotAuthor value)? notAuthor,
    required TResult orElse(),
  }) {
    if (author != null) {
      return author(this);
    }
    return orElse();
  }
}

abstract class UserAuthor implements UserStatus {
  const factory UserAuthor() = _$UserAuthorImpl;
}

/// @nodoc
abstract class _$$UserNotAuthorImplCopyWith<$Res> {
  factory _$$UserNotAuthorImplCopyWith(
          _$UserNotAuthorImpl value, $Res Function(_$UserNotAuthorImpl) then) =
      __$$UserNotAuthorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String authorId, bool participant});
}

/// @nodoc
class __$$UserNotAuthorImplCopyWithImpl<$Res>
    extends _$UserStatusCopyWithImpl<$Res, _$UserNotAuthorImpl>
    implements _$$UserNotAuthorImplCopyWith<$Res> {
  __$$UserNotAuthorImplCopyWithImpl(
      _$UserNotAuthorImpl _value, $Res Function(_$UserNotAuthorImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorId = null,
    Object? participant = null,
  }) {
    return _then(_$UserNotAuthorImpl(
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      participant: null == participant
          ? _value.participant
          : participant // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UserNotAuthorImpl implements UserNotAuthor {
  const _$UserNotAuthorImpl(
      {required this.authorId, required this.participant});

  @override
  final String authorId;
  @override
  final bool participant;

  @override
  String toString() {
    return 'UserStatus.notAuthor(authorId: $authorId, participant: $participant)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserNotAuthorImpl &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.participant, participant) ||
                other.participant == participant));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authorId, participant);

  /// Create a copy of UserStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserNotAuthorImplCopyWith<_$UserNotAuthorImpl> get copyWith =>
      __$$UserNotAuthorImplCopyWithImpl<_$UserNotAuthorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() author,
    required TResult Function(String authorId, bool participant) notAuthor,
  }) {
    return notAuthor(authorId, participant);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? author,
    TResult? Function(String authorId, bool participant)? notAuthor,
  }) {
    return notAuthor?.call(authorId, participant);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? author,
    TResult Function(String authorId, bool participant)? notAuthor,
    required TResult orElse(),
  }) {
    if (notAuthor != null) {
      return notAuthor(authorId, participant);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserAuthor value) author,
    required TResult Function(UserNotAuthor value) notAuthor,
  }) {
    return notAuthor(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserAuthor value)? author,
    TResult? Function(UserNotAuthor value)? notAuthor,
  }) {
    return notAuthor?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserAuthor value)? author,
    TResult Function(UserNotAuthor value)? notAuthor,
    required TResult orElse(),
  }) {
    if (notAuthor != null) {
      return notAuthor(this);
    }
    return orElse();
  }
}

abstract class UserNotAuthor implements UserStatus {
  const factory UserNotAuthor(
      {required final String authorId,
      required final bool participant}) = _$UserNotAuthorImpl;

  String get authorId;
  bool get participant;

  /// Create a copy of UserStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserNotAuthorImplCopyWith<_$UserNotAuthorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
