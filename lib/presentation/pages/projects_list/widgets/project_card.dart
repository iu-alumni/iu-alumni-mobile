import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../application/models/profile.dart';
import '../../../../application/models/project.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/widgets/profile_pic.dart';

/// Variant-B card layout, from mockups/04-projects-B.html.
/// Row 1: cover thumb + title + description.
/// Middle: progress bar + "₽X raised of ₽Y · N contributors".
/// Row bottom: contributor avatar stack + Donate CTA (opens
/// `donation_link` externally).
///
/// Progress bar + amounts row is hidden when no `goalAmount` is set —
/// support-only projects (like the Mentorship Circle) don't render as
/// half-empty fundraisers.
class ProjectCard extends StatelessWidget {
  const ProjectCard({
    required this.project,
    required this.profilesByAlumniId,
    this.onTap,
    this.onDonate,
    super.key,
  });

  final ProjectModel project;

  /// Map keyed by alumni id — supplies real avatars for the stack when
  /// the ProjectsCubit has resolved them. Missing ids fall back to a
  /// deterministic colored initial.
  final Map<String, Profile> profilesByAlumniId;

  final VoidCallback? onTap;

  /// Fired when the Donate button is tapped. Nullable so callers can
  /// hide the button entirely (project without a donation link, or a
  /// pending / declined project).
  final VoidCallback? onDonate;

  /// Show the fundraising row on anything that CAN take money — has a
  /// donation link or an explicit goal. Support-only projects
  /// (Mentorship Circle etc.) stay clean without a money bar.
  bool get _showMoneyRow {
    final goal = project.goalAmount;
    final hasLink = project.donationLink != null && project.donationLink!.isNotEmpty;
    return hasLink || (goal != null && goal > 0);
  }

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.gray80),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _HeaderRow(project: project),
            const SizedBox(height: 12),
            if (_showMoneyRow) ...[
              _ProgressBar(fraction: project.progressFraction),
              const SizedBox(height: 6),
              _AmountsRow(project: project),
              const SizedBox(height: 10),
            ],
            _BottomRow(
              project: project,
              profilesByAlumniId: profilesByAlumniId,
              onDonate: onDonate,
            ),
          ],
        ),
      ),
    ),
  );
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _Thumb(cover: project.cover),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (project.approval != ProjectApproval.approved)
                  _StatusPill(approval: project.approval),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              project.description,
              style: AppTextStyles.caption.copyWith(color: AppColors.gray30),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.cover});

  final String? cover;

  static const _size = 72.0;

  @override
  Widget build(BuildContext context) {
    final bytes = _decodeCover(cover);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: _size,
        height: _size,
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
    );
  }

  static Uint8List? _decodeCover(String? cover) {
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

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.fraction});

  final double fraction;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(999),
    child: LinearProgressIndicator(
      value: fraction,
      minHeight: 10,
      backgroundColor: AppColors.gray90,
      valueColor: const AlwaysStoppedAnimation(AppColors.primary),
    ),
  );
}

class _AmountsRow extends StatelessWidget {
  const _AmountsRow({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final raised = _formatRubles(project.raisedAmount);
    final contribs = project.contributorCount;
    final contribLabel = contribs == 1 ? '1 contributor' : '$contribs contributors';
    final goal = project.goalAmount;
    // With a goal: "₽X raised" / "of ₽Y · N contributors".
    // Without a goal (link-only fundraiser): "₽X raised" / "N contributors" —
    // we still render the row so no-progress projects don't look broken.
    final rightText = goal != null && goal > 0
        ? 'of ₽ ${_formatRubles(goal)} · $contribLabel'
        : contribLabel;
    return Row(
      children: [
        Expanded(
          child: Text(
            '₽ $raised raised',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          rightText,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.gray50,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _BottomRow extends StatelessWidget {
  const _BottomRow({
    required this.project,
    required this.profilesByAlumniId,
    required this.onDonate,
  });

  final ProjectModel project;
  final Map<String, Profile> profilesByAlumniId;
  final VoidCallback? onDonate;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: _AvatarStack(
          contributorIds: project.contributorsIds,
          profilesByAlumniId: profilesByAlumniId,
        ),
      ),
      if (onDonate != null)
        _DonateButton(onTap: onDonate!),
    ],
  );
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({
    required this.contributorIds,
    required this.profilesByAlumniId,
  });

  final List<String> contributorIds;
  final Map<String, Profile> profilesByAlumniId;

  static const _visible = 3;
  static const _size = 28.0;
  static const _overlap = 18.0;

  @override
  Widget build(BuildContext context) {
    if (contributorIds.isEmpty) {
      return Text(
        'Be the first to support',
        style: AppTextStyles.caption.copyWith(
          color: AppColors.gray50,
          fontSize: 11,
        ),
      );
    }
    final shown = contributorIds.take(_visible).toList();
    final remainder = contributorIds.length - shown.length;
    return SizedBox(
      height: _size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: i * _overlap,
              child: _AvatarDot(
                alumniId: shown[i],
                profile: profilesByAlumniId[shown[i]],
                size: _size,
              ),
            ),
          if (remainder > 0)
            Positioned(
              left: shown.length * _overlap,
              child: Container(
                width: _size,
                height: _size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.gray90,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  '+$remainder',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.gray30,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AvatarDot extends StatelessWidget {
  const _AvatarDot({
    required this.alumniId,
    required this.profile,
    required this.size,
  });

  final String alumniId;
  final Profile? profile;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (profile != null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: ProfilePic(profile: profile!, size: size - 4),
      );
    }
    // Fallback: deterministic pastel dot with the first initial of the
    // alumni id. Keeps the layout consistent while the batch fetch
    // hydrates on next refresh.
    final color = _paletteFor(alumniId);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }

  static Color _paletteFor(String id) {
    const palette = [
      Color(0xFFF4A4A4),
      Color(0xFFA4D5F4),
      Color(0xFFF4D4A4),
      Color(0xFFC4B4F4),
      Color(0xFFA4F4C4),
      Color(0xFFF4C4A4),
      Color(0xFFA4F4D5),
      Color(0xFFF4E4A4),
    ];
    final h = id.codeUnits.fold<int>(0, (a, b) => (a + b) & 0xffff);
    return palette[h % palette.length];
  }
}

class _DonateButton extends StatelessWidget {
  const _DonateButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(999),
    child: InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text(
          'Donate',
          style: AppTextStyles.actionSB.copyWith(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    ),
  );
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.approval});

  final ProjectApproval approval;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (approval) {
      ProjectApproval.pending => ('PENDING', const Color(0xFFFFF3CE), const Color(0xFFB58400)),
      ProjectApproval.declined => ('DECLINED', const Color(0xFFFEE2E2), const Color(0xFFB91C1C)),
      ProjectApproval.approved => ('APPROVED', const Color(0xFFE7F5DE), AppColors.primary),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w800,
          fontSize: 10,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

/// 720000 → "720k", 1000000 → "1M", 1234 → "1.2k", 500 → "500".
String _formatRubles(int amount) {
  if (amount >= 1000000) {
    final m = amount / 1000000;
    return m == m.roundToDouble() ? '${m.toInt()}M' : '${m.toStringAsFixed(1)}M';
  }
  if (amount >= 1000) {
    final k = amount / 1000;
    return k == k.roundToDouble() ? '${k.toInt()}k' : '${k.toStringAsFixed(1)}k';
  }
  return '$amount';
}
