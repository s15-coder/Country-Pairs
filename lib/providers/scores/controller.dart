import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/models/db/score.dart';
import 'package:pairs_game/providers/pairs/provider.dart';
import 'package:pairs_game/providers/scores/state.dart';
import 'package:pairs_game/services/hive_db.dart';

class ScoresController extends StateNotifier<ScoresState> {
  final Ref ref;
  ScoresController(this.ref) : super(ScoresState.initial());

  saveScore(int score) async {
    final hiveService = ref.read(hiveServiceProvider);
    final pairsProviderCtrl = ref.read(pairsProvider);
    final scoreObj = Score(
      playerName: state.playerName,
      score: score,
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
