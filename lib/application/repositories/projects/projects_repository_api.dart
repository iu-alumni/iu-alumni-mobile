import 'package:dio/dio.dart';

import '../../../data/common/dio_options_manager.dart';
import '../../../util/logger.dart';
import '../../models/project.dart';
import 'projects_repository.dart';

/// Talks to `/api/v1/projects/*`. Every method is failure-tolerant so a
/// backend hiccup can't crash the UI — errors are logged and swallowed.
class ProjectsRepositoryApi implements ProjectsRepository {
  ProjectsRepositoryApi(this._dio, this._options);

  final Dio _dio;
  final DioOptionsManager _options;

  static const _base = '/api/v1/projects';

  @override
  Future<List<ProjectModel>> listApproved() =>
      _pagedList('$_base/', queryParameters: const {});

  @override
  Future<ProjectModel?> getOne(String id) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '$_base/$id',
        options: _options.opts(),
      );
      final data = res.data;
      return data == null ? null : ProjectModel.fromJson(data);
    } catch (e) {
      logger.d('getOne($id) failed: $e');
      return null;
    }
  }

  @override
  Future<List<ProjectModel>> listMyOwned() =>
      _flatList('$_base/owner');

  @override
  Future<List<ProjectModel>> listMyContributed() =>
      _flatList('$_base/contributed');

  @override
  Future<List<ProjectModel>> listContributedBy(String alumniId) =>
      _flatList('$_base/contributed/$alumniId');

  @override
  Future<String?> create({
    required String title,
    required String description,
    String? cover,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '$_base/',
        data: {
          'title': title,
          'description': description,
          if (cover != null) 'cover': cover,
        },
        options: _options.opts(),
      );
      final id = res.data?['id'];
      return id is String ? id : null;
    } catch (e) {
      logger.d('create failed: $e');
      return null;
    }
  }

  @override
  Future<ProjectModel?> update(
    String id, {
    String? title,
    String? description,
    String? cover,
  }) async {
    try {
      final res = await _dio.put<Map<String, dynamic>>(
        '$_base/$id',
        data: {
          if (title != null) 'title': title,
          if (description != null) 'description': description,
          if (cover != null) 'cover': cover,
        },
        options: _options.opts(),
      );
      final data = res.data;
      return data == null ? null : ProjectModel.fromJson(data);
    } catch (e) {
      logger.d('update($id) failed: $e');
      return null;
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      await _dio.delete<void>('$_base/$id', options: _options.opts());
      return true;
    } catch (e) {
      logger.d('delete($id) failed: $e');
      return false;
    }
  }

  @override
  Future<bool> contribute(String id) async {
    try {
      await _dio.post<void>(
        '$_base/$id/contributors',
        options: _options.opts(),
      );
      return true;
    } catch (e) {
      logger.d('contribute($id) failed: $e');
      return false;
    }
  }

  @override
  Future<bool> retract(String id) async {
    try {
      await _dio.post<void>(
        '$_base/$id/contributors/remove',
        options: _options.opts(),
      );
      return true;
    } catch (e) {
      logger.d('retract($id) failed: $e');
      return false;
    }
  }

  // Paginated cursor-based endpoint (list-approved). Follows all pages so
  // the caller sees the full result set in one call.
  Future<List<ProjectModel>> _pagedList(
    String path, {
    Map<String, dynamic> queryParameters = const {},
  }) async {
    final all = <ProjectModel>[];
    String? cursor;
    try {
      do {
        final res = await _dio.get<Map<String, dynamic>>(
          path,
          queryParameters: {
            ...queryParameters,
            'limit': 100,
            if (cursor != null) 'cursor': cursor,
          },
          options: _options.opts(),
        );
        final body = res.data;
        if (body == null) {
          break;
        }
        final items = (body['items'] as List?) ?? const [];
        for (final raw in items) {
          if (raw is Map<String, dynamic>) {
            final p = ProjectModel.fromJson(raw);
            if (p != null) {
              all.add(p);
            }
          }
        }
        cursor = body['next_cursor'] as String?;
      } while (cursor != null);
    } catch (e) {
      logger.d('_pagedList($path) failed: $e');
    }
    return all;
  }

  // Flat-list endpoints (owner + contributed listers) return a bare
  // JSON array, not a paginated envelope.
  Future<List<ProjectModel>> _flatList(String path) async {
    try {
      final res = await _dio.get<List<dynamic>>(
        path,
        options: _options.opts(),
      );
      final items = res.data ?? const [];
      return items
          .whereType<Map<String, dynamic>>()
          .map(ProjectModel.fromJson)
          .whereType<ProjectModel>()
          .toList();
    } catch (e) {
      logger.d('_flatList($path) failed: $e');
      return const [];
    }
  }
}
