import 'package:flutter/material.dart';

class WorkTime {

  final int id;
  final String startTime;
  final String stopTime;
  final int duration;
  final String descryption;
  final int todoId;

  WorkTime({this.id, this.todoId, this.startTime, this.stopTime,this.duration, this.descryption});

  Map<String, dynamic> toMap() {
    return  {
      "id": id,
      "startTime":startTime,
      "stopTime":stopTime,
      "descryption":descryption,
      "duration":duration,
      "todo_id": todoId
    };
  }


}
