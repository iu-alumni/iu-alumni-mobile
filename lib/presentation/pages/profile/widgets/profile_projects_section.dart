import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/models/project.dart';
import '../../../../application/repositories/projects/projects_repository.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/titled_item.dart';
import '../../../router/app_router.gr.dart';

const double _cardWidth = 220;

/// Section on the *personal* profile that lists every project the current
/// user owns, in any status (approved / pending / declined).
class MyOwnedProjects extends StatefulWidget {
  const MyOwnedProjects();

  @override
  State<MyOwnedProjects> createState() => MyOwnedProjectsState();
}

class MyOwnedProjectsState extends State<MyOwnedProjects> {
  late Future<List<ProjectModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<ProjectsRepository>().listMyOwned();
  }

  @override
  Widget build(BuildContext context) => _ProjectSection(
    title: 'Created projects',
    emptyMessage: 'You have not created any projects yet.',
    future: _future,
  );
}

/// Section on any profile — lists **approved** projects the target user
/// has contributed to. Hidden on other-user profiles when empty; on the
/// personal profile it stays visible with an empty message.
class ContributedProjects extends StatefulWidget {
  const ContributedProjects({required this.profileId});

  final String profileId;

  @override
  State<ContributedProjects> createState() => ContributedProjectsState();
}

class ContributedProjectsState extends State<ContributedProjects> {
  late Future<List<ProjectModel>> _future;

  @override
  void initState() {
    super.initState();
    // The `me` endpoint returns MY contributions; the `{alumni_id}` one is
    // for other users. The profile screen doesn't tell us which we're on
    // here — always use the by-id endpoint so both work; the backend
    // filters to approved-only regardless.
    _future = context
        .read<ProjectsRepository>()
        .listContributedBy(widget.profileId);
  }

  @override
  Widget build(BuildContext context) => _ProjectSection(
    title: 'Contributed projects',
    emptyMessage: 'No contributions yet.',
    future: _future,
  );
}

class _ProjectSection extends StatelessWidget {
  const _ProjectSection({
    required this.title,
    required this.emptyMessage,
    required this.future,
  });

  final String title;
  final String emptyMessage;
  final Future<List<ProjectModel>> future;

  @override
  Widget build(BuildContext context) => TitledItem(
    title: title,
    child: FutureBuilder<List<ProjectModel>>(
      future: future,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: AppLoader()),
          );
        }
        final items = snap.data ?? const <ProjectModel>[];
        if (items.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              emptyMessage,
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          );
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final p in items) ...[
                SizedBox(width: _cardWidth, child: _MiniProjectCard(project: p)),
                const SizedBox(width: 8),
              ],
            ],
          ),
        );
      },
    ),
  );
}

class _MiniProjectCard extends StatelessWidget {
  const _MiniProjectCard({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final bytes = _decode(project.cover);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.pushRoute(ProjectRoute(projectId: project.id)),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gray80),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 96,
                  child: bytes != null
                      ? Image.memory(bytes, fit: BoxFit.cover)
                      : Container(
                          color: AppColors.gray90,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.emoji_objects_outlined,
                            color: AppColors.gray50,
                            size: 30,
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.darkGray,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _statusOrCount(project),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.gray50,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _statusOrCount(ProjectModel p) => switch (p.approval) {
    ProjectApproval.pending => 'Pending admin review',
    ProjectApproval.declined => 'Declined',
    ProjectApproval.approved => p.contributorCount == 1
        ? '1 contributor'
        : '${p.contributorCount} contributors',
  };

  static Uint8List? _decode(String? cover) {
    if (cover == null || cover.isEmpty) {
      return null;
    }
    try {
      return base64Decode(cover);
    } catch (_) {
      return null;
    }
  }
}
