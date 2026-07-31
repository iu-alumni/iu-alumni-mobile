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
    required this.raisedAmount,
    this.cover,
    this.donationLink,
    this.goalAmount,
  });

  final String id;
  final String ownerId;
  final List<String> contributorsIds;
  final String title;
  final String description;
  final String? cover;

  /// Owner-supplied payment URL (bank / Tinkoff / YooKassa). The client
  /// just opens it via url_launcher — no in-app payment handling.
  final String? donationLink;

  /// Fundraising target in whole rubles. `null` if the owner didn't set
  /// one — in which case the card hides the progress bar and just shows
  /// the raised total.
  final int? goalAmount;

  /// Total self-reported donations, in whole rubles. Bumped by the
  /// donate endpoint each time a contributor tells us what they gave.
  final int raisedAmount;
  final ProjectApproval approval;
  final DateTime createdAt;

  int get contributorCount => contributorsIds.length;

  bool isContributedBy(String alumniId) => contributorsIds.contains(alumniId);

  /// 0.0–1.0 fraction of the goal reached. Zero when no goal is set —
  /// callers should check `goalAmount` themselves before rendering the
  /// bar so the "no goal" state can be handled distinctly from "0%".
  double get progressFraction {
    final goal = goalAmount;
    if (goal == null || goal <= 0) {
      return 0;
    }
    return (raisedAmount / goal).clamp(0.0, 1.0);
  }

  ProjectModel copyWith({
    String? id,
    String? ownerId,
    List<String>? contributorsIds,
    String? title,
    String? description,
    String? cover,
    String? donationLink,
    int? goalAmount,
    int? raisedAmount,
    ProjectApproval? approval,
    DateTime? createdAt,
  }) => ProjectModel(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    contributorsIds: contributorsIds ?? this.contributorsIds,
    title: title ?? this.title,
    description: description ?? this.description,
    cover: cover ?? this.cover,
    donationLink: donationLink ?? this.donationLink,
    goalAmount: goalAmount ?? this.goalAmount,
    raisedAmount: raisedAmount ?? this.raisedAmount,
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
      donationLink: json['donation_link'] as String?,
      goalAmount: switch (json['goal_amount']) {
        final int i when i > 0 => i,
        final num n when n > 0 => n.toInt(),
        _ => null,
      },
      raisedAmount: switch (json['raised_amount']) {
        final int i => i,
        final num n => n.toInt(),
        _ => 0,
      },
      approval: approval,
      createdAt:
          DateTime.tryParse((json['created_at'] as String?) ?? '') ??
          DateTime.now(),
    );
  }
}
