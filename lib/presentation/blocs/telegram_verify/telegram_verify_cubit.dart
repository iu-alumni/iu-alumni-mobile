import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/repositories/auth/telegram_verify_repository.dart';
import '../../common/models/loaded_state.dart';

class TelegramVerifyState {
  const TelegramVerifyState({required this.request});

  const TelegramVerifyState.init() : request = const LoadedState.init();

  final LoadedState<Unit> request;

  TelegramVerifyState copyWith({LoadedState<Unit>? request}) =>
      TelegramVerifyState(request: request ?? this.request);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TelegramVerifyState && request == other.request;

  @override
  int get hashCode => request.hashCode;
}

class TelegramVerifyCubit extends Cubit<TelegramVerifyState> {
  TelegramVerifyCubit(this._repository)
      : super(const TelegramVerifyState.init());

  final TelegramVerifyRepository _repository;

  Future<void> requestVerification() async {
    emit(state.copyWith(request: const LoadedState.loading()));
    final result = await _repository.requestVerification();
    emit(state.copyWith(
      request: result.match(
        LoadedState.error,
        (_) => const LoadedState.data(unit),
      ),
    ));
  }

  void reset() => emit(const TelegramVerifyState.init());
}
