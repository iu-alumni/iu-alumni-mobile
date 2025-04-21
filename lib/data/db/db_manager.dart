import '../../application/models/city_location.dart';
import '../../application/models/coordinates.dart';

abstract class DbManager {
  Future<void> init();
  void dispose();

  Future<Coordinates?> coordinates(String country, String city);
  Future<List<CityLocation>> cities(String city);
}
