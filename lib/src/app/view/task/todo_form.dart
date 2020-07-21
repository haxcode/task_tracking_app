import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';
enum FormState {
  create,
  read,
  update,
  delete
}

//TODO merge this with todo createForm in one with state management
class TodoForm extends StatelessWidget {


  static const routeName = '/todoForm';
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _estimatedTimeController = TextEditingController();
  FormState  _formStateController;


  TodoForm(Todo _todo) {
    _formStateController = FormState.read;
    _titleController.text = _todo.title.toString();
    _descriptionController.text = _todo.description.toString();
    _estimatedTimeController.text = _todo.estimatedTime.toString();

  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Task details'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              this._formStateController = FormState.update;
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
                enabled: isEnabled(),
              ),
              controller: _titleController,
            ),
            //autofocus: true,
          ),
          new ListTile(
            title: new TextField(
              decoration: new InputDecoration(labelText: "Description"),
              enabled: isEnabled(),
              controller: _descriptionController,
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
          new FloatingActionButton(
            backgroundColor: Colors.green, child: Icon(Icons.done),
            onPressed: this.markAsDone(),
          )
        ],
      ),
    );
  }

  bool isEnabled(){
    return (_formStateController == FormState.create || _formStateController == FormState.update);
  }

  void updateTask() {
//    Todo todo = new Todo(
//        id: this._id,
//        title: _titleController.text,
//        description: _descriptionController.text,
//        estimatedTime: _estimatedTimeController.text);
//    TodoEntity te = new TodoEntity();
//    te.update(todo);
//
//    developer.log('saved to DB');
//    Navigator.pushNamed(context, MainView.routeName);
  }

  markAsDone() {
    //TODO implement save task as done in model, think about use controler on task to erform this action.
  }
}
