import 'package:flutter/foundation.dart';
import 'package:ui_alumni_mobile/application/models/city_location.dart';
import 'package:ui_alumni_mobile/application/models/coordinates.dart';
import 'package:ui_alumni_mobile/data/db/db_manager.dart';
import 'package:ui_alumni_mobile/application/repositories/locations/locations_repository.dart';
import 'package:ui_alumni_mobile/data/locations/locations_gateway.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  LocationsRepositoryImpl(this._dbManager, this._gateway);

  final DbManager _dbManager;
  final LocationsGateway _gateway;

  @override
  Future<List<CityLocation>> cities(String city) {
    if (kIsWeb || kIsWasm) {
      return _gateway.search(city);
    }
    return _dbManager.cities(city);
  }

  @override
  Future<Coordinates?> coordinates(String country, String city) {
    if (kIsWeb || kIsWasm) {
      return _gateway.coordinates(city: city, country: country);
    }
    return _dbManager.coordinates(country, city);
  }

  @override
  void dispose() {
    return _dbManager.dispose();
  }

  @override
  Future<void> init() {
    return _dbManager.init();
  }
}
