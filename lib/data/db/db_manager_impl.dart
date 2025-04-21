import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import '../../application/models/city_location.dart';
import '../../application/models/coordinates.dart';
import '../../gen/assets.gen.dart';
import '../../util/logger.dart';
import 'db_manager.dart';

class DbManagerImpl extends DbManager {
  sqflite.Database? _db;

  static const _searchLimit = 5;
  static const _dbName = 'world_cities.db';

  Future<void> _copyDb(String path) async {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      logger.e(e);
    }
    final data = await rootBundle.load(Assets.dbs.worldCities);
    final bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(path).writeAsBytes(bytes, flush: true);
  }

  Future<void> _openDb() async {
    final databasesPath = await sqflite.getDatabasesPath();
    final path = join(databasesPath, _dbName);
    final exists = await sqflite.databaseExists(path);
    if (!exists) {
      logger.d('Copying the database cause it does not exist yet');
      await _copyDb(path);
      logger.d('Database copying finished');
    }
    logger.d('Opening the database');
    _db = await sqflite.openDatabase(path, readOnly: true);
  }

  @override
  Future<void> init() => _openDb();

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
