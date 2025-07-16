import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ui_alumni_mobile/application/models/city_location.dart';
import 'package:ui_alumni_mobile/application/models/coordinates.dart';
import 'package:ui_alumni_mobile/data/common/dio_options_manager.dart';
import 'package:ui_alumni_mobile/data/locations/locations_gateway.dart';
import 'package:ui_alumni_mobile/data/paths.dart';

class LocationsGatewayImpl implements LocationsGateway {
  LocationsGatewayImpl(this._dio, this._optionsManager);

  final Dio _dio;
  final DioOptionsManager _optionsManager;

  @override
  Future<Coordinates?> coordinates({
    required String country,
    required String city,
  }) => TaskEither.tryCatch(() async {
    final results = await _dio.get(
      Paths.coordinates,
      options: _optionsManager.opts(),
      queryParameters: {'city': city, 'country': country},
    );
    return Coordinates.fromJson(results.data as Map<String, dynamic>);
  }, (e, st) => null).match(identity, identity).run();

  @override
  Future<List<CityLocation>> search(String city) =>
      TaskEither.tryCatch(() async {
        final results = await _dio.get(
          Paths.search,
          options: _optionsManager.opts(),
          queryParameters: {'q': city},
        );
        final data = results.data as Map<String, dynamic>;
        final list = data['cities'] as List<dynamic>;
        final citiesList = list.map((a) => a as Map<String, dynamic>);
        return citiesList.map(CityLocation.fromJson).toList();
      }, (e, st) => <CityLocation>[]).match(identity, identity).run();
}
