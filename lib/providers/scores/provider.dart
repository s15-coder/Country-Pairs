import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/providers/scores/controller.dart';
import 'package:pairs_game/providers/scores/state.dart';

final scoresProvider =
    StateNotifierProvider<ScoresController, ScoresState>((ref) {
  return ScoresController(ref);
});
