import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/view/backlog_view.dart';
import 'package:task_tracking_app/src/app/view/main_view.dart';
import 'package:task_tracking_app/src/app/view/task/todo_editable_form.dart';
import 'package:task_tracking_app/src/app/view/work_time_view.dart';

import 'done_view.dart';

class TaskTrackingApp extends StatelessWidget {
  final String appName = 'Task tracking app';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: appName,
      home: new MainView(),
      routes: {
        MainView.routeName: (context) => MainView(),
        TodoEditableForm.routeName: (context) => TodoEditableForm(),
        WorkTimeView.routeName: (context) => WorkTimeView(),
        BacklogView.routeName: (context) => BacklogView(),
        DoneView.routeName: (context) => DoneView(),
      },
    );
  }
}
