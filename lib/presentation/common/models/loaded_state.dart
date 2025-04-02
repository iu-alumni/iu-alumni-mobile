import 'package:freezed_annotation/freezed_annotation.dart';

part 'loaded_state.freezed.dart';

@freezed
sealed class LoadedState<T> with _$LoadedState {
  const factory LoadedState.init() = LoadedStateInit;
  const factory LoadedState.loading() = LoadedStateLoading;
  const factory LoadedState.data(T data) = LoadedStateData;
  const factory LoadedState.error(String error) = LoadedStateError;
}
