import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/controller/todo_Item.dart';
import 'package:task_tracking_app/src/app/model/entity/todo_entity.dart';
import 'package:task_tracking_app/src/app/model/entity/work_time_entity.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';
import 'package:task_tracking_app/src/app/model/work_time.dart';
import 'package:task_tracking_app/src/app/view/main_view.dart';
import 'package:task_tracking_app/src/app/view/task/todo_editable_form.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WorkTimeList extends StatefulWidget {
  var id;

  WorkTimeList(var id) {
    this.id = id;
  }

  @override
  createState() {
    return new WorkTimeListState(this.id);
  }
}

class WorkTimeListState extends State<WorkTimeList> {
  WorkTimeEntity _workTimeEntity = new WorkTimeEntity();

  Future<List<WorkTime>> workTimeItems;

  var _id;

  WorkTimeListState(id);

  @override
  void initState() {

    fetchTodos(this._id);
    super.initState();
  }

  Future<void> _getData() async {
    setState(() {
      fetchTodos(this._id);
    });
  }

  void fetchTodos(var id) async {
    setState(() {
      if (id == null) {
        workTimeItems = _workTimeEntity.workTime();
      } else {
        workTimeItems = _workTimeEntity.workTimeByID(id);
      }
    });
  }

  // This will be called each time the + button is pressed

  void _showSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }

  // Build the whole list of WorkTimeItems
  Widget _buildTodoList() {
    return new FutureBuilder<List<WorkTime>>(
      future: workTimeItems,
      builder: (context, workTimeSnap) {
        switch (workTimeSnap.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading....');
          default:
            if (workTimeSnap.hasError)
              return new Text('Error: ${workTimeSnap.error}');
            else
              return _listView(workTimeSnap.data);
        }
      },
    );
  }

  Widget _listView(List<WorkTime> workTimeData) {
    return workTimeData.length != 0
        ? RefreshIndicator(
            child: ListView.builder(
                itemCount: workTimeData.length,
                itemBuilder: (context, index) {
                  return _buildTodoItem(workTimeData[index]);
                }),
            onRefresh: _getData)
        : Center(
            child: Column(
            children: <Widget>[
              Container(
                child: Icon(Icons.timelapse, size: 64, color: Colors.grey),
                width: 75,
                height: 150,
                margin: EdgeInsets.fromLTRB(10, 100, 10, 0),
              ),
              Text(
                "Work time list is empty",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
              )
            ],
          ));
  }

  // Build a single todo item
  Widget _buildTodoItem(WorkTime workTime) {
    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            enabled: false,
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.timelapse),
              foregroundColor: Colors.white,
            ),
            trailing: Text(formatDuration(workTime.duration)),
            title: Text(DateTime.parse(workTime.startTime.toString())
                    .toLocal()
                    .toString() +
                " - " +
                DateTime.parse(workTime.stopTime.toString())
                    .toLocal()
                    .toString()),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.redAccent,
            icon: Icons.delete_outline,
            onTap: () => {
              setState(() {
                _workTimeEntity.delete(workTime);
                workTimeItems.then((value) => value
                    .removeWhere((element) => (element.id == workTime.id)));
                _showSnackBar('Deleted');
              }),
//                Navigator.pushNamed(context, MainView.routeName),
            },
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: AppBar(
              // Here we create one to set status bar color
              backgroundColor: Colors.transparent,
              title: Text('Work Time',
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              elevation: 0.0,
              toolbarOpacity: 0.0,
              bottomOpacity: 0.0,
            ),
          )),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          this.setState(() {
            Future<void> future = _getData();
            future.then((value) => (value) {
                  if (value != null) {
                    setState(() {
                      workTimeItems = future;
                    });
                  }
                });
          });
        },
        tooltip: 'Refresh',
        child: new Icon(Icons.refresh),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  String formatDuration(int duration) {
    var dur = Duration(seconds: duration);
    return (dur.inHours).toString().padLeft(2, "0") +
        ":" +
        (dur.inMinutes % 60).toString().padLeft(2, "0") +
        ":" +
        (dur.inSeconds % 60).toString().padLeft(2, "0");
  }
}
