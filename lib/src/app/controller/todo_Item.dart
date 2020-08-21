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

  static Todo doneTask(Todo todo) {
    TodoEntity db = new TodoEntity();
    Todo newTodo = new Todo(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        estimatedTime: todo.estimatedTime,
        done: 1
    );

    db.update(newTodo);
    return newTodo;
}
//todo add full crud hear

}
