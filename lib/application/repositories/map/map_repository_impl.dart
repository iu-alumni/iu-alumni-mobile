import '../../../data/db/db_manager.dart';
import '../../../data/users/users_gateway.dart';
import '../../../util/logger.dart';
import '../../models/city_location.dart';
import '../../models/coordinates.dart';
import '../../models/profile.dart';
import 'map_repository.dart';

class MapRepositoryImpl extends MapRepository {
  MapRepositoryImpl(this._dbManager, this._usersGateway);

  final DbManager _dbManager;
  final UsersGateway _usersGateway;

  CityLocation? _cityLocationFromStr(String location) {
    final data = location.split(', ');
    if (data.length != 2) {
      return null;
    }
    return CityLocation(data[0], data[1]);
  }

  Map<CityLocation, List<Profile>> _locationsMap(List<Profile> profiles) {
    final _map = <CityLocation, List<Profile>>{};
    for (final p in profiles) {
      final location = p.location;
      if (location == null) {
        continue;
      }
      final cityLocation = _cityLocationFromStr(location);
      if (cityLocation == null) {
        logger.d('$location could not be transformed to the city location');
        continue;
      }
      if (_map.containsKey(cityLocation)) {
        _map[cityLocation]?.add(p);
      } else {
        _map[cityLocation] = [p];
      }
    }
    return _map;
  }

  Future<MapInfo> _buildMapInfo(
    Map<CityLocation, List<Profile>> locationsMap,
  ) async {
    final _map = <Coordinates, List<Profile>>{};
    for (final entry in locationsMap.entries) {
      final coords = await _dbManager.coordinates(
        entry.key.country,
        entry.key.city,
      );
      if (coords == null) {
        logger.d(
          '${entry.key.country}, ${entry.key.city} could not be mapped to proper coordinates',
        );
        continue;
      }
      _map[coords] = entry.value;
    }
    return _map;
  }

  @override
  Future<MapInfo> getUsersOnMap() async {
    final users = await _usersGateway.getAllUsers();
    if (users.isEmpty) {
      return {};
    }
    return _buildMapInfo(_locationsMap(users));
  }

  @override
  Future<List<CityLocation>> suggestions(String city) =>
      _dbManager.cities(city);
}
