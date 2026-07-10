import '../../models/project.dart';

/// All calls are best-effort and never throw. Failures surface as an
/// empty list / `null` so the UI can render a fallback without wrapping
/// every call in a try/catch.
abstract interface class ProjectsRepository {
  /// Approved projects, most-recent first.
  Future<List<ProjectModel>> listApproved();

  Future<ProjectModel?> getOne(String id);

  /// Every project owned by the current user, any status. Backend endpoint
  /// resolves the caller from the token.
  Future<List<ProjectModel>> listMyOwned();

  /// Approved projects the current user has contributed to.
  Future<List<ProjectModel>> listMyContributed();

  Future<List<ProjectModel>> listContributedBy(String alumniId);

  /// Returns the created project's id on success, `null` on failure.
  Future<String?> create({
    required String title,
    required String description,
    String? cover,
  });

  /// Returns the refreshed project on success, `null` on failure.
  Future<ProjectModel?> update(
    String id, {
    String? title,
    String? description,
    String? cover,
  });

  Future<bool> delete(String id);

  Future<bool> contribute(String id);

  Future<bool> retract(String id);
}
