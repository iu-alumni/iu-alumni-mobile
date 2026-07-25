import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/models/profile.dart';
import '../../../application/models/project.dart';
import '../../../application/repositories/projects/projects_repository.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this._repo, this._users) : super(const ProjectsState());

  final ProjectsRepository _repo;
  final UsersRepository _users;

  Future<void> load() async {
    emit(state.copyWith(projects: const LoadedState.loading()));
    final data = await _repo.listApproved();
    emit(state.copyWith(projects: LoadedState.data(data)));
    await _hydrateContributorProfiles(data);
  }

  Future<void> refresh() async {
    final data = await _repo.listApproved();
    emit(state.copyWith(projects: LoadedState.data(data)));
    await _hydrateContributorProfiles(data);
  }

  /// One batched getUsersByIds call per list refresh — pulls the profile
  /// for every contributor across every visible card so the avatar
  /// stacks can render real photos. Reuses cached entries to avoid
  /// re-fetching users we already resolved.
  Future<void> _hydrateContributorProfiles(List<ProjectModel> projects) async {
    final wanted = <String>{
      for (final p in projects) ...p.contributorsIds,
    }..removeWhere(state.profilesByAlumniId.containsKey);
    if (wanted.isEmpty) {
      return;
    }
    try {
      final profiles = await _users.getUsersByIds(wanted);
      final merged = <String, Profile>{
        ...state.profilesByAlumniId,
        for (final p in profiles) p.profileId: p,
      };
      emit(state.copyWith(profilesByAlumniId: merged));
    } catch (_) {
      // Non-fatal: card falls back to placeholder circles.
    }
  }
}
