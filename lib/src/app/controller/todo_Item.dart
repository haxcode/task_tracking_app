import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/model/entity/todo_entity.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';

class TodoItem {

  void createTodo(Todo todo){
    TodoEntity db = new TodoEntity();
    db.insert(todo);
  }

  static void deleteTodo(Todo todo) {
    TodoEntity db = new TodoEntity();
    db.delete(todo.id);
  }


  //todo add full crud hear




}
