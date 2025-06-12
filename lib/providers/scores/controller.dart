import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/models/db/score.dart';
import 'package:pairs_game/providers/pairs/provider.dart';
import 'package:pairs_game/providers/scores/state.dart';
import 'package:pairs_game/providers/timer/provider.dart';
import 'package:pairs_game/services/hive_db.dart';

class ScoresController extends StateNotifier<ScoresState> {
  final Ref ref;
  ScoresController(this.ref) : super(ScoresState.initial());
// Calculates the score based on the next conditions:
// - The minimum expected number of attemps is difficulty.pairsAmount
// - The maximum expected number of attemps is difficulty.pairsAmount * 3
// - The less attempts the user made, the better the score.
// - There is maxDuration in the difficulty object like: difficulty.secondsDuration.
// - The minimum expected duration in seconds is equal to (difficulty.pairsAmount * 2.5)
// - The score goes from 0% to 100%.
// The duaration that the use spent playing can be calculated by the difference between maxDuration and the remainingSeconds.
// - The less time the user spent, the better the score.
// - The duration is going to be equivalent to .75 of the score.
// - The attempts are going to be equivalent to .25 of the score.
  void calculateScore() {
    final pairsState = ref.read(pairsProvider);
    final difficulty = pairsState.difficulty;
    final remainingSeconds = ref.read(timerProvider).remainingSeconds;
    final minAttempts = difficulty.pairsAmount;
    final maxAttempts = difficulty.pairsAmount * 3;
    final minDuration = (difficulty.pairsAmount * 2.5).toInt();
    final maxDuration = difficulty.secondsDuration;

    final usedDuration = maxDuration - remainingSeconds;
    final durationScore =
        (1 - (usedDuration - minDuration) / (maxDuration - minDuration))
                .clamp(0, 1) *
            0.75;
    final attemptsScore =
        (1 - (pairsState.attempts - minAttempts) / (maxAttempts - minAttempts))
                .clamp(0, 1) *
            0.25;

    final calculatedScore = ((durationScore + attemptsScore) * 100).toInt();
    state = state.copyWith(score: calculatedScore);
  }

  saveScore() async {
    calculateScore();
    final hiveService = ref.read(hiveServiceProvider);
    final pairsProviderCtrl = ref.read(pairsProvider);
    final scoreObj = Score(
      playerName: state.playerName,
      score: state.score,
      date: DateTime.now().toString(),
      difficulty: pairsProviderCtrl.difficulty.label,
      modality: "FLAG_MATCH",
    );
    await hiveService.addScore(scoreObj);
  }

  void setPlayerName(String name) {
    state = state.copyWith(playerName: name);
  }

  void setFilter(String filter) {
    state = state.copyWith(filter: filter);
  }
}
