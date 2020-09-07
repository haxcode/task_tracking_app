import 'package:flutter/material.dart';

class Todo {
  final int id;
  final String title;
  final String description;
  final String estimatedTime;
  final int done;

  Todo({this.id, this.title, this.description, this.estimatedTime, this.done});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "estimatedTime": estimatedTime,
      "done": done,
    };
  }
}
