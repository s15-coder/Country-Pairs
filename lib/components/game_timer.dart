import 'dart:async';
import 'package:flutter/material.dart';

class GameTimerController {
  VoidCallback? onStart;
  VoidCallback? onStop;
  Function(int)? onSetTime;
  final int initialTime;

  GameTimerController({required this.initialTime});

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

class GameTimer extends StatefulWidget {
  const GameTimer({
    super.key,
    required this.controller,
    required this.onTimerEnd,
    this.onTimerTick,
  });
  final GameTimerController controller;
  final VoidCallback onTimerEnd;
  final Function(int)? onTimerTick;

  @override
  State<GameTimer> createState() => _GameTimerState();
}

class _GameTimerState extends State<GameTimer> {
  late int remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.controller.initialTime; // Default initial time
    startTimer();
    widget.controller.onStart = startTimer;
    widget.controller.onStop = stopTimer;
    widget.controller.onSetTime = setTime;
  }

  void startTimer() {
    stopTimer(); // Ensure no duplicate timers
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
          if (widget.onTimerTick != null) {
            widget.onTimerTick!(remainingTime);
          }
        });
      } else {
        timer.cancel();
        widget.onTimerEnd();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void setTime(int time) {
    setState(() {
      remainingTime = time;
    });
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.timer,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          Text(
            '$remainingTime',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
