import 'package:flutter/material.dart';

class TimerController {
  VoidCallback? onStart;
  VoidCallback? onStop;
  Function(int)? onSetTime;
  final int initialTime;

  TimerController({required this.initialTime});

  void start() {
    onStart?.call();
  }

  void stop() {
    onStop?.call();
  }

  void setTime(int time) {
    onSetTime?.call(time);
  }
}
