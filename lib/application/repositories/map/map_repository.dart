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
  const CityData({required this.events, required this.profiles});
  final List<Profile> profiles;
  final List<EventModel> events;
}

class NamedCoordinates extends Equatable {
  const NamedCoordinates({required this.coord, required this.name});
  final Coordinates coord;
  final String name;

  @override
  List<Object?> get props => [name, coord];
}

typedef MapInfo = Map<NamedCoordinates, CityData>;
