import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class Persistence {
  static final String _databaseName = 'time_tracking_app_database.db';
  static final int _databaseVersion = 1;
  static Database _database;

  Persistence._private();

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(_databaseName);
    return await openDatabase(path, version: _databaseVersion, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          createTable(db);
    });
  }
  Future<void> createTable(Database db);
}
