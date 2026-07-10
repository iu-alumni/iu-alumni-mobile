import 'package:flutter/foundation.dart';

import '../../../application/models/project.dart';
import '../../common/models/loaded_state.dart';

@immutable
class ProjectsState {
  const ProjectsState({this.projects = const LoadedState.init()});

  final LoadedState<List<ProjectModel>> projects;

  ProjectsState copyWith({LoadedState<List<ProjectModel>>? projects}) =>
      ProjectsState(projects: projects ?? this.projects);
}

@immutable
class OneProjectState {
  const OneProjectState({
    this.project = const LoadedState.init(),
    this.actionInFlight = false,
  });

  final LoadedState<ProjectModel> project;

  /// Contribute / retract / delete / save currently running — used to
  /// keep the button in a loading state and prevent double-taps.
  final bool actionInFlight;

  OneProjectState copyWith({
    LoadedState<ProjectModel>? project,
    bool? actionInFlight,
  }) => OneProjectState(
    project: project ?? this.project,
    actionInFlight: actionInFlight ?? this.actionInFlight,
  );
}
