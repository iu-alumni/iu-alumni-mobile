import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../application/models/paginated_result.dart';
import '../../application/models/profile.dart';
import '../common/dio_options_manager.dart';
import '../paths.dart';
import 'users_gateway.dart';

class UsersGatewayImpl extends UsersGateway {
  UsersGatewayImpl(this._dio, this._optionsManager);

  final Dio _dio;
  final DioOptionsManager _optionsManager;

  @override
  Future<PaginatedResult<Profile>> getAllUsers({
    String? cursor,
    int limit = 50,
  }) async {
    try {
      final response = await _dio.get(
        Paths.allProfiles,
        options: _optionsManager.opts(),
        queryParameters: {
          if (cursor != null) 'cursor': cursor,
          'limit': limit,
        },
      );
      return PaginatedResult.fromJson(
        response.data as Map<String, dynamic>,
        (e) => Profile.fromJson(e as Map<String, dynamic>),
      );
    } catch (_) {
      return PaginatedResult(items: const []);
    }
  }

  @override
  Future<PaginatedResult<Profile>> getUsersAtLocation(
    String location, {
    String? cursor,
    int limit = 50,
  }) async {
    try {
      final response = await _dio.get(
        Paths.allProfiles,
        options: _optionsManager.opts(),
        queryParameters: {
          'location': location,
          if (cursor != null) 'cursor': cursor,
          'limit': limit,
        },
      );
      return PaginatedResult.fromJson(
          response.data as Map<String, dynamic>, (e) => Profile.fromJson(e as Map<String, dynamic>));
    } catch (_) {
      return PaginatedResult(items: const []);
    }
  }

  @override
  Future<List<Profile>> getUsersByIds(List<String> ids) async {
    try {
      final response = await _dio.get(
        Paths.profile,
        options: _optionsManager.opts(),
        queryParameters: {'user_ids': ids},
      );
      final list = response.data as List;
      return [for (final p in list) Profile.fromJson(p)];
    } catch (_) {
      return <Profile>[];
    }
  }
}
