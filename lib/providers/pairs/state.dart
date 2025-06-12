import 'package:pairs_game/models/country.dart';
import 'package:pairs_game/models/difficulty.dart';

enum RequestStatus {
  initial,
  loading,
  success,
  error,
}

class PairsState {
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

  bool get didYouWin {
    return discoveredIndexes.length == countriesInGame.length &&
        discoveredIndexes.isNotEmpty;
  }

  bool get isEqualCard {
    if (selectedIndex == null || selectedIndex2 == null) return false;
    return countriesInGame[selectedIndex!].name ==
        countriesInGame[selectedIndex2!].name;
  }

// Calculates the score based on the next conditions:
// - The minimum expected number of attemps is difficulty.pairsAmount
// - The maximum expected number of attemps is difficulty.pairsAmount * 3
// - The less attempts the user made, the better the score.
// - There is maxDuration in the difficulty object like: difficulty.secondsDuration.
// - The minimum expected duration is equal to (difficulty.pairsAmount * 2.5)
// - The score goes from 0% to 100%.
// The duaration that the use spent playing can be calculated by the difference between maxDuration and the remainingSeconds.
// - The less time the user spent, the better the score.
// - The duration is going to be equivalent to .75 of the score.
// - The attempts are going to be equivalent to .25 of the score.
  int score(int remainingSeconds) {
    final minAttempts = difficulty.pairsAmount;
    final maxAttempts = difficulty.pairsAmount * 3;
    final minDuration = (difficulty.pairsAmount * 2.5).toInt();
    final maxDuration = difficulty.secondsDuration;

    final usedDuration = maxDuration - remainingSeconds;
    final durationScore =
        (1 - (usedDuration - minDuration) / (maxDuration - minDuration))
                .clamp(0, 1) *
            0.9;
    final attemptsScore =
        (1 - (attempts - minAttempts) / (maxAttempts - minAttempts))
                .clamp(0, 1) *
            0.1;

    return ((durationScore + attemptsScore) * 100).toInt();
  }

  PairsState.initial()
      : countriesInGame = [],
        difficulty = Difficulty.easy,
        selectedIndex = null,
        discoveredIndexes = [],
        attempts = 0,
        getCountriesStatus = RequestStatus.initial,
        selectedIndex2 = null;
}
