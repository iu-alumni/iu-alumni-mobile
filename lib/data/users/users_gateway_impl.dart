import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../application/models/profile.dart';
import '../common/dio_options_manager.dart';
import '../paths.dart';
import 'users_gateway.dart';

class UsersGatewayImpl extends UsersGateway {
  UsersGatewayImpl(this._dio, this._optionsManager);

  final Dio _dio;
  final DioOptionsManager _optionsManager;

  @override
  Future<List<Profile>> getAllUsers() => TaskEither.tryCatch(
        () async {
          final response = await _dio.get(
            Paths.allProfiles,
            options: _optionsManager.opts(),
          );
          final list = response.data as List;
          return [for (final p in list) Profile.fromJson(p)];
        },
        (e, st) => <Profile>[],
      ).match(identity, identity).run();

  @override
  Future<List<Profile>> getUsersByIds(List<String> ids) =>
      TaskEither.tryCatch(
        () async {
          final response = await _dio.get(
            Paths.profile,
            options: _optionsManager.opts(),
            queryParameters: {'user_ids': ids},
          );
          final list = response.data as List;
          return [for (final p in list) Profile.fromJson(p)];
        },
        (e, st) => <Profile>[],
      ).match(identity, identity).run();
}
