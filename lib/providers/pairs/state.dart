import 'package:pairs_game/models/country.dart';
import 'package:pairs_game/models/difficulty.dart';

class PairsState {
  final List<Country> countriesInGame;
  final List<int> discoveredIndexes;
  final Difficulty difficulty;
  final int? selectedIndex;
  final int? selectedIndex2;
  final int attempts;
  final int remainingSeconds;

  const PairsState({
    required this.countriesInGame,
    required this.difficulty,
    required this.selectedIndex,
    required this.selectedIndex2,
    required this.discoveredIndexes,
    this.attempts = 0,
    this.remainingSeconds = 0,
  });
  PairsState copyWith({
    List<Country>? countriesInGame,
    Difficulty? difficulty,
    int? selectedIndex,
    int? selectedIndex2,
    List<int>? discoveredIndexes,
    int? attempts,
    int? remainingSeconds,
  }) {
    return PairsState(
      countriesInGame: countriesInGame ?? this.countriesInGame,
      difficulty: difficulty ?? this.difficulty,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedIndex2: selectedIndex2 ?? this.selectedIndex2,
      discoveredIndexes: discoveredIndexes ?? this.discoveredIndexes,
      attempts: attempts ?? this.attempts,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }

  PairsState copyWithoutSelectedIndexes() {
    return PairsState(
      countriesInGame: countriesInGame,
      difficulty: difficulty,
      selectedIndex: null,
      selectedIndex2: null,
      attempts: attempts,
      discoveredIndexes: discoveredIndexes,
      remainingSeconds: remainingSeconds,
    );
  }

  PairsState.initial()
      : countriesInGame = [],
        difficulty = Difficulty.easy,
        selectedIndex = null,
        discoveredIndexes = [],
        attempts = 0,
        remainingSeconds = 0,
        selectedIndex2 = null;
}
