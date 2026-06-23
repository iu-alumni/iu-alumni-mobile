import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/models/badge.dart';
import '../../../blocs/badges/badges_cubit.dart';
import '../../../blocs/models/badges_state.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/constants/app_text_styles.dart' show AppTextStyles;

const _badgeWidth = 96.0;
const _ringSize = 96.0;

class BadgesSection extends StatefulWidget {
  const BadgesSection({super.key});

  @override
  State<BadgesSection> createState() => _BadgesSectionState();
}

class _BadgesSectionState extends State<BadgesSection> {
  @override
  void initState() {
    super.initState();
    // Re-fetch every time the section mounts so newly-earned badges show up
    // after the user takes an action elsewhere (e.g. joining an event).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<BadgesCubit>().loadMine();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          Expanded(
            child: Text('Badges', style: AppTextStyles.subtitle),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh, color: AppColors.gray50, size: 20),
            onPressed: () => context.read<BadgesCubit>().loadMine(),
          ),
        ],
      ),
      const SizedBox(height: 4),
      BlocBuilder<BadgesCubit, BadgesState>(
        buildWhen: (p, c) => p.badges != c.badges,
        builder: (context, state) => switch (state.badges) {
        LoadedStateData<BadgesData>(:final data) when data.isEmpty => Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'No badges yet — attend events to start unlocking them.',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ),
        LoadedStateData<BadgesData>(:final data) => _Row(data: data),
        LoadedStateError(:final error) => Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            error,
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: AppLoader()),
        ),
      },
      ),
    ],
  );
}

class _Row extends StatelessWidget {
  const _Row({required this.data});

  final BadgesData data;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final e in data.earned) ...[
          _EarnedTile(earned: e),
          const SizedBox(width: 10),
        ],
        for (final l in data.locked) ...[
          _LockedTile(locked: l),
          const SizedBox(width: 10),
        ],
      ],
    ),
  );
}

class _EarnedTile extends StatelessWidget {
  const _EarnedTile({required this.earned});

  final EarnedBadge earned;

  @override
  Widget build(BuildContext context) {
    final ringColors = _tierGradient(earned.badge.tier);
    return SizedBox(
      width: _badgeWidth,
      child: Column(
        children: [
          Container(
            width: _ringSize,
            height: _ringSize,
            padding: const EdgeInsets.all(4),
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
                size: 44,
              ),
            ),
          ),
          const SizedBox(height: 6),
          _TierPill(tier: earned.badge.tier),
          const SizedBox(height: 4),
          Text(
            earned.badge.name,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.darkGray,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (earned.metadataLabel case final label?)
            Text(
              label,
              style: AppTextStyles.caption.copyWith(color: AppColors.gray50),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}

class _LockedTile extends StatelessWidget {
  const _LockedTile({required this.locked});

  final LockedBadge locked;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: _badgeWidth,
    child: Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: _ringSize,
              height: _ringSize,
              padding: const EdgeInsets.all(4),
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
                  size: 38,
                ),
              ),
            ),
            // Bottom-right lock chip.
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gray30,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
            // Top-right info pill — hover (web/desktop) or long-press (mobile)
            // surfaces a tooltip explaining how to earn the badge.
            Positioned(
              right: -2,
              top: -2,
              child: Tooltip(
                richMessage: TextSpan(
                  children: [
                    TextSpan(
                      text: '${locked.badge.name}\n',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    TextSpan(
                      text: '${locked.badge.description}\n',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                    TextSpan(
                      text: locked.threshold <= 1
                          ? '\nNot yet started'
                          : '\nProgress: ${locked.progress} / ${locked.threshold} ${locked.metricLabel}',
                      style: const TextStyle(
                        color: Color(0xFFC7F0BB),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                preferBelow: false,
                waitDuration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.darkGray,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: MouseRegion(
                  cursor: SystemMouseCursors.help,
                  child: Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Text(
                      'i',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          locked.badge.name,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.gray50,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 72,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: locked.progressFraction,
              minHeight: 4,
              backgroundColor: AppColors.gray80,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          locked.threshold <= 1 && locked.progress == 0
              ? 'Not started'
              : '${locked.progress} / ${locked.threshold}',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.gray50,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}

class _TierPill extends StatelessWidget {
  const _TierPill({required this.tier});

  final BadgeTier tier;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: _tierPillBg(tier),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      _tierLabel(tier),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 10,
        letterSpacing: 0.8,
      ),
    ),
  );
}

// --- Tier styling helpers ---

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

// Map our string icon key to Material icons. SVG assets can swap in later.
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
