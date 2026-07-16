import 'package:flutter/foundation.dart';

import '../../../application/models/profile.dart';
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
    this.owner,
    this.contributors = const <Profile>[],
    this.actionInFlight = false,
  });

  final LoadedState<ProjectModel> project;

  /// Owner profile once fetched, null while loading or on failure.
  /// Used to render the tappable owner name on the details screen.
  final Profile? owner;

  /// Full contributor profiles for the details bottom-sheet. Empty
  /// while the details screen is loading; populated in the same pass
  /// as the project itself.
  final List<Profile> contributors;

  /// Contribute / retract / delete / save currently running — used to
  /// keep the button in a loading state and prevent double-taps.
  final bool actionInFlight;

  OneProjectState copyWith({
    LoadedState<ProjectModel>? project,
    Profile? owner,
    List<Profile>? contributors,
    bool? actionInFlight,
  }) => OneProjectState(
    project: project ?? this.project,
    owner: owner ?? this.owner,
    contributors: contributors ?? this.contributors,
    actionInFlight: actionInFlight ?? this.actionInFlight,
  );
}
