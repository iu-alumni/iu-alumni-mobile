import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/models/profile.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/profile_editing_state.dart';

class ProfileEditingCubit extends Cubit<ProfileEditingState> {
  ProfileEditingCubit(this._repository, this._reporter)
    : super(
        const ProfileEditingState(
          profile: None(),
          saveState: LoadedState.init(),
        ),
      );

  final UsersRepository _repository;
  final Reporter _reporter;

  void update(Profile Function(Profile) fun) =>
      emit(state.copyWith(profile: state.profile.map(fun)));

  Future<void> loadProfile() async {
    final profile = await _repository.loadMe();
    emit(state.copyWith(profile: profile));
  }

  void save() => state.profile.map((p) async {
    final firstName = p.firstName.trim();
    final lastName = p.lastName.trim();
    if (firstName.isEmpty || lastName.isEmpty) {
      emit(
        state.copyWith(
          saveState: const LoadedState.error('Please fill all required fields'),
        ),
      );
      return;
    }

    final profile = p.copyWith(firstName: firstName, lastName: lastName);
    _reporter.reportSaveProfileChanges(AppLocation.profileEditingScreen);
    emit(state.copyWith(saveState: const LoadedState.loading()));
    final success = await _repository.update(profile);
    emit(
      state.copyWith(
        profile: success ? Option.of(profile) : state.profile,
        saveState: success
            ? const LoadedState.data(unit)
            : const LoadedState.error('Could not save the modifications'),
      ),
    );
  });
}
