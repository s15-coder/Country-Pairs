import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/providers/timer/controller.dart';
import 'package:pairs_game/providers/timer/state.dart';

final timerProvider = StateNotifierProvider<TimerController, TimerState>((ref) {
  return TimerController(ref);
});
