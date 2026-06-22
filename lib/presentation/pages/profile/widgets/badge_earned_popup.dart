import 'package:flutter/material.dart' hide Badge;

import '../../../../application/models/badge.dart';
import '../../../blocs/badges/badges_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';

/// Celebratory modal shown after [BadgesCubit] reports newly-earned badges.
///
/// Matches `mockups/10-badge-earned-popup.png`. Stacks across multiple badges:
/// each dismiss calls [BadgesCubit.markSeen] for that code and (if more remain)
/// pushes the next badge as a new dialog.
class BadgeEarnedPopup {
  /// Shows the popup chain. Returns `true` if the user tapped
  /// "View on my profile" on the LAST popup — the caller should then switch
  /// to the Profile tab. Otherwise returns `false`.
  static Future<bool> show(
    BuildContext context,
    BadgesCubit cubit,
    List<Badge> badges,
  ) async {
    var wantsProfile = false;
    for (final badge in badges) {
      if (!context.mounted) {
        return wantsProfile;
      }
      final result = await showDialog<bool>(
        context: context,
        barrierColor: Colors.black54,
        builder: (_) => _Card(badge: badge),
      );
      wantsProfile = result ?? false;
      await cubit.markSeen([badge.code]);
    }
    return wantsProfile;
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.badge});

  final Badge badge;

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 380),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 24,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'BADGE UNLOCKED',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Congratulations!',
                  style: AppTextStyles.subtitle.copyWith(
                    fontSize: 26,
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 22),
                _Hero(badge: badge),
                const SizedBox(height: 14),
                _TierPill(tier: badge.tier),
                const SizedBox(height: 14),
                Text(
                  badge.name,
                  style: AppTextStyles.subtitle.copyWith(
                    fontSize: 22,
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    badge.description,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.gray30,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'View on my profile',
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Maybe later',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.gray50,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Confetti scattered on top of the card.
          ..._confetti(),
          // Close X
          Positioned(
            top: 14,
            right: 14,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF4F5F7),
                ),
                child: const Icon(Icons.close, size: 18, color: AppColors.gray50),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  List<Widget> _confetti() => const [
    _Confetti(top: 22, left: 36, color: Color(0xFFF59E0B), rotate: 0.35),
    _Confetti(top: 42, left: 96, color: Color(0xFF40BA21), circle: true),
    _Confetti(top: 18, left: 168, color: Color(0xFF3B82F6), rotate: 0.78),
    _Confetti(top: 56, left: 240, color: Color(0xFFEC4899), rotate: -0.26, size: 10),
    _Confetti(top: 24, left: 312, color: Color(0xFFF59E0B), circle: true),
    _Confetti(top: 80, left: 24, color: Color(0xFFA855F7), rotate: 0.61),
    _Confetti(top: 100, left: 336, color: Color(0xFF22C55E)),
    _Confetti(top: 144, left: 14, color: Color(0xFFEC4899), circle: true),
    _Confetti(top: 160, left: 348, color: Color(0xFFF59E0B), rotate: 0.35),
  ];
}

class _Hero extends StatelessWidget {
  const _Hero({required this.badge});

  final Badge badge;

  @override
  Widget build(BuildContext context) {
    final ringColors = _tierGradient(badge.tier);
    final iconBg = _tierIconBg(badge.tier);
    final iconColor = _tierIconColor(badge.tier);
    return Stack(
      alignment: Alignment.center,
      children: [
        // Soft glow.
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                ringColors.first.withValues(alpha: 0.35),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Container(
          width: 180,
          height: 180,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: ringColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: iconBg),
            child: Icon(_iconFor(badge.iconKey), color: iconColor, size: 96),
          ),
        ),
      ],
    );
  }
}

class _TierPill extends StatelessWidget {
  const _TierPill({required this.tier});

  final BadgeTier tier;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    decoration: BoxDecoration(
      color: _tierPillBg(tier),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      _tierLabel(tier),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 12,
        letterSpacing: 1,
      ),
    ),
  );
}

class _Confetti extends StatelessWidget {
  const _Confetti({
    required this.top,
    required this.left,
    required this.color,
    this.rotate = 0,
    this.circle = false,
    this.size = 8,
  });

  final double top;
  final double left;
  final Color color;
  final double rotate;
  final bool circle;
  final double size;

  @override
  Widget build(BuildContext context) => Positioned(
    top: top,
    left: left,
    child: Transform.rotate(
      angle: rotate,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(circle ? size : 2),
        ),
      ),
    ),
  );
}

// --- Tier helpers (duplicated from badges_section.dart to avoid exposing them
// as public; keep both in sync for now). ---

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
