import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

/// Wire values for the two supported alumni roles. Kept as string
/// constants because Freezed sealed unions felt heavy for a two-value
/// enum that only crosses the network as a plain field.
const alumniRoleAlumni = 'alumni';
const alumniRoleFriend = 'alumni_friend';

@freezed
class Profile with _$Profile {
  const factory Profile({
    @JsonKey(name: 'id') required String profileId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    // NULL for Alumni Friends — the header shows an "Alumni Friend" chip
    // in place of the graduation-year tag when [isAlumniFriend].
    @JsonKey(name: 'graduation_year') required String? graduationYear,
    // Backend defaults to 'alumni'; older payloads that pre-date the
    // field are parsed as regular alumni via [_defaultRole].
    @JsonKey(name: 'role', defaultValue: alumniRoleAlumni) required String role,
    required String? location,
    required String? biography,
    @JsonKey(name: 'show_location') required bool showLocation,
    @JsonKey(name: 'telegram_alias') required String? telegramAlias,
    required String? avatar,
    @JsonKey(name: 'is_telegram_verified') required bool isTelegramVerified,
  }) = _Profile;
  const Profile._();

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  String get fullName => '$firstName $lastName';

  bool get isAlumniFriend => role == alumniRoleFriend;
}
