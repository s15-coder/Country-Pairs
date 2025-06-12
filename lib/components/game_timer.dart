import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/providers/timer/controller.dart';
import 'package:pairs_game/providers/timer/provider.dart';

class GameTimer extends ConsumerStatefulWidget {
  const GameTimer({
    super.key,
  });

  @override
  ConsumerState<GameTimer> createState() => _GameTimerState();
}

class _GameTimerState extends ConsumerState<GameTimer> {
  Timer? _timer;
  TimerController get _timerController => ref.read(timerProvider.notifier);
  @override
  void initState() {
    super.initState();
    final timerState = ref.read(timerProvider);
    if (timerState.isRunning) {
      startTimer();
    } else {
      stopTimer();
    }
  }

  void startTimer() {
    stopTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timerController.onSecondPassed();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remainingSeconds = ref.watch(timerProvider).remainingSeconds;
    ref.listen(timerProvider, (previous, next) {
      if (previous?.isRunning == true && next.isRunning == false) {
        stopTimer();
      }
      if (previous?.isRunning == false && next.isRunning == true) {
        startTimer();
      }
    });
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: const BoxDecoration(
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
            '$remainingSeconds s',
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
