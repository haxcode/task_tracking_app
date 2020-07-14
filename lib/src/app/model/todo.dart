
import 'package:flutter/material.dart';

class Todo {

  final int id;
  final String title;
  final String description;
  final TimeOfDayFormat estimatedTime;

  Todo({this.id, this.title, this.description, this.estimatedTime});

  Map<String, dynamic> toMap() {
    return  {
      "id": id,
      "title":title,
      "description":description,
      "estimatedTime":estimatedTime
    };
  }


}
