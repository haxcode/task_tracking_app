import 'dart:ui';

import 'package:flutter/material.dart';

class TodoCreateForm extends StatelessWidget {
  static const routeName = '/createTodoForm';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add a new task'),
        backgroundColor: Colors.blueAccent,
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(
                labelText: "Title",
              ),
            ),
            autofocus: true,
          ),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(
                  labelText: "Description"),
            ),
          ),
          new ListTile(
            title: new TextField(

              decoration: new InputDecoration(
                  labelText: "Estimated time"),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
