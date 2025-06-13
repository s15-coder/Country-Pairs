import 'package:equatable/equatable.dart';
import 'package:pairs_game/models/country.dart';
import 'package:pairs_game/models/difficulty.dart';

enum RequestStatus {
  initial,
  loading,
  success,
  error,
}

class PairsState extends Equatable {
  final RequestStatus getCountriesStatus;
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
    this.getCountriesStatus = RequestStatus.initial,
  });
  PairsState copyWith({
    List<Country>? countriesInGame,
    Difficulty? difficulty,
    int? selectedIndex,
    int? selectedIndex2,
    List<int>? discoveredIndexes,
    int? attempts,
    RequestStatus? getCountriesStatus,
  }) {
    return PairsState(
      countriesInGame: countriesInGame ?? this.countriesInGame,
      difficulty: difficulty ?? this.difficulty,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedIndex2: selectedIndex2 ?? this.selectedIndex2,
      discoveredIndexes: discoveredIndexes ?? this.discoveredIndexes,
      attempts: attempts ?? this.attempts,
      getCountriesStatus: getCountriesStatus ?? this.getCountriesStatus,
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
      getCountriesStatus: getCountriesStatus,
    );
  }

  bool get didUserWin {
    return discoveredIndexes.length == countriesInGame.length &&
        discoveredIndexes.isNotEmpty;
  }

  bool get isEqualCard {
    if (selectedIndex == null || selectedIndex2 == null) return false;
    return countriesInGame[selectedIndex!].name ==
        countriesInGame[selectedIndex2!].name;
  }

  PairsState.initial()
      : countriesInGame = [],
        difficulty = Difficulty.easy,
        selectedIndex = null,
        discoveredIndexes = [],
        attempts = 0,
        getCountriesStatus = RequestStatus.initial,
        selectedIndex2 = null;

  @override
  List<Object?> get props => [
        countriesInGame,
        difficulty,
        selectedIndex,
        selectedIndex2,
        discoveredIndexes,
        attempts,
        getCountriesStatus,
      ];
}
