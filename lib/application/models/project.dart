import 'package:flutter/foundation.dart';

/// Tri-state approval — mirrors backend `approved` column.
enum ProjectApproval { pending, approved, declined }

@immutable
class ProjectModel {
  const ProjectModel({
    required this.id,
    required this.ownerId,
    required this.contributorsIds,
    required this.title,
    required this.description,
    required this.approval,
    required this.createdAt,
    this.cover,
  });

  final String id;
  final String ownerId;
  final List<String> contributorsIds;
  final String title;
  final String description;
  final String? cover;
  final ProjectApproval approval;
  final DateTime createdAt;

  int get contributorCount => contributorsIds.length;

  bool isContributedBy(String alumniId) => contributorsIds.contains(alumniId);

  ProjectModel copyWith({
    String? id,
    String? ownerId,
    List<String>? contributorsIds,
    String? title,
    String? description,
    String? cover,
    ProjectApproval? approval,
    DateTime? createdAt,
  }) => ProjectModel(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    contributorsIds: contributorsIds ?? this.contributorsIds,
    title: title ?? this.title,
    description: description ?? this.description,
    cover: cover ?? this.cover,
    approval: approval ?? this.approval,
    createdAt: createdAt ?? this.createdAt,
  );

  /// Parses the backend project payload. Tolerates missing / malformed
  /// values by falling back to sensible defaults — never throws.
  static ProjectModel? fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final ownerId = json['owner_id'];
    if (id is! String || ownerId is! String) {
      return null;
    }
    final rawApproved = json['approved'];
    final approval = switch (rawApproved) {
      true => ProjectApproval.approved,
      false => ProjectApproval.declined,
      _ => ProjectApproval.pending,
    };
    final rawContributors = json['contributors_ids'];
    return ProjectModel(
      id: id,
      ownerId: ownerId,
      contributorsIds: switch (rawContributors) {
        final List l => l.whereType<String>().toList(growable: false),
        _ => const [],
      },
      title: (json['title'] as String?) ?? 'Untitled',
      description: (json['description'] as String?) ?? '',
      cover: json['cover'] as String?,
      approval: approval,
      createdAt:
          DateTime.tryParse((json['created_at'] as String?) ?? '') ??
          DateTime.now(),
    );
  }
}
