import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/models/profile.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/profile_editing_state.dart';

class ProfileEditingCubit extends Cubit<ProfileEditingState> {
  ProfileEditingCubit(this._repository)
      : super(
          ProfileEditingState(
            profile: const None(),
            saveState: const LoadedState.init(),
          ),
        );

  final UsersRepository _repository;

  void update(Profile Function(Profile) fun) => emit(
        state.copyWith(profile: state.profile.map(fun)),
      );

  void loadProfile() async {
    final profile = await _repository.loadMe();
    emit(state.copyWith(profile: profile));
  }

  void save() => state.profile.map((p) async {
        emit(state.copyWith(saveState: const LoadedState.loading()));
        final success = await _repository.update(p);
        emit(
          state.copyWith(
            saveState: success
                ? const LoadedState.data(unit)
                : const LoadedState.error('Could not save the modifications'),
          ),
        );
      });
}
