import 'package:ui_alumni_mobile/application/models/city_location.dart';
import 'package:ui_alumni_mobile/application/models/coordinates.dart';
import 'package:ui_alumni_mobile/application/repositories/locations/locations_repository.dart';
import 'package:ui_alumni_mobile/data/locations/locations_gateway.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  LocationsRepositoryImpl(this._gateway);

  final LocationsGateway _gateway;

  @override
  Future<List<CityLocation>> cities(String city) => _gateway.search(city);

  @override
  Future<Coordinates?> coordinates(String country, String city) =>
      _gateway.coordinates(city: city, country: country);

  @override
  void dispose() {}

  @override
  Future<void> init() async {}
}
