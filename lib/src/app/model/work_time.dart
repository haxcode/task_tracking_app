import 'package:flutter/material.dart';

class WorkTime {

  final int id;
  final String startTime;
  final String stopTime;
  final int todoId;

  WorkTime({this.id, this.todoId, this.startTime, this.stopTime});

  Map<String, dynamic> toMap() {
    return  {
      "id": id,
      "startTime":startTime,
      "stopTime":stopTime,
      "todo_id": todoId
    };
  }


}
