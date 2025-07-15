import 'package:ui_alumni_mobile/application/models/city_location.dart';
import 'package:ui_alumni_mobile/application/models/coordinates.dart';
import 'package:ui_alumni_mobile/data/db/db_manager.dart';

class DbMock extends DbManager {
  @override
  Future<List<CityLocation>> cities(String city) async {
    return [];
  }

  @override
  Future<Coordinates?> coordinates(String country, String city) async {
    return null;
  }

  @override
  void dispose() {}

  @override
  Future<void> init() async {}
}
