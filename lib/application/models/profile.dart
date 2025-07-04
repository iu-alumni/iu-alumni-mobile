import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  factory Profile({
    @JsonKey(name: 'id') required String profileId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'graduation_year') required String graduationYear,
    required String? location,
    required String? biography,
    @JsonKey(name: 'show_location') required bool showLocation,
    @JsonKey(name: 'telegram_alias') required String? telegramAlias,
    required String? avatar,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
