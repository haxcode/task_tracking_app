import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/controller/todo_Item.dart';
import 'package:task_tracking_app/src/app/model/entity/todo_entity.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';
import 'package:task_tracking_app/src/app/view/main_view.dart';
import 'package:task_tracking_app/src/app/view/task/todo_list.dart';

class TodoEditableForm extends StatefulWidget {
  static const routeName = '/todoForm';

  TodoEditableForm({Key key, Todo this.todo}) : super(key: key);
  Todo todo;

  @override
  TodoEditableFormState createState() {
    if (todo == null) {
      this.todo = new Todo(
          id: null, title: "", description: "", estimatedTime: "1d", done: 0);
    }
    return TodoEditableFormState(this.todo);
  }
}

enum FormStateEnum { create, read, update, delete }

class TodoEditableFormState extends State<TodoEditableForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _estimatedTimeController = TextEditingController();
  FormStateEnum _formStateController = FormStateEnum.create;
  Todo _todo;
  IconData icon;

  String title = "Details";

  Null Function() action;

  TodoEditableFormState(Todo _todo) {
    this._todo = _todo;

    if (_todo.id == null) {
      _formStateController = FormStateEnum.create;
    } else {
      _formStateController = FormStateEnum.read;
    }
    this.stateRefresh();
    _titleController.text = _todo.title.toString();
    _descriptionController.text = _todo.description.toString();
    _estimatedTimeController.text = _todo.estimatedTime.toString();
  }

  bool isEnabled() {
    return (_formStateController == FormStateEnum.create ||
        _formStateController == FormStateEnum.update);
  }

  void stateRefresh() {
    switch (this._formStateController) {
      case FormStateEnum.read:
        this.icon = Icons.edit;
        this.title = "Summary";
        this.action = () {
          _formStateController = FormStateEnum.update;
          this.stateRefresh();
        };
        break;
      case FormStateEnum.update:
        this.icon = Icons.save;
        this.title = "Edit";
        this.action = () {
          updateTask();
          _formStateController = FormStateEnum.read;
          this.stateRefresh();
        };
        break;
      case FormStateEnum.create:
        this.icon = Icons.done;
        this.title = "Create";
        this.action = () {
          addTask();
        };
        break;
      case FormStateEnum.delete:
        this.icon = Icons.delete;
        this.title = "Delete";
        this.action = () {
          //todo delete task
        };
        break;
    }
  }

  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title ?? "Summary" + " task"),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(this.icon),
            onPressed: () {
              setState(() {
                this.action();
              });
            },
          ),
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
              enabled: isEnabled(),
            ),
            //autofocus: true,
          ),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(labelText: "Description"),
              controller: _descriptionController,
              enabled: isEnabled(),
            ),
          ),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(labelText: "Estimated time"),
              controller: _estimatedTimeController,
              enabled: isEnabled(),
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
    Todo todo = new Todo(
      title: _titleController.text,
      description: _descriptionController.text,
      estimatedTime: _estimatedTimeController.text,
      done: 0,
    );
    TodoEntity te = new TodoEntity();
    te.insert(todo);

    developer.log('saved to DB');
    Navigator.popAndPushNamed(context, MainView.routeName);
  }

  void updateTask() {
    //TODO implement method to update entity in dataBase use controller.
    developer.log(_todo.id.toString() + " task id");
    Todo todo = new Todo(
        //to musi zostać dodane ( bo do tego id bedzemy updatowac)
        id: _todo.id,
        title: _titleController.text,
        description: _descriptionController.text,
        estimatedTime: _estimatedTimeController.text,
        done: 0);
    TodoEntity te = new TodoEntity();
    te.update(todo);

    Future<Todo> newTodo = te.getTodo(_todo.id);

    newTodo.then((data) => {
          () {
            this._todo = data;
            this._estimatedTimeController.text = data.estimatedTime;
            this._descriptionController.text = data.description;
            this._titleController.text = data.title;
          }
        });
//

    developer.log('saved to DB');
    //Navigator.pushNamed(context, MainView.routeName);
  }
}
