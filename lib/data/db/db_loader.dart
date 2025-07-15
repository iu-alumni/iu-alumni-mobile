import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart'
    show databaseExists, getDatabasesPath, openDatabase;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../../gen/assets.gen.dart';
import '../../util/logger.dart';

class DbLoader {
  static const _dbName = 'world_cities.db';

  Future<Database?> loadDb() async {
    if (kIsWasm || kIsWeb) {
      return null;
    }
    return _loadMobile();
  }

  Future<Uint8List> _readFromAssets() async {
    final data = await rootBundle.load(Assets.dbs.worldCities);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> _copyDb(String path) async {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      logger.e(e);
    }
    final bytes = await _readFromAssets();
    await File(path).writeAsBytes(bytes, flush: true);
  }

  Future<Database> _loadMobile() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);
    final exists = await databaseExists(path);
    if (!exists) {
      await _copyDb(path);
    }
    return openDatabase(path, readOnly: true);
  }
}
