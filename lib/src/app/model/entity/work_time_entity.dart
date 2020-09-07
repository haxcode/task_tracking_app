import 'package:sqflite/sqflite.dart';
import 'package:task_tracking_app/src/app/model/work_time.dart';
import 'package:task_tracking_app/src/inf/persistence.dart';

class WorkTimeEntity extends Persistence {
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
        todoId: maps[i]['todo_id'],
        startTime: maps[i]['startTime'],
        descryption: maps[i]['descryption'],
        duration: maps[i]['duration'],
        stopTime: maps[i]['stopTime'],
      );
    });
  }

  Future<List<WorkTime>> workTimeFiltered(int todoId) async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The todo.
    final List<Map<String, dynamic>> maps =
        await db.query('work_time', where: 'todo_id = ?', whereArgs: [todoId]);

    // Convert the List<Map<String, dynamic> into a List<Todo>.
    return List.generate(maps.length, (i) {
      return WorkTime(
        id: maps[i]['id'],
        todoId: maps[i]['todo_id'],
        startTime: maps[i]['startTime'],
        descryption: maps[i]['descryption'],
        duration: maps[i]['duration'],
        stopTime: maps[i]['stopTime'],
      );
    });
  }

  Future<List<WorkTime>> workTimeByID(int id) async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The todo.
    final List<Map<String, dynamic>> maps = await db.query(
      'work_time',
      where: "id = ?",
      whereArgs: [id],
    );

    // Convert the List<Map<String, dynamic> into a List<Todo>.
    return List.generate(maps.length, (i) {
      return WorkTime(
        id: maps[i]['id'],
        todoId: maps[i]['todo_id'],
        startTime: maps[i]['startTime'],
        descryption: maps[i]['descryption'],
        duration: maps[i]['duration'],
        stopTime: maps[i]['stopTime'],
      );
    });
  }

  Future<void> update(WorkTime workTime) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'work_time',
      workTime.toMap(),
      where: "id = ?",
      whereArgs: [workTime.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<WorkTime> getLast(int todoId) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    final List<Map<String, dynamic>> maps = await db.query('work_time',
        where: "todo_id = ? ", whereArgs: [todoId], orderBy: 'id', limit: 1);

    return WorkTime(
      id: maps.first['id'],
      todoId: maps.first['todo_id'],
      startTime: maps.first['startTime'],
      descryption: maps.first['descryption'],
      stopTime: maps.first['stopTime'],
    );
  }

  Future<void> delete(WorkTime workTime) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'work_time',
      where: "id = ?",
      whereArgs: [workTime.id],
    );
  }
}
