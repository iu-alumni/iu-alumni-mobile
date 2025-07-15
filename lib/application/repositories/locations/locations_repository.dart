import 'package:ui_alumni_mobile/application/models/city_location.dart';
import 'package:ui_alumni_mobile/application/models/coordinates.dart';

abstract interface class LocationsRepository {
  const LocationsRepository();

  Future<void> init();
  void dispose();

  Future<Coordinates?> coordinates(String country, String city);
  Future<List<CityLocation>> cities(String city);
}
