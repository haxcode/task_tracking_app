import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/controller/todo_Item.dart';
import 'package:task_tracking_app/src/app/model/entity/todo_entity.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';
import 'package:task_tracking_app/src/app/view/main_view.dart';
import 'package:task_tracking_app/src/app/view/task/todo_editable_form.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatefulWidget {
  var _done;

  TodoList(var done) {
    this._done = done;
  }

  @override
  createState() => new TodoListState(this._done);
}

class TodoListState extends State<TodoList> {
  TodoEntity _todoEntity = new TodoEntity();
  var _done;

  TodoListState(var done) {
    this._done = done;
  }

  Future<List<Todo>> todos;

  @override
  void initState() {
    if (this._done == null) {
      todos = _todoEntity.todo();
    } else {
      todos = _todoEntity.getFiltered(this._done);
    }
    super.initState();
  }

  Future<void> _getData() async {
    setState(() {
      fetchTodo();
    });
  }

  void fetchTodo() async {
    setState(() {
      todos = _todoEntity.todo();
    });
  }

  // This will be called each time the + button is pressed

  void _showSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new FutureBuilder<List<Todo>>(
      future: todos,
      builder: (context, todoSnap) {
        switch (todoSnap.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading....');
          default:
            if (todoSnap.hasError)
              return new Text('Error: ${todoSnap.error}');
            else
              return _listView(todoSnap.data);
        }
      },
    );
  }

  Widget _listView(List<Todo> todoData) {
    return todoData.length != 0
        ? RefreshIndicator(
            child: ListView.builder(
                itemCount: todoData.length,
                itemBuilder: (context, index) {
                  return _buildTodoItem(todoData[index]);
                }),
            onRefresh: _getData)
        : Center(
            child: Column(
            children: <Widget>[
              Container(
                child: Icon(Icons.view_list, size: 64, color: Colors.grey),
                width: 75,
                height: 150,
                margin: EdgeInsets.fromLTRB(10, 100, 10, 0),
              ),
              Text(
                "Backlog is empty",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
              )
            ],
          ));
  }

  // Build a single todo item
  Widget _buildTodoItem(Todo todo) {
    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodoEditableForm(todo: todo)))
            },
            leading: CircleAvatar(
              backgroundColor:
                  (todo.done.toInt() == 0) ? Colors.blueAccent : Colors.green,
              child: Text(
                  (todo.done.toInt() == 0) ? "B" : "D"), // Icon(Icons.today),
              foregroundColor: Colors.white,
            ),
            trailing: Text(todo.estimatedTime.toLowerCase()),
            title: Text(todo.title.toString()),
            subtitle: Text(todo.description.toString()),
//            enabled: (todo.done == 0),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Start',
            color: Colors.blue,
            icon: Icons.timer,
            //onTap: () => _showSnackBar('Archive'),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Done',
            color: Colors.green,
            icon: Icons.assignment_turned_in,
            onTap: () => {
              setState(() {
                Todo newTodo = TodoItem.doneTask(todo);
                todos.then((value) => value.remove(todo));
                todos.then((value) => value.add(newTodo));
                _showSnackBar('Done');
              })
            },
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.redAccent,
            icon: Icons.delete_outline,
            onTap: () => {
              setState(() {
                TodoItem.deleteTodo(todo);
                todos.then((value) =>
                    value.removeWhere((element) => (element.id == todo.id)));
                _showSnackBar('Deleted');
              }),
//                Navigator.pushNamed(context, MainView.routeName),
            },
          )
        ]);
    //return new ListTile(
    //    title: new Text(todoText)
    //);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            TodoEditableForm.routeName,
          );
        },
        tooltip: 'Add task',
        child: new Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
