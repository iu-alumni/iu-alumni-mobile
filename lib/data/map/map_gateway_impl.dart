import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../application/models/map_location_group.dart';
import '../common/dio_options_manager.dart';
import '../paths.dart';
import 'map_gateway.dart';

class MapGatewayImpl implements MapGateway {
  MapGatewayImpl(this._dio, this._optionsManager);

  final Dio _dio;
  final DioOptionsManager _optionsManager;

  @override
  Future<List<MapLocationGroup>> getMapLocations() =>
      TaskEither.tryCatch(() async {
        final response = await _dio.get(
          Paths.mapProfiles,
          options: _optionsManager.opts(),
        );
        final data = response.data as Map<String, dynamic>;
        final list = data['locations'] as List<dynamic>;
        return list
            .cast<Map<String, dynamic>>()
            .map(MapLocationGroup.fromJson)
            .toList();
      }, (e, _) => <MapLocationGroup>[])
          .match(identity, identity)
          .run();
}
