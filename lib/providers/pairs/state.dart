import 'package:pairs_game/models/country.dart';
import 'package:pairs_game/models/difficulty.dart';

class PairsState {
  final List<Country> countriesInGame;
  final List<int> discoveredIndexes;
  final Difficulty difficulty;
  final int? selectedIndex;
  final int? selectedIndex2;
  final int attempts;

  const PairsState({
    required this.countriesInGame,
    required this.difficulty,
    required this.selectedIndex,
    required this.selectedIndex2,
    required this.discoveredIndexes,
    this.attempts = 0,
  });
  PairsState copyWith({
    List<Country>? countriesInGame,
    Difficulty? difficulty,
    int? selectedIndex,
    int? selectedIndex2,
    List<int>? discoveredIndexes,
    int? attempts,
  }) {
    return PairsState(
      countriesInGame: countriesInGame ?? this.countriesInGame,
      difficulty: difficulty ?? this.difficulty,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedIndex2: selectedIndex2 ?? this.selectedIndex2,
      discoveredIndexes: discoveredIndexes ?? this.discoveredIndexes,
      attempts: attempts ?? this.attempts,
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
    );
  }

  bool get isGameFinished {
    return discoveredIndexes.length == countriesInGame.length &&
        discoveredIndexes.isNotEmpty;
  }

  bool get isEqualCard {
    if (selectedIndex == null || selectedIndex2 == null) return false;
    return countriesInGame[selectedIndex!].country ==
        countriesInGame[selectedIndex2!].country;
  }

  int score(int remainingSeconds) {
    final maxSeconds = difficulty.secondsDuration;

    if (attempts == 0 || maxSeconds == 0) return 0;

    final timeFactor = (remainingSeconds / maxSeconds).clamp(0, 1);
    final attemptFactor = (1 / attempts).clamp(0, 1);

    final finalScore = (timeFactor * 0.5 + attemptFactor * 0.5) * 100;
    return finalScore.round();
  }

  PairsState.initial()
      : countriesInGame = [],
        difficulty = Difficulty.easy,
        selectedIndex = null,
        discoveredIndexes = [],
        attempts = 0,
        selectedIndex2 = null;
}
