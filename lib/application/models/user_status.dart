import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_status.freezed.dart';

@freezed
sealed class UserStatus with _$UserStatus {
  const factory UserStatus.author() = UserAuthor;
  const factory UserStatus.notAuthor({
    required String authorId,
    required bool participant,
  }) = UserNotAuthor;
}
