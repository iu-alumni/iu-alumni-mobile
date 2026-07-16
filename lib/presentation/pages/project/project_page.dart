import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:url_launcher/url_launcher.dart';

import '../../../application/models/profile.dart';
import '../../../application/models/project.dart';
import '../../../application/repositories/projects/projects_repository.dart';
import '../../../application/repositories/users/users_repository.dart';
import '../../blocs/models/projects_state.dart';
import '../../blocs/projects/one_project_cubit.dart';
import '../../blocs/projects/projects_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/loaded_state.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_loader.dart';
import '../../common/widgets/app_scaffold.dart';
import '../../common/widgets/profile_pic.dart';
import '../../router/app_router.gr.dart';

@RoutePage()
class ProjectPage extends StatelessWidget implements AutoRouteWrapper {
  const ProjectPage({required this.projectId, super.key});

  final String projectId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    create: (ctx) => OneProjectCubit(
      ctx.read<ProjectsRepository>(),
      ctx.read<UsersRepository>(),
    )..load(projectId),
    child: this,
  );

  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Project',
    body: AppChildBody(
      padding: EdgeInsets.zero,
      child: BlocBuilder<OneProjectCubit, OneProjectState>(
        builder: (context, state) => switch (state.project) {
          LoadedStateData<ProjectModel>(:final data) => _Body(
            project: data,
            owner: state.owner,
            contributors: state.contributors,
            actionInFlight: state.actionInFlight,
          ),
          LoadedStateError(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
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

class _Body extends StatelessWidget {
  const _Body({
    required this.project,
    required this.owner,
    required this.contributors,
    required this.actionInFlight,
  });

  final ProjectModel project;
  final Profile? owner;
  final List<Profile> contributors;
  final bool actionInFlight;

  @override
  Widget build(BuildContext context) {
    final oneCubit = context.read<OneProjectCubit>();
    final myId = oneCubit.myId;
    final isOwner = myId != null && myId == project.ownerId;
    final iContributed = myId != null && project.isContributedBy(myId);

    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 96),
      children: [
        _Cover(cover: project.cover),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              if (isOwner && project.approval != ProjectApproval.approved)
                _StatusBanner(approval: project.approval),
              Text(
                project.title,
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 12),
              _OwnerRow(owner: owner, ownerId: project.ownerId),
              const SizedBox(height: 12),
              _ContributorsTap(
                project: project,
                contributors: contributors,
              ),
              const SizedBox(height: 16),
              Text(
                project.description,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.gray30,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              if (isOwner)
                _EditButton(project: project)
              else
                _ContributeButton(
                  active: iContributed,
                  loading: actionInFlight,
                  canAct: myId != null &&
                      project.approval == ProjectApproval.approved,
                  onTap: () async {
                    final cubit = context.read<OneProjectCubit>();
                    final ok = iContributed
                        ? await cubit.retract()
                        : await cubit.contribute();
                    if (ok && context.mounted) {
                      // Keep the list tab in sync so the count updates
                      // when the user goes back.
                      context.read<ProjectsCubit>().refresh();
                    }
                  },
                ),
              if (project.donationLink case final link?
                  when link.isNotEmpty &&
                      project.approval == ProjectApproval.approved) ...[
                const SizedBox(height: 12),
                _DonateButton(url: link),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _OwnerRow extends StatelessWidget {
  const _OwnerRow({required this.owner, required this.ownerId});

  final Profile? owner;
  final String ownerId;

  @override
  Widget build(BuildContext context) {
    final displayName = owner?.fullName ?? 'Alumni';
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: owner == null
          ? null
          : () => context.pushRoute(ProfileRoute(profile: Option.of(owner!))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            if (owner case final o?)
              ProfilePic(profile: o, size: 28)
            else
              const CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.gray90,
                child: Icon(Icons.person, size: 16, color: AppColors.gray50),
              ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Proposed by',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.gray50,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    displayName,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.w600,
                      decoration: owner == null
                          ? TextDecoration.none
                          : TextDecoration.underline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (owner != null)
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColors.gray50,
              ),
          ],
        ),
      ),
    );
  }
}

class _ContributorsTap extends StatelessWidget {
  const _ContributorsTap({required this.project, required this.contributors});

  final ProjectModel project;
  final List<Profile> contributors;

  @override
  Widget build(BuildContext context) {
    final count = project.contributorCount;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: count == 0
          ? null
          : () => _ContributorsSheet.show(context, contributors, count),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            const Icon(
              Icons.people_outline,
              size: 16,
              color: AppColors.gray50,
            ),
            const SizedBox(width: 6),
            Text(
              count == 1 ? '1 contributor' : '$count contributors',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.gray50,
                decoration: count == 0
                    ? TextDecoration.none
                    : TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContributorsSheet {
  static Future<void> show(
    BuildContext context,
    List<Profile> contributors,
    int count,
  ) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (_, scrollController) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.gray80,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              count == 1 ? '1 contributor' : '$count contributors',
              style: AppTextStyles.subtitle.copyWith(
                color: AppColors.darkGray,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 4),
          if (contributors.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Center(
                child: Text(
                  'Could not load contributor profiles.',
                  style: AppTextStyles.caption.copyWith(color: AppColors.gray50),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: contributors.length,
                itemBuilder: (context, i) => _ContributorTile(
                  profile: contributors[i],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

class _ContributorTile extends StatelessWidget {
  const _ContributorTile({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      Navigator.of(context).pop();
      context.pushRoute(ProfileRoute(profile: Option.of(profile)));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          ProfilePic(profile: profile, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  profile.fullName,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (profile.location case final loc?)
                  Text(
                    loc,
                    style: AppTextStyles.caption.copyWith(color: AppColors.gray50),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: AppColors.gray50,
          ),
        ],
      ),
    ),
  );
}

class _Cover extends StatelessWidget {
  const _Cover({required this.cover});

  final String? cover;

  static const _height = 200.0;

  @override
  Widget build(BuildContext context) {
    final bytes = _decode(cover);
    if (bytes == null) {
      return Container(
        height: _height,
        color: AppColors.gray90,
        alignment: Alignment.center,
        child: const Icon(
          Icons.emoji_objects_outlined,
          color: AppColors.gray50,
          size: 60,
        ),
      );
    }
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: Image.memory(bytes, fit: BoxFit.cover),
    );
  }

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

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.approval});

  final ProjectApproval approval;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg, icon) = switch (approval) {
      ProjectApproval.pending => (
        'Waiting for admin approval — only visible to you.',
        const Color(0xFFFFF3CE),
        const Color(0xFF7A5A00),
        Icons.hourglass_top,
      ),
      ProjectApproval.declined => (
        'Declined by admin. Edit and resubmit for review.',
        const Color(0xFFFEE2E2),
        const Color(0xFFB91C1C),
        Icons.close_rounded,
      ),
      ProjectApproval.approved => ('', Colors.transparent, Colors.transparent, Icons.check),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: fg, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContributeButton extends StatelessWidget {
  const _ContributeButton({
    required this.active,
    required this.loading,
    required this.canAct,
    required this.onTap,
  });

  final bool active;
  final bool loading;
  final bool canAct;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => AppButton(
    buttonStyle: active ? AppButtonStyle.secondary : AppButtonStyle.primary,
    onTap: canAct && !loading ? onTap : () {},
    child: loading
        ? const Center(child: AppLoader(color: Colors.white))
        : Text(
            !canAct
                ? 'Contribute'
                : active
                    ? 'I contributed 👍'
                    : 'Contribute',
            style: AppTextStyles.actionSB.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
  );
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) => AppButton(
    buttonStyle: AppButtonStyle.primary,
    onTap: () async {
      await context.pushRoute(ProjectEditingRoute(projectId: project.id));
      if (context.mounted) {
        await context.read<OneProjectCubit>().load(project.id);
      }
    },
    child: Text(
      'Edit',
      style: AppTextStyles.actionSB.copyWith(color: Colors.white),
      textAlign: TextAlign.center,
    ),
  );
}

class _DonateButton extends StatelessWidget {
  const _DonateButton({required this.url});

  final String url;

  Future<void> _open(BuildContext context) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return;
    }
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) => AppButton(
    buttonStyle: AppButtonStyle.secondary,
    onTap: () => _open(context),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.volunteer_activism, color: Colors.white, size: 18),
        const SizedBox(width: 8),
        Text(
          'Donate',
          style: AppTextStyles.actionSB.copyWith(color: Colors.white),
        ),
      ],
    ),
  );
}
