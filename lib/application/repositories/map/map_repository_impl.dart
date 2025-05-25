import '../../../data/db/db_manager.dart';
import '../../../util/logger.dart';
import '../../models/city_location.dart';
import '../../models/coordinates.dart';
import '../events/events_repository.dart';
import '../users/users_repository.dart';
import 'map_repository.dart';

class MapRepositoryImpl extends MapRepository {
  MapRepositoryImpl(
    this._dbManager,
    this._usersRepository,
    this._eventsRepository,
  );

  final DbManager _dbManager;
  final UsersRepository _usersRepository;
  final EventsRepository _eventsRepository;

  CityLocation? _cityLocationFromStr(String location) {
    final data = location.split(', ');
    if (data.length != 2) {
      return null;
    }
    return CityLocation(data[0], data[1]);
  }

  Map<CityLocation, List<MapPin>> _locationMapFrom(
    Iterable<(String, MapPin)> entries,
  ) {
    final _map = <CityLocation, List<MapPin>>{};
    for (final (l, o) in entries) {
      final cityLocation = _cityLocationFromStr(l);
      if (cityLocation == null) {
        logger.d('$l of $o could not be transformed to the city location');
        continue;
      }
      if (_map.containsKey(cityLocation)) {
        _map[cityLocation]?.add(o);
      } else {
        _map[cityLocation] = [o];
      }
    }
    return _map;
  }

  Future<MapInfo> _buildMapInfo(
    Map<CityLocation, List<MapPin>> locationsMap,
  ) async {
    final _map = <Coordinates, List<MapPin>>{};
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
  Future<MapInfo> getPinsOnMap() async {
    final users = await _usersRepository.getAllUsers();
    final events = await _eventsRepository.getEvents();
    final locations = _locationMapFrom([
      for (final u in users)
        if (u.location case final l? when u.showLocation && l.isNotEmpty)
          (l, ProfilePin(u)),
      for (final e in events)
        if (e.location case final l? when l.isNotEmpty) (l, EventPin(e)),
    ]);
    return _buildMapInfo(locations);
  }

  @override
  Future<List<CityLocation>> suggestions(String city) =>
      _dbManager.cities(city);
}
