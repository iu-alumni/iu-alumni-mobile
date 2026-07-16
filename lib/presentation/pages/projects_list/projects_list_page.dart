import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/models/project.dart';
import '../../blocs/models/projects_state.dart';
import '../../blocs/projects/projects_cubit.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_loader.dart';
import '../../common/widgets/app_scaffold.dart';
import '../../router/app_router.gr.dart';
import 'widgets/project_card.dart';

class ProjectsListPage extends StatefulWidget {
  const ProjectsListPage({super.key});

  @override
  State<ProjectsListPage> createState() => _ProjectsListPageState();
}

class _ProjectsListPageState extends State<ProjectsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectsCubit>().load();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Projects',
    leadingButton: null,
    actions: [
      AppButton(
        is48Height: true,
        child: Text(
          'Create',
          style: AppTextStyles.actionSB.copyWith(color: Colors.white),
        ),
        onTap: () =>
            context.pushRoute(ProjectEditingRoute(projectId: null)),
      ),
    ],
    body: AppChildBody(
      padding: EdgeInsets.zero,
      child: BlocBuilder<ProjectsCubit, ProjectsState>(
        buildWhen: (p, c) => p.projects != c.projects,
        builder: (context, state) => switch (state.projects) {
          LoadedStateData<List<ProjectModel>>(:final data) when data.isEmpty =>
            const _Empty(),
          LoadedStateData<List<ProjectModel>>(:final data) => _List(items: data),
          LoadedStateError(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                error,
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _ => const Center(child: AppLoader(inCard: true)),
        },
      ),
    ),
  );
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'No projects yet — be the first to propose one.',
        style: AppTextStyles.caption,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

class _List extends StatelessWidget {
  const _List({required this.items});

  final List<ProjectModel> items;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: () => context.read<ProjectsCubit>().refresh(),
    child: ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, i) => ProjectCard(
        project: items[i],
        onTap: () =>
            context.pushRoute(ProjectRoute(projectId: items[i].id)),
      ),
    ),
  );
}
