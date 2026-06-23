// Plain Dart models (no freezed) for the badges feature.
// Mirrors the API contract from BADGES_TICKETS.md #8.
// TODO: convert to freezed when the real API is wired.

import 'package:flutter/foundation.dart';

enum BadgeTier { gold, silver, bronze, special }

@immutable
class Badge {
  const Badge({
    required this.code,
    required this.name,
    required this.description,
    required this.tier,
    required this.iconKey,
  });

  final String code;
  final String name;
  final String description;
  final BadgeTier tier;
  final String iconKey;
}

@immutable
class EarnedBadge {
  const EarnedBadge({
    required this.badge,
    required this.awardedAt,
    this.metadata = const {},
  });

  final Badge badge;
  final DateTime awardedAt;
  final Map<String, dynamic> metadata;

  // For Local Legend: returns "Dubai · 2025" when metadata holds them.
  String? get metadataLabel {
    final city = metadata['city'];
    final year = metadata['year'];
    if (city is String && year is int) {
      return '$city · $year';
    }
    if (city is String) {
      return city;
    }
    return null;
  }
}

@immutable
class LockedBadge {
  const LockedBadge({
    required this.badge,
    required this.progress,
    required this.threshold,
    required this.metricLabel,
  });

  final Badge badge;
  final int progress;
  final int threshold;
  final String metricLabel;

  double get progressFraction =>
      threshold == 0 ? 0.0 : (progress / threshold).clamp(0.0, 1.0);
}

@immutable
class BadgesData {
  const BadgesData({
    required this.earned,
    required this.locked,
    required this.newlyEarned,
  });

  final List<EarnedBadge> earned;
  final List<LockedBadge> locked;
  final List<Badge> newlyEarned;

  bool get isEmpty => earned.isEmpty && locked.isEmpty;

  int get totalCount => earned.length + locked.length;
}
