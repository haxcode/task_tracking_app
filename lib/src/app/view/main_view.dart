import 'package:flutter/material.dart';
import 'package:task_tracking_app/src/app/view/about.dart';
import 'package:task_tracking_app/src/app/view/task/todo_create_form.dart';
import 'package:task_tracking_app/src/app/view/task/todo_list.dart';


class MainView extends StatelessWidget {
  static const routeName = '/daily';
  final String title = "Task tracking app";

  const MainView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),
        backgroundColor: Colors.blueAccent,),
      body: TodoList(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget> [
            DrawerHeader(
              child: Icon(
                Icons.timer,
                color: Colors.white,
                size: 100,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.blueAccent
              ),
            ),
            ListTile(
              title: Text('Daily'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Backlog'),
              onTap: () {
             
//                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Done'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Work Time'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
              ListTile(
                title: Text('About'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
               Navigator.push(context, MaterialPageRoute(builder: (context) => About()),);
               //Navigator.pop(context);
                },
            ),
          ],
        ),
      ),
    );
  }
}
