import '../../models/badge.dart';
import 'badges_repository.dart';

/// In-memory mock matching the 12 doable badges from the catalog.
/// Replace with a real impl once the backend API exists.
class BadgesRepositoryMock implements BadgesRepository {
  final Set<String> _seen = {};

  static const _pioneer = Badge(
    code: 'pioneer',
    name: 'Pioneer',
    description:
        'Among the first 100 alumni to pin their location on the map.',
    tier: BadgeTier.special,
    iconKey: 'flag',
  );
  static const _localLegend = Badge(
    code: 'local_legend',
    name: 'Local Legend',
    description: 'Most events attended in a single city in a given year.',
    tier: BadgeTier.gold,
    iconKey: 'crown',
  );
  static const _foundingHost = Badge(
    code: 'founding_host',
    name: 'Founding Host',
    description: 'Created the first alumni event in a city.',
    tier: BadgeTier.gold,
    iconKey: 'flag',
  );
  static const _networker = Badge(
    code: 'networker',
    name: 'Networker',
    description: 'Attended 5+ alumni events.',
    tier: BadgeTier.bronze,
    iconKey: 'people',
  );
  static const _hostWithTheMost = Badge(
    code: 'host_with_the_most',
    name: 'Host with the most',
    description: 'Organized 3+ events in different cities.',
    tier: BadgeTier.silver,
    iconKey: 'trophy',
  );
  static const _rainmaker = Badge(
    code: 'rainmaker',
    name: 'Rainmaker',
    description: 'An event you created had 20+ attendees.',
    tier: BadgeTier.silver,
    iconKey: 'spark',
  );
  static const _crossCity = Badge(
    code: 'cross_city_commuter',
    name: 'Cross-city commuter',
    description:
        'Attended an event in a city different from your home city.',
    tier: BadgeTier.bronze,
    iconKey: 'travel',
  );
  static const _innopolisOg = Badge(
    code: 'innopolis_og',
    name: 'Innopolis OG',
    description: 'Graduated from one of the first cohorts (2014–2019).',
    tier: BadgeTier.gold,
    iconKey: 'graduation',
  );
  static const _profilePro = Badge(
    code: 'profile_pro',
    name: 'Profile Pro',
    description:
        'Completed all profile fields: photo, location, biography, graduation year, Telegram.',
    tier: BadgeTier.bronze,
    iconKey: 'profile_check',
  );
  static const _badgeCollector = Badge(
    code: 'badge_collector',
    name: 'Badge Collector',
    description: 'Earned 10+ badges.',
    tier: BadgeTier.gold,
    iconKey: 'collection',
  );
  static const _openSource = Badge(
    code: 'open_source_contributor',
    name: 'Open Source Contributor',
    description: "Contributed to the platform's open-source codebase.",
    tier: BadgeTier.silver,
    iconKey: 'code',
  );
  static const _suggestionBox = Badge(
    code: 'suggestion_box',
    name: 'Suggestion Box',
    description: 'Submitted a badge or feature idea that got implemented.',
    tier: BadgeTier.special,
    iconKey: 'lightbulb',
  );

  @override
  Future<BadgesData> loadMyBadges() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final awarded = DateTime.now().subtract(const Duration(days: 14));
    return BadgesData(
      earned: [
        EarnedBadge(badge: _innopolisOg, awardedAt: awarded),
        EarnedBadge(
          badge: _networker,
          awardedAt: awarded.add(const Duration(days: 4)),
        ),
        EarnedBadge(
          badge: _hostWithTheMost,
          awardedAt: awarded.add(const Duration(days: 8)),
        ),
        EarnedBadge(
          badge: _localLegend,
          awardedAt: awarded.add(const Duration(days: 10)),
          metadata: const {'city': 'Innopolis', 'year': 2025},
        ),
      ],
      locked: const [
        LockedBadge(
          badge: _rainmaker,
          progress: 14,
          threshold: 20,
          metricLabel: 'attendees on biggest hosted event',
        ),
        LockedBadge(
          badge: _profilePro,
          progress: 4,
          threshold: 5,
          metricLabel: 'profile fields completed',
        ),
        LockedBadge(
          badge: _crossCity,
          progress: 0,
          threshold: 1,
          metricLabel: 'events attended outside home city',
        ),
        LockedBadge(
          badge: _badgeCollector,
          progress: 4,
          threshold: 10,
          metricLabel: 'badges earned',
        ),
        LockedBadge(
          badge: _pioneer,
          progress: 0,
          threshold: 1,
          metricLabel: 'location pinned on the map',
        ),
        LockedBadge(
          badge: _foundingHost,
          progress: 0,
          threshold: 1,
          metricLabel: 'event created as first in a city',
        ),
        LockedBadge(
          badge: _openSource,
          progress: 0,
          threshold: 1,
          metricLabel: 'awarded by an admin',
        ),
        LockedBadge(
          badge: _suggestionBox,
          progress: 0,
          threshold: 1,
          metricLabel: 'awarded by an admin',
        ),
      ],
      newlyEarned: _seen.contains(_localLegend.code)
          ? const []
          : const [_localLegend],
    );
  }

  @override
  Future<BadgesData> loadFor(String alumniId) async {
    final all = await loadMyBadges();
    return BadgesData(
      earned: all.earned,
      locked: const [],
      newlyEarned: const [],
    );
  }

  @override
  Future<void> markSeen(List<String> badgeCodes) async {
    _seen.addAll(badgeCodes);
  }
}
