import 'package:flutter/material.dart';

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
    if(task.length > 0){

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
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
      },
    );
  }

  void _createAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well
      // as adding a back button to close it
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new task')
                  ),
                  body: new TextField(
                        autofocus: true,
                        onSubmitted: (val) {
                          _addTodoItem(val);
                          Navigator.pop(context); // Close the add todo screen
                        },
                        decoration: new InputDecoration(
                            hintText: 'Title of your task',
                            contentPadding: const EdgeInsets.all(16.0)

                        ),

                      )
              );
            }
        )
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText) {
    return new ListTile(
        title: new Text(todoText)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: AppBar( // Here we create one to set status bar color
              backgroundColor: Colors.transparent,
              title: Text('Daily tasks', style:TextStyle(color: Colors.grey[700], fontSize: 17)),
              elevation:0.0 ,
              toolbarOpacity: 0.0,
              bottomOpacity: 0.0,
            ),
          )
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _createAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)
      ),
    );
  }
}
