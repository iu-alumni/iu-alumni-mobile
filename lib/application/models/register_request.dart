import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@Freezed(fromJson: false, toJson: true)
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'graduation_year') required String gradYear,
    required String email,
    @JsonKey(name: 'telegram_alias') required String telegram,
    required String password,
    @JsonKey(name: 'manual_verification') required bool manualVerification,
  }) = _RegisterRequest;
}
