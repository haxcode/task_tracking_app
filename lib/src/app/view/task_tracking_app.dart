import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/view/main_view.dart';
import 'package:task_tracking_app/src/app/view/todo_list.dart';


class TaskTrackingApp extends StatelessWidget {
  final String appName = 'Task tracking app';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
          title: appName,
          home: new MainView(title: appName,)
//        title: 'Daily task list',
//        home: new TodoList()
    );
  }
}

