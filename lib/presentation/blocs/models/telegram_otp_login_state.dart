import 'package:fpdart/fpdart.dart';

import '../../common/models/loaded_state.dart';

class TelegramOtpLoginState {
  const TelegramOtpLoginState({
    required this.request,
    required this.verify,
    required this.code,
  });

  final LoadedState<Unit> request;
  final LoadedState<Unit> verify;
  final String code;

  TelegramOtpLoginState copyWith({
    LoadedState<Unit>? request,
    LoadedState<Unit>? verify,
    String? code,
  }) => TelegramOtpLoginState(
    request: request ?? this.request,
    verify: verify ?? this.verify,
    code: code ?? this.code,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TelegramOtpLoginState &&
          request == other.request &&
          verify == other.verify &&
          code == other.code;

  @override
  int get hashCode => Object.hash(request, verify, code);
}
