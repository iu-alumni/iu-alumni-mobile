import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../application/models/city_location.dart';
import '../../application/models/coordinates.dart';
import 'db_loader.dart';
import 'db_manager.dart';

class DbManagerImpl extends DbManager {
  final _dbLoader = DbLoader();

  sqflite.Database? _db;

  static const _searchLimit = 10;

  @override
  Future<void> init() async {
    _db = await _dbLoader.loadDb();
  }

  @override
  void dispose() async {
    _db?.close();
    _db = null;
  }

  Coordinates _coordFromJson(Map<String, Object?> data) =>
      Coordinates(data['lat'] as double, data['lng'] as double);

  @override
  Future<Coordinates?> coordinates(String country, String city) async {
    final data = await _db?.query(
      'cities',
      columns: ['lat', 'lng'],
      where: 'city = ? AND country = ?',
      whereArgs: [city, country],
    );
    if (data == null || data.isEmpty) {
      return null;
    }
    return Option.tryCatch(() => _coordFromJson(data.first)).toNullable();
  }

  CityLocation _cityLocationFromJson(Map<String, Object?> data) =>
      CityLocation(data['country'] as String, data['city'] as String);

  @override
  Future<List<CityLocation>> cities(String city) async {
    final data = await _db?.query(
      'cities_fts',
      columns: ['city', 'country'],
      where: 'city MATCH ? || \'*\'',
      whereArgs: [city],
      limit: _searchLimit,
    );
    if (data == null) {
      return [];
    }
    return Option.tryCatch(
      () => data.map(_cityLocationFromJson).toList(),
    ).match(() => [], identity);
  }
}
