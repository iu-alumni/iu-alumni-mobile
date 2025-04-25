import '../../models/city_location.dart';
import '../../models/coordinates.dart';
import '../../models/event.dart';
import '../../models/profile.dart';

abstract class MapRepository {
  Future<MapInfo> getPinsOnMap();

  Future<List<CityLocation>> suggestions(String city);
}

sealed class MapPin {
  const MapPin();
}

class ProfilePin extends MapPin {
  const ProfilePin(this.profile);
  final Profile profile;
}

class EventPin extends MapPin {
  const EventPin(this.event);
  final EventModel event;
}

typedef MapInfo = Map<Coordinates, List<MapPin>>;


