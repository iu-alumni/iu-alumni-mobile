import 'package:ui_alumni_mobile/application/models/event.dart';

import '../../../data/map/map_gateway.dart';
import '../../../util/logger.dart';
import '../../models/city_location.dart';
import '../../models/coordinates.dart';
import '../events/events_repository.dart';
import '../locations/locations_repository.dart';
import 'map_repository.dart';

class MapRepositoryImpl extends MapRepository {
  MapRepositoryImpl(
    this._mapGateway,
    this._eventsRepository,
    this._locationsRepository,
  );

  final MapGateway _mapGateway;
  final EventsRepository _eventsRepository;
  final LocationsRepository _locationsRepository;

  CityLocation? _cityLocationFromStr(String location) {
    final data = location.split(', ');
    if (data.length != 2) return null;
    return CityLocation(country: data[0], city: data[1]);
  }

  @override
  Future<MapInfo> getPinsOnMap() async {
    // Alumni locations come pre-grouped and pre-resolved from the backend —
    // no need to load all profiles or do per-city coordinate lookups.
    final alumniGroups = await _mapGateway.getMapLocations();
    final events = await _eventsRepository.getEvents();

    final map = <NamedCoordinates, CityData>{};

    // Add alumni pins from the grouped map endpoint.
    for (final group in alumniGroups) {
      final nc = NamedCoordinates(
        coord: Coordinates(group.lat, group.lng),
        country: group.country,
        city: group.city,
      );
      map[nc] = CityData(events: const [], profiles: const [], alumniCount: group.count);
    }

    // Overlay event pins: look up coordinates, then merge into existing pins
    // or create new ones for event-only locations.
    for (final event in events) {
      final l = event.location;
      if (l == null || l.isEmpty) continue;
      final cityLocation = _cityLocationFromStr(l);
      if (cityLocation == null) {
        logger.d('Event location "$l" could not be parsed as "Country, City"');
        continue;
      }

      // Try to find an existing alumni pin for this city.
      final existingKey = map.keys.where(
        (nc) =>
            nc.country.toLowerCase() == cityLocation.country.toLowerCase() &&
            nc.city.toLowerCase() == cityLocation.city.toLowerCase(),
      ).firstOrNull;

      if (existingKey != null) {
        final existing = map[existingKey]!;
        map[existingKey] = CityData(
          events: [...existing.events, event],
          profiles: existing.profiles,
          alumniCount: existing.alumniCount,
        );
      } else {
        // Event-only location: resolve coordinates.
        final coords = await _locationsRepository.coordinates(
          cityLocation.country,
          cityLocation.city,
        );
        if (coords == null) {
          logger.d('No coordinates for event location "$l"');
          continue;
        }
        final nc = NamedCoordinates(
          coord: coords,
          country: cityLocation.country,
          city: cityLocation.city,
        );
        map[nc] = CityData(events: [event], profiles: const [], alumniCount: 0);
      }
    }

    return map;
  }

  @override
  Future<List<CityLocation>> suggestions(String city) =>
      _locationsRepository.cities(city);
}

