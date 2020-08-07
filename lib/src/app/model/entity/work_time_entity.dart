import 'package:sqflite/sqflite.dart';
import 'package:task_tracking_app/src/app/model/work_time.dart';
import 'package:task_tracking_app/src/inf/persistence.dart';

class work_time_Entity extends Persistence {

  Future<void> insert(WorkTime workTime) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'work_time',
      workTime.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<WorkTime>> workTime() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The todo.
    final List<Map<String, dynamic>> maps = await db.query('work_time');

    // Convert the List<Map<String, dynamic> into a List<Todo>.
    return List.generate(maps.length, (i) {
      return WorkTime(
        id: maps[i]['id'],
        startTime: maps[i]['startTime'],
        stopTime: maps[i]['stopTime'],
        done: maps[i]['done'],
        //startTime: maps[i]['startTime'],
        //stopTime: maps[i]['stopTime'],
        //done: maps[i]['done'],
      );
    });
  }

//  final List<Map<String, dynamic>> maps = await db.query('work_time');
//
//  // Convert the List<Map<String, dynamic> into a List<Todo>.
//  return List.generate(maps.length, (i) {
//  return Work_time(
//  id: maps[i]['id'],
//  startTime: maps[i]['startTime'],
//  stopTime: maps[i]['stopTime'],
//  done: maps[i]['done'],
//  );
//  });
//}

  Future<void> update(WorkTime workTime) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'work_time',
      workTime.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [workTime.id],
    );
  }

  Future<void> delete(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'workTime',
      where: "id = ?",

      whereArgs: [id],
    );
  }

  Future<void> read(int id) async {
    final db = await database;

    //await db.read(
    //  'todo',
    //  where: "id = ?",

    // whereArgs: [id],
    //);
  }
}
