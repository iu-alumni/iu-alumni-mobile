import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart'
    show databaseExists, databaseFactory, getDatabasesPath, openDatabase;
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';

import '../../gen/assets.gen.dart';
import '../../util/logger.dart';

class DbLoader {
  static const _dbName = 'world_cities.db';

  get url => null;

  Future<Database> loadDb() {
    if (kIsWeb) {
      return _loadWeb();
    }
    return _loadMobile();
  }

  Future<Uint8List> _readFromAssets() async {
    final data = await rootBundle.load(Assets.dbs.worldCities);
    return data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
  }

  Future<Database> _loadWeb() async {
    databaseFactory = databaseFactoryFfiWeb;
    final bytes = await _readFromAssets();
    await databaseFactory.writeDatabaseBytes(_dbName, bytes);
    return databaseFactory.openDatabase(_dbName);
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
