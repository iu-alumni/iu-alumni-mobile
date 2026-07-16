import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/models/profile.dart';
import '../../../application/models/project.dart';
import '../../../application/repositories/projects/projects_repository.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/projects_state.dart';

class OneProjectCubit extends Cubit<OneProjectState> {
  OneProjectCubit(this._repo, this._users) : super(const OneProjectState());

  final ProjectsRepository _repo;
  final UsersRepository _users;

  /// Cached current-user profile — populated on load. Kept locally so
  /// contribute / retract can update the contributors list optimistically
  /// without needing another users_by_ids round-trip.
  Profile? _me;

  String? get myId => _me?.profileId;

  Future<void> load(String projectId) async {
    emit(state.copyWith(project: const LoadedState.loading()));
    // Fire the project + me lookups in parallel.
    final mePromise = _users.loadMe();
    final projectPromise = _repo.getOne(projectId);
    final me = await mePromise;
    me.map((p) => _me = p);
    final project = await projectPromise;
    if (project == null) {
      emit(
        state.copyWith(
          project: const LoadedState.error('Project not found.'),
        ),
      );
      return;
    }

    // Resolve every profile we need for the details screen in one call:
    // the owner + every contributor. Both feed the tap targets on the
    // page. Failures downgrade to nulls / empty; the UI falls back to
    // "owner", "contributor" placeholders.
    final wantedIds = <String>{
      project.ownerId,
      ...project.contributorsIds,
    };
    List<Profile> profiles = const [];
    try {
      profiles = (await _users.getUsersByIds(wantedIds)).toList();
    } catch (_) {
      // getUsersByIds isn't guaranteed to be failure-tolerant — swallow
      // so a hiccup doesn't blank the whole details screen.
    }

    Profile? owner;
    final contributors = <Profile>[];
    for (final p in profiles) {
      if (p.profileId == project.ownerId) {
        owner = p;
      }
      if (project.contributorsIds.contains(p.profileId)) {
        contributors.add(p);
      }
    }
    // Preserve contributor ordering to match the project's list.
    contributors.sort(
      (a, b) => project.contributorsIds
          .indexOf(a.profileId)
          .compareTo(project.contributorsIds.indexOf(b.profileId)),
    );

    emit(
      OneProjectState(
        project: LoadedState.data(project),
        owner: owner,
        contributors: contributors,
      ),
    );
  }

  Future<bool> contribute() async {
    final current = _current();
    final me = _me;
    if (current == null || me == null || state.actionInFlight) {
      return false;
    }
    emit(state.copyWith(actionInFlight: true));
    final ok = await _repo.contribute(current.id);
    if (ok) {
      final ids = <String>[...current.contributorsIds];
      if (!ids.contains(me.profileId)) {
        ids.add(me.profileId);
      }
      final contributors = <Profile>[...state.contributors];
      if (!contributors.any((p) => p.profileId == me.profileId)) {
        contributors.add(me);
      }
      emit(
        OneProjectState(
          project: LoadedState.data(current.copyWith(contributorsIds: ids)),
          owner: state.owner,
          contributors: contributors,
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
    final me = _me;
    if (current == null || me == null || state.actionInFlight) {
      return false;
    }
    emit(state.copyWith(actionInFlight: true));
    final ok = await _repo.retract(current.id);
    if (ok) {
      final ids = current.contributorsIds
          .where((id) => id != me.profileId)
          .toList(growable: false);
      final contributors = state.contributors
          .where((p) => p.profileId != me.profileId)
          .toList(growable: false);
      emit(
        OneProjectState(
          project: LoadedState.data(current.copyWith(contributorsIds: ids)),
          owner: state.owner,
          contributors: contributors,
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
