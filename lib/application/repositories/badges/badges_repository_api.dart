import 'package:dio/dio.dart';

import '../../../data/common/dio_options_manager.dart';
import '../../models/badge.dart';
import 'badges_repository.dart';

/// Hits the real backend at `/api/v1/badges/*`.
/// Swap [BadgesRepositoryMock] for this in `app.dart` once the API is up.
class BadgesRepositoryApi implements BadgesRepository {
  BadgesRepositoryApi(this._dio, this._options);

  final Dio _dio;
  final DioOptionsManager _options;

  static const _base = '/api/v1/badges';

  @override
  Future<BadgesData> loadMyBadges() async {
    final res = await _dio.get<Map<String, dynamic>>(
      '$_base/me',
      options: _options.opts(),
    );
    return _parseFull(res.data!);
  }

  @override
  Future<BadgesData> loadFor(String alumniId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '$_base/users/$alumniId',
      options: _options.opts(),
    );
    return BadgesData(
      earned: _parseEarned(res.data!['earned'] as List),
      locked: const [],
      newlyEarned: const [],
    );
  }

  @override
  Future<void> markSeen(List<String> badgeCodes) async {
    final opts = _options.opts();
    await Future.wait(
      badgeCodes.map(
        (code) => _dio.post<void>('$_base/me/$code/seen', options: opts),
      ),
    );
  }

  // ─── parsers ───────────────────────────────────────────────────────────

  static BadgesData _parseFull(Map<String, dynamic> json) => BadgesData(
    earned: _parseEarned(json['earned'] as List? ?? []),
    locked: _parseLocked(json['locked'] as List? ?? []),
    newlyEarned: _parseBadgeList(json['newly_earned'] as List? ?? []),
  );

  static List<EarnedBadge> _parseEarned(List raw) => raw
      .cast<Map<String, dynamic>>()
      .map(
        (j) => EarnedBadge(
          badge: _parseBadge(j),
          awardedAt: DateTime.parse(j['awarded_at'] as String),
          metadata: Map<String, dynamic>.from(j['extra'] as Map? ?? {}),
        ),
      )
      .toList();

  static List<LockedBadge> _parseLocked(List raw) => raw
      .cast<Map<String, dynamic>>()
      .map(
        (j) => LockedBadge(
          badge: _parseBadge(j),
          progress: (j['progress'] as num).toInt(),
          threshold: (j['threshold'] as num).toInt(),
          metricLabel: j['metric_label'] as String,
        ),
      )
      .toList();

  static List<Badge> _parseBadgeList(List raw) =>
      raw.cast<Map<String, dynamic>>().map(_parseBadge).toList();

  static Badge _parseBadge(Map<String, dynamic> j) => Badge(
    code: j['code'] as String,
    name: j['name'] as String,
    description: j['description'] as String,
    tier: _parseTier(j['tier'] as String),
    iconKey: j['icon_key'] as String,
  );

  static BadgeTier _parseTier(String t) => switch (t) {
    'gold' => BadgeTier.gold,
    'silver' => BadgeTier.silver,
    'bronze' => BadgeTier.bronze,
    _ => BadgeTier.special,
  };
}

