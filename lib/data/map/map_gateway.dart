import '../../application/models/map_location_group.dart';

abstract interface class MapGateway {
  /// Fetch alumni location groups for map pin display.
  ///
  /// Returns one entry per unique city containing at least one alumni with
  /// `show_location = true`. Coordinates are pre-resolved server-side.
  Future<List<MapLocationGroup>> getMapLocations();
}
