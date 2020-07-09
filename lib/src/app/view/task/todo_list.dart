import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/view/task/todo_create_form.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
    // Putting our code inside "setState" tells the app that our state has changed, and
    // it will automatically re-render the list
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
      },
    );
  }


  // Build a single todo item
  Widget _buildTodoItem(String todoText) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigoAccent,
            child: Text('Task'),
            foregroundColor: Colors.white,
          ),
          title: Text(todoText),
          //subtitle: Text('Task'),
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
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          //onTap: () => _showSnackBar('Delete'),
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
