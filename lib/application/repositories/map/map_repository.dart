import '../../models/city_location.dart';
import '../../models/coordinates.dart';
import '../../models/profile.dart';

abstract class MapRepository {
  Future<MapInfo> getUsersOnMap();

  Future<List<CityLocation>> suggestions(String city);
}

typedef MapInfo = Map<Coordinates, List<Profile>>;


