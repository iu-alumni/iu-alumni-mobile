import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../common/models/loaded_state.dart';

class AuthCubit extends Cubit<LoadedState> {
  AuthCubit(this._authRepository) : super(const LoadedState.init());

  final AuthRepository _authRepository;

  Future<void> authorize(String login, String password) async {
    emit(const LoadedState.loading());
    // final result = await _authRepository.authorize(login, password);
    await Future.delayed(const Duration(seconds: 1));
    final result = Either<String, Unit>.of(unit);
    emit(result.match(LoadedState.error, (_) => const LoadedState.data(unit)));
  }
}
