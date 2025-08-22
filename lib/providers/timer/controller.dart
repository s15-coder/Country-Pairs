import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/constants/sounds.dart';
import 'package:pairs_game/providers/pairs/provider.dart';
import 'package:pairs_game/providers/timer/state.dart';
import 'package:pairs_game/services/audio_player_service.dart';
import 'package:pairs_game/services/shared_preferences_provider.dart';

class TimerController extends StateNotifier<TimerState> {
  Ref ref;
  late AudioPlayerService audioPlayerInstance;
  late SharedPreferencesProvider sharedPreferences;
  TimerController(this.ref) : super(TimerState.initial()) {
    audioPlayerInstance = ref.read(audioPlayerService);
    sharedPreferences = ref.read(sharedPreferencesProvider);
  }
  void startTimer() {
    state = state.copyWith(isRunning: true);
  }

  void stopTimer() {
    state = state.copyWith(isRunning: false);
  }

  Future<void> onSecondPassed() async {
    if (state.remainingSeconds > 0) {
      state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
    } else {
      if (await sharedPreferences.isPlayMusicEnabled()) {
        audioPlayerInstance.playSound(Sounds.boo);
      }
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
