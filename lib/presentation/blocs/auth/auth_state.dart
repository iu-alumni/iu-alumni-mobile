import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.idle() = AuthStateIdle;
  const factory AuthState.loading() = AuthStateLoading;
  const factory AuthState.authorized() = AuthStateAuthorized;
  const factory AuthState.error(String error) = AuthStateError;
}