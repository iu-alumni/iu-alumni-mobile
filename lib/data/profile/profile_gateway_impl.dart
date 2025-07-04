import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../application/models/profile.dart';
import '../common/dio_options_manager.dart';
import '../paths.dart';
import '../secrets/secrets_manager.dart';
import 'profile_gateway.dart';

class ProfileGatewayImpl extends ProfileGateway {
  ProfileGatewayImpl(this._dio, this._optionsManager, this._secretsManager);

  final Dio _dio;
  final DioOptionsManager _optionsManager;
  final SecretsManager _secretsManager;

  @override
  Future<Either<String, Profile>> loadProfile() =>
      TaskEither.tryCatch(() async {
        final resp = await _dio.get(
          Paths.myProfile(_secretsManager.hostPath),
          options: _optionsManager.opts(),
        );
        final data = resp.data as Map<String, dynamic>;
        return Profile.fromJson(data);
      }, (e, _) => '$e').run();

  @override
  Future<bool> update(Profile profile) => TaskEither.tryCatch(() async {
        await _dio.put(
          Paths.myProfile(_secretsManager.hostPath),
          options: _optionsManager.opts(),
          data: jsonEncode(profile.toJson()),
        );
        return true;
      }, (e, _) => '$e').match((_) => false, identity).run();
}
