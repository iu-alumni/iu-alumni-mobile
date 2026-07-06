import 'package:flutter/material.dart' hide Badge;
import 'package:intl/intl.dart';

import '../../../../application/models/badge.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';

/// Bottom-sheet detail view for a badge.
///
/// Two shapes:
/// - Earned: shows "Earned <date>" + description + tier pill (+ optional
///   city/year label for Local Legend).
/// - Locked: shows "Locked" label, description, progress bar with X / Y,
///   and the requirement text.
///
/// Closes on backdrop tap or down-swipe (default modal-sheet behavior).
class BadgeDetailsSheet {
  static Future<void> showEarned(
    BuildContext context,
    EarnedBadge earned,
  ) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (_) => _Sheet(child: _EarnedBody(earned: earned)),
  );

  static Future<void> showLocked(
    BuildContext context,
    LockedBadge locked,
  ) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (_) => _Sheet(child: _LockedBody(locked: locked)),
  );
}

class _Sheet extends StatelessWidget {
  const _Sheet({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    padding: EdgeInsets.only(
      left: 24,
      right: 24,
      top: 12,
      bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: AppColors.gray80,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        child,
      ],
    ),
  );
}

class _EarnedBody extends StatelessWidget {
  const _EarnedBody({required this.earned});

  final EarnedBadge earned;

  @override
  Widget build(BuildContext context) {
    final ringColors = _tierGradient(earned.badge.tier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          height: 120,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: ringColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _tierIconBg(earned.badge.tier),
            ),
            child: Icon(
              _iconFor(earned.badge.iconKey),
              color: _tierIconColor(earned.badge.tier),
              size: 60,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _TierPill(tier: earned.badge.tier),
        const SizedBox(height: 12),
        Text(
          earned.badge.name,
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 20,
            color: AppColors.darkGray,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'Earned ${DateFormat('MMM d, yyyy').format(earned.awardedAt.toLocal())}',
          style: AppTextStyles.caption.copyWith(color: AppColors.gray50),
        ),
        if (earned.metadataLabel case final label?) ...[
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.darkGray,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const SizedBox(height: 16),
        Text(
          earned.badge.description,
          style: AppTextStyles.body.copyWith(
            color: AppColors.gray30,
            fontSize: 14,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _LockedBody extends StatelessWidget {
  const _LockedBody({required this.locked});

  final LockedBadge locked;

  @override
  Widget build(BuildContext context) {
    final showProgress = locked.threshold > 1;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gray80, width: 2),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gray90,
                ),
                child: Icon(
                  _iconFor(locked.badge.iconKey),
                  color: AppColors.gray80,
                  size: 52,
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gray30,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.gray80,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline, size: 12, color: AppColors.gray30),
              const SizedBox(width: 4),
              Text(
                'LOCKED · ${_tierLabel(locked.badge.tier)}',
                style: const TextStyle(
                  color: AppColors.gray30,
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          locked.badge.name,
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 20,
            color: AppColors.darkGray,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          locked.badge.description,
          style: AppTextStyles.body.copyWith(
            color: AppColors.gray30,
            fontSize: 14,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        if (showProgress) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.gray30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${locked.progress} / ${locked.threshold}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: locked.progressFraction,
              minHeight: 8,
              backgroundColor: AppColors.gray80,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          const SizedBox(height: 8),
        ],
        Text(
          _requirementText(locked),
          style: AppTextStyles.caption.copyWith(
            color: AppColors.gray50,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _requirementText(LockedBadge l) {
    if (l.threshold <= 1) {
      return 'Requirement: ${l.metricLabel}';
    }
    return 'Reach ${l.threshold} ${l.metricLabel} to unlock.';
  }
}

class _TierPill extends StatelessWidget {
  const _TierPill({required this.tier});

  final BadgeTier tier;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
    decoration: BoxDecoration(
      color: _tierPillBg(tier),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      _tierLabel(tier),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 11,
        letterSpacing: 1,
      ),
    ),
  );
}

// Tier styling — duplicated from badges_section.dart to keep the sheet
// self-contained; both files should stay in sync.

List<Color> _tierGradient(BadgeTier t) => switch (t) {
  BadgeTier.gold => const [Color(0xFFFFD24D), Color(0xFFB58400)],
  BadgeTier.silver => const [Color(0xFFE2E8F0), Color(0xFF94A3B8)],
  BadgeTier.bronze => const [Color(0xFFE0925A), Color(0xFF8C4A18)],
  BadgeTier.special => const [AppColors.primary, Color(0xFF2E8A14)],
};

Color _tierIconBg(BadgeTier t) => switch (t) {
  BadgeTier.gold => const Color(0xFFFFF8E7),
  BadgeTier.silver => const Color(0xFFF1F5F9),
  BadgeTier.bronze => const Color(0xFFFFF5E6),
  BadgeTier.special => const Color(0xFFEBFAE5),
};

Color _tierIconColor(BadgeTier t) => switch (t) {
  BadgeTier.gold => const Color(0xFFC99A2E),
  BadgeTier.silver => const Color(0xFF64748B),
  BadgeTier.bronze => const Color(0xFF8C4A18),
  BadgeTier.special => AppColors.primary,
};

Color _tierPillBg(BadgeTier t) => switch (t) {
  BadgeTier.gold => const Color(0xFFC99A2E),
  BadgeTier.silver => const Color(0xFF94A3B8),
  BadgeTier.bronze => const Color(0xFFB45309),
  BadgeTier.special => AppColors.primary,
};

String _tierLabel(BadgeTier t) => switch (t) {
  BadgeTier.gold => 'GOLD',
  BadgeTier.silver => 'SILVER',
  BadgeTier.bronze => 'BRONZE',
  BadgeTier.special => 'SPECIAL',
};

IconData _iconFor(String key) => switch (key) {
  'flag' => Icons.flag,
  'crown' => Icons.emoji_events,
  'people' => Icons.people,
  'trophy' => Icons.emoji_events,
  'spark' => Icons.bolt,
  'travel' => Icons.flight_takeoff,
  'graduation' => Icons.school,
  'profile_check' => Icons.verified_user,
  'collection' => Icons.collections,
  'code' => Icons.code,
  'lightbulb' => Icons.lightbulb,
  _ => Icons.star,
};
