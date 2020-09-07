import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('About'),
          backgroundColor: Colors.blueAccent,
        ),
        body: new Column(
          children: <Widget>[
            Text(
                'Application created to track Your work progress. '
                'Alowing to count time spended on single task. \n \n'
                'Authors: \n'
                'Robert Kubica \n'
                'Sebastian Przeliorz',
                style: new TextStyle(fontSize: 20.0, fontFamily: 'Roboto'))
          ],
        ));
    throw UnimplementedError();
  }
}
