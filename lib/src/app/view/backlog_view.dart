import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/view/about.dart';
import 'package:task_tracking_app/src/app/view/task/todo_list.dart';
import 'package:task_tracking_app/src/app/view/task/work_time_list.dart';

class BacklogView extends StatelessWidget {
  static const routeName = '/backlog';
  final String title = "Backlog";

  const BacklogView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: TodoList(0),
    );
  }
}
