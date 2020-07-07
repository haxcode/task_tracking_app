import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/view/todo_list.dart';


class TaskTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Daily task list',
        home: new TodoList()
    );
  }
}

