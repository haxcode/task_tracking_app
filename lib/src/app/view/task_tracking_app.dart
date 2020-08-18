import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/view/main_view.dart';
import 'package:task_tracking_app/src/app/view/task/todo_editable_form.dart';


class TaskTrackingApp extends StatelessWidget {
  final String appName = 'Task tracking app';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
          title: appName,
          home: new MainView(),
          routes: {
            MainView.routeName:(context) => MainView(),
            TodoEditableForm.routeName:(context) => TodoEditableForm(),

          },

    );
  }
}

