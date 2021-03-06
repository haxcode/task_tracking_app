import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Persistence {
  static Database _db;

  String _databaseName = "task_tracking_database.db";
  // TODO change hear
  int _databaseVersion = 5;

  Future<Database> get database async {
    if (_db != null) return _db;
    // lazily instantiate the db the first time it is accessed
    _db = await _initDatabase();
    return _db;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _create);
  }

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(
      path.path,
    );
//todo change version if add new table
    _db = await openDatabase(dbPath, version: 5);
  }

  Future _create(Database db, int version) async {
    await db.execute("""
            CREATE TABLE todo (
              id INTEGER PRIMARY KEY, 
              title TEXT NOT NULL,
              description TEXT,
              estimatedTime TEXT,
              done INTEGER
            )""");
//TODO add definition of table
    await db.execute("""
            CREATE TABLE work_time (
             id INTEGER PRIMARY KEY,
             startTime TEXT,
             stopTime TEXT,
             duration INTEGER,
             descryption TEXT,
             todo_id INTEGER           
            )""");
  }
}
