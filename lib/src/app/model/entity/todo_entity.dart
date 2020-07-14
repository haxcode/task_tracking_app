import 'package:sqflite/sqflite.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';
import 'package:task_tracking_app/src/inf/persistence.dart';

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
      );
    });
  }

  Future<void> update(Todo todo) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'todo',
      todo.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [todo.id],
    );
  }

  Future<void> delete(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'todo',
      where: "id = ?",

      whereArgs: [id],
    );
  }
}
