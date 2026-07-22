import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    @JsonKey(name: 'id') required String profileId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'graduation_year') required String graduationYear,
    required String? location,
    required String? biography,
    @JsonKey(name: 'show_location') required bool showLocation,
    @JsonKey(name: 'telegram_alias') required String? telegramAlias,
    required String? avatar,
    @JsonKey(name: 'is_telegram_verified') required bool isTelegramVerified,
    @JsonKey(name: 'followers_count') @Default(0) int followersCount,
    @JsonKey(name: 'following_count') @Default(0) int followingCount,
    @JsonKey(name: 'is_following') @Default(false) bool isFollowing,
  }) = _Profile;
  const Profile._();

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  String get fullName => '$firstName $lastName';
}
