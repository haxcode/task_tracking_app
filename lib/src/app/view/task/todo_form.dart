import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_tracking_app/src/app/model/todo.dart';
import 'package:task_tracking_app/src/app/model/entity/todo_entity.dart';
import 'package:task_tracking_app/src/app/view/task/todo_editable_form.dart';



//TODO merge this with todo createForm in one with state management
class TodoForm extends StatefulWidget {
  static const routeName = '/todoFormaaaaa';
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _estimatedTimeController = TextEditingController();
  FormStateEnum _formStateController;
  Todo _todo;

  IconData icon = Icons.edit;

  TodoForm(Todo _todo) {
    this._todo = _todo;
    _titleController.text = _todo.title.toString();
    _descriptionController.text = _todo.description.toString();
    _estimatedTimeController.text = _todo.estimatedTime.toString();
  }

  @override
  Widget build(BuildContext context) {
     //Build a Form widget using the _formKey created above.

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Task details'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(this.icon),
            onPressed: () {
              setState(){
                if(_formStateController == FormStateEnum.update){
                  this.updateTask();
                  _formStateController = FormStateEnum.read;
                }
              }
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

          // todo write own widget and add hear.
          new FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.done),
            onPressed: this.markAsDone(),
          )
        ],
      ),
    );
  }

  bool isEnabled() {
    return (_formStateController == FormStateEnum.create || _formStateController == FormStateEnum.update);
  }

  void updateTask() {
    //TODO implement method to update entity in dataBase use controller.

    Todo todo = new Todo(
      //to musi zostać dodane ( bo do tego id bedzemy updatowac)
      id: _todo.id,
      title: _titleController.text,
      description: _descriptionController.text,
      estimatedTime: _estimatedTimeController.text,
    );
    TodoEntity te = new TodoEntity();
    te.update(todo);

    Future<Todo> newTodo = te.getTodo(_todo.id);
    newTodo.whenComplete(() => {developer.log(newTodo.toString())} );
//
    developer.log('saved to DB');
    //Navigator.pushNamed(context, MainView.routeName);
  }

  markAsDone() {
    //developer.log('test saving');
    //TODO implement save task as done in model, think about use controler on task to perform this action.
  }

  @override
  State<StatefulWidget> createState() {
    if(this._formStateController == FormStateEnum.read){
      this.icon = Icons.edit;
    }
  }
}
