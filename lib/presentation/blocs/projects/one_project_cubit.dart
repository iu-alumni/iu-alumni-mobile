import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/models/project.dart';
import '../../../application/repositories/projects/projects_repository.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/projects_state.dart';

class OneProjectCubit extends Cubit<OneProjectState> {
  OneProjectCubit(this._repo, this._users) : super(const OneProjectState());

  final ProjectsRepository _repo;
  final UsersRepository _users;
  String? _myId;

  String? get myId => _myId;

  Future<void> load(String projectId) async {
    emit(state.copyWith(project: const LoadedState.loading()));
    // Fire both requests in parallel and reconcile at the end so the
    // details render as soon as both come back.
    final mePromise = _users.loadMe();
    final projectPromise = _repo.getOne(projectId);
    final me = await mePromise;
    me.map((p) => _myId = p.profileId);
    final project = await projectPromise;
    if (project == null) {
      emit(
        state.copyWith(
          project: const LoadedState.error('Project not found.'),
        ),
      );
      return;
    }
    emit(state.copyWith(project: LoadedState.data(project)));
  }

  Future<bool> contribute() async {
    final current = _current();
    final myId = _myId;
    if (current == null || myId == null || state.actionInFlight) {
      return false;
    }
    emit(state.copyWith(actionInFlight: true));
    final ok = await _repo.contribute(current.id);
    if (ok) {
      final ids = <String>[...current.contributorsIds];
      if (!ids.contains(myId)) {
        ids.add(myId);
      }
      emit(
        OneProjectState(
          project: LoadedState.data(current.copyWith(contributorsIds: ids)),
          actionInFlight: false,
        ),
      );
    } else {
      emit(state.copyWith(actionInFlight: false));
    }
    return ok;
  }

  Future<bool> retract() async {
    final current = _current();
    final myId = _myId;
    if (current == null || myId == null || state.actionInFlight) {
      return false;
    }
    emit(state.copyWith(actionInFlight: true));
    final ok = await _repo.retract(current.id);
    if (ok) {
      final ids = current.contributorsIds
          .where((id) => id != myId)
          .toList(growable: false);
      emit(
        OneProjectState(
          project: LoadedState.data(current.copyWith(contributorsIds: ids)),
          actionInFlight: false,
        ),
      );
    } else {
      emit(state.copyWith(actionInFlight: false));
    }
    return ok;
  }

  Future<bool> delete() async {
    final current = _current();
    if (current == null || state.actionInFlight) {
      return false;
    }
    emit(state.copyWith(actionInFlight: true));
    final ok = await _repo.delete(current.id);
    emit(state.copyWith(actionInFlight: false));
    return ok;
  }

  ProjectModel? _current() => switch (state.project) {
    LoadedStateData<ProjectModel>(:final data) => data,
    _ => null,
  };
}
