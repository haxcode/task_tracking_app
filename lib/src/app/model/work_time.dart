import 'package:flutter/material.dart';

class workTime {

  final int id;
  final String startTime;
  final String stopTime;
  final String done;

  workTime({this.id, this.startTime, this.stopTime, this.done});

  Map<String, dynamic> toMap() {
    return  {
      "id": id,
      "startTime":startTime,
      "stopTime":stopTime,
      "done":done,
    };
  }


}
