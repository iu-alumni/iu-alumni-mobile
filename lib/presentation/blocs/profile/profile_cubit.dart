import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/models/profile.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';

typedef ProfileState = LoadedState<Profile>;
typedef ProfileData = LoadedStateData<Profile>;
typedef ProfileLoading = LoadedStateLoading<Profile>;
typedef ProfileError = LoadedStateError<Profile>;

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repository) : super(const LoadedState.init());

  final UsersRepository _repository;

  void loadProfile() async {
    final profile = await _repository.loadMe();
    emit(
      profile.match(
        () => const LoadedState.error('Could not load'),
        LoadedState.data,
      ),
    );
  }

  void logout() {
    _repository.logout();
  }
}
