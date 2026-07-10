import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/projects/projects_repository.dart';
import '../../common/models/loaded_state.dart';
import '../models/projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this._repo) : super(const ProjectsState());

  final ProjectsRepository _repo;

  Future<void> load() async {
    emit(state.copyWith(projects: const LoadedState.loading()));
    final data = await _repo.listApproved();
    emit(state.copyWith(projects: LoadedState.data(data)));
  }

  Future<void> refresh() async {
    final data = await _repo.listApproved();
    emit(state.copyWith(projects: LoadedState.data(data)));
  }
}
