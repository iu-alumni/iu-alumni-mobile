import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@Freezed(fromJson: false, toJson: true)
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String email,
    required String password,
    @JsonKey(name: 'manual_verification') required bool manualVerification,
    // Null for Alumni Friends — backend nulls it anyway when role is
    // 'alumni_friend', but omitting the field on the wire keeps things
    // clean.
    @JsonKey(name: 'graduation_year', includeIfNull: false) String? gradYear,
    // Defaults to 'alumni'. Registration form is a radio; validation
    // that grad_year is set for role=alumni happens on the backend.
    @JsonKey(name: 'role') @Default('alumni') String role,
    @JsonKey(name: 'telegram_alias') String? telegram,
  }) = _RegisterRequest;
}
