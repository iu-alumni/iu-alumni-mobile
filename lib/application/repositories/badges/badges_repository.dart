import '../../models/badge.dart';

/// Source of badges for a profile screen.
///
/// Currently has only a mocked implementation (BadgesRepositoryMock) since
/// the backend API (BADGES_TICKETS.md #8) hasn't shipped yet. Swap for a
/// real implementation that hits `/api/v1/profile/me/badges` once it does.
abstract class BadgesRepository {
  /// Earned + locked + newly-earned for the current user.
  Future<BadgesData> loadMyBadges();

  /// Earned-only for someone else (`/api/v1/users/{id}/badges`).
  Future<BadgesData> loadFor(String alumniId);

  /// Marks newly-earned badges as seen so the popup doesn't reappear.
  /// No-op in the mock; calls `POST /profile/me/badges/{badge_id}/seen` for real.
  Future<void> markSeen(List<String> badgeCodes);
}
