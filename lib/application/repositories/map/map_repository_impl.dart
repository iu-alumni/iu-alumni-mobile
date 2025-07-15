import 'package:ui_alumni_mobile/application/models/event.dart';
import 'package:ui_alumni_mobile/application/models/profile.dart';
import 'package:ui_alumni_mobile/application/repositories/locations/locations_repository.dart';

import '../../../util/logger.dart';
import '../../models/city_location.dart';
import '../events/events_repository.dart';
import '../users/users_repository.dart';
import 'map_repository.dart';

class MapRepositoryImpl extends MapRepository {
  MapRepositoryImpl(
    this._locationsRepository,
    this._usersRepository,
    this._eventsRepository,
  );

  final LocationsRepository _locationsRepository;
  final UsersRepository _usersRepository;
  final EventsRepository _eventsRepository;

  CityLocation? _cityLocationFromStr(String location) {
    final data = location.split(', ');
    if (data.length != 2) {
      return null;
    }
    return CityLocation(country: data[0], city: data[1]);
  }

  Map<CityLocation, CityData> _locationMapFrom({
    required Iterable<(String, Profile)> profiles,
    required Iterable<(String, EventModel)> events,
  }) {
    final _map = <CityLocation, CityData>{};
    for (final (l, o) in profiles) {
      final cityLocation = _cityLocationFromStr(l);
      if (cityLocation == null) {
        logger.d('$l of $o could not be transformed to the city location');
        continue;
      }
      if (_map.containsKey(cityLocation)) {
        _map[cityLocation]?.profiles.add(o);
      } else {
        _map[cityLocation] = CityData(events: [], profiles: [o]);
      }
    }
    for (final (l, o) in events) {
      final cityLocation = _cityLocationFromStr(l);
      if (cityLocation == null) {
        logger.d('$l of $o could not be transformed to the city location');
        continue;
      }
      if (_map.containsKey(cityLocation)) {
        _map[cityLocation]?.events.add(o);
      } else {
        _map[cityLocation] = CityData(events: [o], profiles: []);
      }
    }
    return _map;
  }

  Future<MapInfo> _buildMapInfo(
    Map<CityLocation, CityData> locationsMap,
  ) async {
    final _map = <NamedCoordinates, CityData>{};
    for (final entry in locationsMap.entries) {
      final coords = await _locationsRepository.coordinates(
        entry.key.country,
        entry.key.city,
      );
      if (coords == null) {
        logger.d(
          '${entry.key.country}, ${entry.key.city} could not be mapped to proper coordinates',
        );
        continue;
      }
      final namedCoords = NamedCoordinates(
        coord: coords,
        city: entry.key.city,
        country: entry.key.country,
      );
      _map[namedCoords] = entry.value;
    }
    return _map;
  }

  @override
  Future<MapInfo> getPinsOnMap() async {
    final users = await _usersRepository.getAllUsers();
    final events = await _eventsRepository.getEvents();
    final locations = _locationMapFrom(
      profiles: [
        for (final u in users)
          if (u.location case final l? when u.showLocation && l.isNotEmpty)
            (l, u),
      ],
      events: [
        for (final e in events)
          if (e.location case final l? when l.isNotEmpty) (l, e),
      ],
    );
    return _buildMapInfo(locations);
  }

  @override
  Future<List<CityLocation>> suggestions(String city) =>
      _locationsRepository.cities(city);
}
