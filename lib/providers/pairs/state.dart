import 'package:pairs_game/models/country.dart';
import 'package:pairs_game/models/difficulty.dart';

class PairsState {
  final List<Country> countriesInGame;
  final List<int> discoveredIndexes;
  final Difficulty difficulty;
  final int? selectedIndex;
  final int? selectedIndex2;
  const PairsState({
    required this.countriesInGame,
    required this.difficulty,
    required this.selectedIndex,
    required this.selectedIndex2,
    required this.discoveredIndexes,
  });
  PairsState copyWith({
    List<Country>? countriesInGame,
    Difficulty? difficulty,
    int? selectedIndex,
    int? selectedIndex2,
    List<int>? discoveredIndexes,
  }) {
    return PairsState(
      countriesInGame: countriesInGame ?? this.countriesInGame,
      difficulty: difficulty ?? this.difficulty,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedIndex2: selectedIndex2 ?? this.selectedIndex2,
      discoveredIndexes: discoveredIndexes ?? this.discoveredIndexes,
    );
  }

  PairsState copyWithoutSelectedIndexes() {
    return PairsState(
      countriesInGame: countriesInGame,
      difficulty: difficulty,
      selectedIndex: null,
      selectedIndex2: null,
      discoveredIndexes: discoveredIndexes,
    );
  }

  PairsState.initial()
      : countriesInGame = [],
        difficulty = Difficulty.easy,
        selectedIndex = null,
        discoveredIndexes = [],
        selectedIndex2 = null;
}
