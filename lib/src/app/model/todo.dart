
import 'package:flutter/material.dart';

class Todo {

  final int id;
  final String title;
  final String description;
  final String estimatedTime;
  final String startTime;
  final String stopTime;
  final String done;

  Todo({this.id, this.title, this.description, this.estimatedTime, this.startTime, this.stopTime, this.done});

  Map<String, dynamic> toMap() {
    return  {
      "id": id,
      "title":title,
      "description":description,
      "estimatedTime":estimatedTime,
      //"startTime":startTime,
      //"stopTime":stopTime,
      //"done":done,
    };
  }


}
