import 'package:flutter/material.dart';

class WorkTime {

  final int id;
  final String startTime;
  final String stopTime;
  final String done;

  WorkTime({this.id, this.startTime, this.stopTime, this.done});

  Map<String, dynamic> toMap() {
    return  {
      "id": id,
      "startTime":startTime,
      "stopTime":stopTime,
      "done":done,
    };
  }


}
