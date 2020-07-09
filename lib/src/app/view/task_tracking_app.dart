import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/view/main_view.dart';

import 'task/todo_create_form.dart';


class TaskTrackingApp extends StatelessWidget {
  final String appName = 'Task tracking app';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
          title: appName,
          home: new MainView(title: appName),
          routes: {
            TodoCreateForm.routeName:(context) => TodoCreateForm(),
          },

    );
  }
}

