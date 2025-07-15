import 'package:ui_alumni_mobile/application/models/city_location.dart';
import 'package:ui_alumni_mobile/application/models/coordinates.dart';

abstract interface class LocationsGateway {
  Future<List<CityLocation>> search(String city);
  Future<Coordinates?> coordinates({
    required String country,
    required String city,
  });
}
