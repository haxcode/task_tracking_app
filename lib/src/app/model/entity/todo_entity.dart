import 'package:sqflite/sqflite.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';
import 'package:task_tracking_app/src/inf/persistence.dart';
import 'dart:developer' as developer;

class TodoEntity extends Persistence {
  Future<void> insert(Todo todo) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> todo() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The todo.
    final List<Map<String, dynamic>> maps = await db.query('todo');

    // Convert the List<Map<String, dynamic> into a List<Todo>.
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        estimatedTime: maps[i]['estimatedTime'],
        //startTime: maps[i]['startTime'],
        //stopTime: maps[i]['stopTime'],
        done: maps[i]['done'],
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

  Future<void> update(Todo todo) async {
    // Get a reference to the database.
    final db = await database;

    await db.update(
      'todo',
      todo.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the id as a whereArg to prevent SQL injection.
      whereArgs: [todo.id],
    );
  }

  Future<void> delete(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove from the database.
    await db.delete(
      'todo',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<Todo> getTodo(int id) async {
    final db = await database;
    List<Map> maps = await db.query('todo', where: "id = ?", whereArgs: [id]);
    if (maps.length > 0) {
      //developer.log("pobrano $id coś się zapisało");
      return Todo(
        id: maps.first['id'],
        title: maps.first['title'],
        description: maps.first['description'],
        done: maps.first['done'],
        estimatedTime: maps.first['estimatedTime'],
      );
    }
    return null;
  }

  Future<List<Todo>> getFiltered(done) async {
    final Database db = await database;

    // Query the table for all The todo.
    final List<Map<String, dynamic>> maps = await db.query('todo', where: 'done = ?', whereArgs: [done]);

    // Convert the List<Map<String, dynamic> into a List<Todo>.
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        estimatedTime: maps[i]['estimatedTime'],
        //startTime: maps[i]['startTime'],
        //stopTime: maps[i]['stopTime'],
        done: maps[i]['done'],
      );
    });
  }
}
