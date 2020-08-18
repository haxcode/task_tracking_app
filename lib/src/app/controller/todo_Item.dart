import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/model/entity/todo_entity.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';
import 'dart:developer' as developer;

class TodoItem {
  void createTodo(Todo todo) {
    TodoEntity db = new TodoEntity();
    db.insert(todo);
  }

  static void deleteTodo(Todo todo) {
    TodoEntity db = new TodoEntity();
    db.delete(todo.id);
  }

  static void updateTodo(Todo todo) {
    TodoEntity db = new TodoEntity();
    db.update(todo);
  }

  static TodoItem readTodo(Todo todo) {
    TodoEntity db = new TodoEntity();
    db.getTodo(todo.id);
  }

  static void doneTask(int id)  {
    TodoEntity db = new TodoEntity();
    developer.log( "start");
    Future<Todo> todoFeature = db.getTodo(id);
    developer.log( "pobrano $id coś się zapisało");
    todoFeature.then((value) => () {
      developer.log( "assync $value coś się zapisało");
      Todo todo = new Todo(
          id: value.id,
          title: value.title,
          description: value.description,
          estimatedTime: value.estimatedTime,
          done: 1);
      db.update(todo);
      developer.log(value.id.toString() + "coś się zapisało");

    });
  }
//todo add full crud hear

}
