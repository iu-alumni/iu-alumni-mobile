import 'package:equatable/equatable.dart';

import '../../models/city_location.dart';
import '../../models/coordinates.dart';
import '../../models/event.dart';
import '../../models/profile.dart';

abstract class MapRepository {
  Future<MapInfo> getPinsOnMap();

  Future<List<CityLocation>> suggestions(String city);
}

class CityData {
  const CityData({
    required this.events,
    required this.profiles,
    this.alumniCount = 0,
  });

  final List<Profile> profiles;
  final List<EventModel> events;

  /// Total number of alumni at this location.
  ///
  /// Populated from the `/profile/map` grouped endpoint. [profiles] may be
  /// empty on the map view (profiles are lazy-loaded in CityDataPage).
  final int alumniCount;
}

class NamedCoordinates extends Equatable {
  const NamedCoordinates({
    required this.coord,
    required this.country,
    required this.city,
  });
  final Coordinates coord;
  final String country;
  final String city;

  @override
  List<Object?> get props => [country, city, coord];

  String get fullLocation => '$country, $city';
}

typedef MapInfo = Map<NamedCoordinates, CityData>;
