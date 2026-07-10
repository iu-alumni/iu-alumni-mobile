import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../application/models/project.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({required this.project, this.onTap, super.key});

  final ProjectModel project;
  final VoidCallback? onTap;

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
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Thumb(cover: project.cover),
            const SizedBox(width: 12),
            Expanded(child: _Body(project: project)),
          ],
        ),
      ),
    ),
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

class _Body extends StatelessWidget {
  const _Body({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) => Column(
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
      const SizedBox(height: 8),
      Row(
        children: [
          const Icon(Icons.people_outline, size: 14, color: AppColors.gray50),
          const SizedBox(width: 4),
          Text(
            project.contributorCount == 1
                ? '1 contributor'
                : '${project.contributorCount} contributors',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.gray50,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ],
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
