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

  Future<List<Profile>> getAllUsers() => TaskOption.tryCatch(() async {
        final response = await _dio.get(
          Paths.allProfiles,
          options: _optionsManager.opts(),
        );
        final list = response.data as List;
        return [for (final p in list) Profile.fromJson(p)];
      }).match(() => <Profile>[], identity).run();
}
