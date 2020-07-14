import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/model/entity/todo_entity.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';
import 'package:task_tracking_app/src/app/view/main_view.dart';
import 'package:task_tracking_app/src/app/view/task/todo_create_form.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_tracking_app/src/app/view/task/todo_form.dart';

class TodoList extends StatefulWidget {


  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  TodoEntity _todoEntity = new TodoEntity();

  Future<List<Todo>> todos;

  @override
  void initState() {
    super.initState();

    todos = _todoEntity.todo();
  }


  // This will be called each time the + button is pressed

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new FutureBuilder<List<Todo>>(
      future: todos,
      builder: (context, todoSnap ) {
        switch (todoSnap.connectionState) {
          case ConnectionState.waiting: return new Text('Loading....');
          default:
            if (todoSnap.hasError)
              return new Text('Error: ${todoSnap.error}');
            else
              return  _listView(todoSnap.data);
        }

      },
    );
  }

  Widget _listView(List<Todo> todoData){
    return new ListView.builder(
        itemCount: todoData.length,
        itemBuilder: (context, index) {
          return _buildTodoItem(todoData[index]);
        }
      );
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => TodoForm(todo)))
          },
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(todo.id.toString()), // Icon(Icons.today),
            foregroundColor: Colors.white,
          ),
          trailing: Text(todo.estimatedTime.toLowerCase()),
          title: Text(todo.title.toString()),
          subtitle: Text(todo.description.toString()),
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
          //onTap: () => _showSnackBar('More'),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.redAccent,
          icon: Icons.delete_outline,
          onTap: () => {
            _todoEntity.delete(todo.id),
            Navigator.pushNamed(context, MainView.routeName)
          },
        ),
      ],
    );
    //return new ListTile(
    //    title: new Text(todoText)
    //);
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
              title: Text('Daily tasks',
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              elevation: 0.0,
              toolbarOpacity: 0.0,
              bottomOpacity: 0.0,
            ),
          )),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){   Navigator.pushNamed(
          context,
          TodoCreateForm.routeName,
        );},
        tooltip: 'Add task',
        child: new Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
