import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/providers/pairs/controller.dart';
import 'package:pairs_game/providers/pairs/state.dart';

final pairsProvider = StateNotifierProvider<PairsController, PairsState>((ref) {
  return PairsController(ref);
});
