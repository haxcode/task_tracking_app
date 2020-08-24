import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_tracking_app/main.dart';
import 'package:task_tracking_app/src/app/model/entity/todo_entity.dart';
import 'package:task_tracking_app/src/app/model/entity/work_time_entity.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';
import 'package:task_tracking_app/src/app/model/work_time.dart';
import 'package:task_tracking_app/src/app/view/main_view.dart';
import 'package:task_tracking_app/src/app/view/task/todo_list.dart';
import 'package:task_tracking_app/src/app/view/task/work_time_list.dart';

class TodoEditableForm extends StatefulWidget {
  static const routeName = '/todoForm';

  TodoEditableForm({Key key, Todo this.todo}) : super(key: key);
  Todo todo;

  @override
  TodoEditableFormState createState() {
    if (todo == null) {
      this.todo = new Todo(
          id: null,
          title: "",
          description: "",
          estimatedTime: "1d",
          done: 0);
    }
    return TodoEditableFormState(this.todo);
  }
}

enum FormStateEnum { create, read, update, delete }

class TodoEditableFormState extends State<TodoEditableForm>
    with SingleTickerProviderStateMixin {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _estimatedTimeController = TextEditingController();
  FormStateEnum _formStateController = FormStateEnum.create;
  TabController tb;
  Todo _todo;
  IconData icon;
  var watch = Stopwatch();
  final duration = const Duration(seconds: 1);
  IconData startStopIcon = Icons.play_arrow;

  List<Widget> tabs = [
    Text(
      "Details",
      style: TextStyle(),
    ),
    Text("Work Time"),
  ];

  String title = "Task";

  Null Function() action;

  String timeString = "00:00:00";

  bool startIsPressed = false;
  bool restartIsPressed = false;
  Timer timer;

  WorkTime wt;


  @override
  void initState() {
    tb = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  void startTimer() {
    timer = Timer(this.duration, keepRunning);
  }

  void keepRunning() {
    if (watch.isRunning) {
      startTimer();
    }
    refreshState();
  }

  void refreshState() {
    setState(() {
      timeString = watch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (watch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (watch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
      startStopIcon = startIsPressed ? Icons.pause : Icons.play_arrow;
    });
  }

  void startStopWatch() {
    developer.log("startStopWatch was pressed !!!!");
    if (restartIsPressed) {
      if (watch.isRunning) {
        watch.stop();
      }
      watch.reset();
      setState(() {
        startIsPressed = false;
        restartIsPressed = !restartIsPressed;
      });
      refreshState();
    } else {
      if (!startIsPressed) {
        setState(() {
          startIsPressed = true;
        });
        watch.start();
        startTimer();
        wt = WorkTime(
            todoId: this._todo.id,
            startTime: DateTime.now().toIso8601String(),
            descryption: "Time from work time register stopwatch");
      } else {
        setState(() {
          startIsPressed = false;
        });
        watch.stop();
        WorkTimeEntity workTimeEntity = WorkTimeEntity();
          WorkTime newWT = WorkTime(
              todoId: wt.todoId,
              startTime: wt.startTime,
              stopTime: DateTime.now().toIso8601String(),
              duration: watch.elapsed.inSeconds.toInt(),
              descryption: wt.descryption);
          workTimeEntity.insert(newWT);
        }

      }
    }


  @override
  void dispose() {
    if (watch.isRunning) {
      watch.stop();
      if (timer.isActive) {
        timer.cancel();
      }
    }
    watch.reset();
    tb.dispose();
    super.dispose();
  }

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
        bottom: TabBar(
          tabs: tabs,
          labelPadding: EdgeInsets.only(bottom: 10.0),
          controller: tb,
        ),
      ),
      body: TabBarView(
        controller: tb,
        children: [
          Column(children: <Widget>[
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
            new ListTile(
              title: Text(
                'Register your time!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            new Expanded(
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                      flex: 6,
                      child: new Container(
                        child: new Text(
                          this.timeString,
                          style: new TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 36),
                        ),
                      ),
                    ),
                    new Expanded(
                        flex: 12,
                        child: Column(children: [
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Padding(
                                    child: FloatingActionButton(
                                      child: Icon(Icons.close),
                                      backgroundColor: Colors.redAccent,
                                      heroTag: "close",
                                      onPressed: () {
                                        restartIsPressed = true;
                                        startStopWatch();
                                      },
                                    ),
                                    padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Padding(
                                    child: FloatingActionButton(
                                      child: Icon(startStopIcon, size: 36),
                                      heroTag: "playPause",
                                      backgroundColor: Colors.green,
                                      onPressed: () {
                                        startStopWatch();
                                      },
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        12.5, 25, 12.5, 0),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Padding(
                                    child: FloatingActionButton(
                                      child: Icon(Icons.save),
                                      backgroundColor: Colors.blue,
                                      heroTag: "save",
                                      onPressed: () {},
                                    ),
                                    padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                                  ),
                                ),
                              ])
                        ]))
                  ],
                )),
          ]),
//          Column(children: [Text('Work time ')])
          WorkTimeList(_todo.id),
          //todo add component to register time
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

    newTodo.then((data) =>
    {
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
