import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/providers/pairs/provider.dart';
import 'package:pairs_game/providers/timer/state.dart';

class TimerController extends StateNotifier<TimerState> {
  Ref ref;
  TimerController(this.ref) : super(TimerState.initial());

  void startTimer() {
    state = state.copyWith(isRunning: true);
  }

  void stopTimer() {
    state = state.copyWith(isRunning: false);
  }

  void onSecondPassed() {
    if (state.remainingSeconds > 0) {
      state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
    } else {
      stopTimer();
    }
  }

  void resetTimeForDifficulty() {
    final difficulty = ref.read(pairsProvider).difficulty;
    state = state.copyWith(
      initialTimeInSeconds: difficulty.secondsDuration,
      remainingSeconds: difficulty.secondsDuration,
    );
  }
}
