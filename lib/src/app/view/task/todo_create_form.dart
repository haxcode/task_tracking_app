import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/controller/todo_Item.dart';
import 'package:task_tracking_app/src/app/model/entity/todo_entity.dart';
import 'package:task_tracking_app/src/app/view/main_view.dart';
import 'package:task_tracking_app/src/app/view/task/todo_list.dart';


class TodoCreateForm extends StatefulWidget {
  static const routeName = '/createTodoForm';
  TodoCreateForm({Key key}) : super(key: key);
  @override
  TodoCreateFormState createState() {
    return TodoCreateFormState();
  }
}

class TodoCreateFormState extends State<TodoCreateForm>{
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _estimatedTimeController = TextEditingController();

  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add a new task'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check),
            onPressed: () {
              this.addTask();
            },),
        ],
      ),

      body: new Column(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(
                labelText: "Title",
              ),
              controller: _titleController,
            ),
            autofocus: true,
          ),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(labelText: "Description"),
              controller: _descriptionController,
            ),
          ),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(labelText: "Estimated time"),
              controller: _estimatedTimeController,
            ),
          ),
          const Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }

  void addTask() {
    developer.log(_titleController.text);
    developer.log(_descriptionController.text);
    developer.log(_estimatedTimeController.text);
    Navigator.pushNamed(context, MainView.routeName);
  }
}


