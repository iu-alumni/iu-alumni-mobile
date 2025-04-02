import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../application/models/profile.dart';
import '../../../application/repositories/profile/profile_repository.dart';

typedef ProfileEditingState = Option<Profile>;

class ProfileEditingCubit extends Cubit<ProfileEditingState> {
  ProfileEditingCubit(this._repository) : super(const None());

  final ProfileRepository _repository;

  void update(Profile Function(Profile) fun) => emit(state.map(fun));

  void loadProfile() async {
    final profile = await _repository.loadProfile();
    emit(profile);
  }

  void save() => state.map(_repository.update);
}
