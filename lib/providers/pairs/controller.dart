import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/constants/countries.dart';
import 'package:pairs_game/models/country.dart';
import 'package:pairs_game/models/difficulty.dart';
import 'package:pairs_game/providers/pairs/state.dart';

class PairsController extends StateNotifier<PairsState> {
  final Ref ref;
  late AudioPlayer audioPlayer;
  PairsController(this.ref) : super(PairsState.initial()) {
    audioPlayer = AudioPlayer();
  }
  void updateDifficulty(Difficulty difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void shuffleGameCards() {
    state = PairsState.initial().copyWith(
      difficulty: state.difficulty,
    );
    List<dynamic> countriesCopy = [...countries];
    countriesCopy.shuffle();
    countriesCopy = countriesCopy
        .take(state.difficulty.pairsAmount)
        .map(
          (e) => Country.fromJson(e),
        )
        .toList();
    countriesCopy = [...countriesCopy, ...countriesCopy];
    countriesCopy.shuffle();
    state = state.copyWith(
      difficulty: state.difficulty,
      countriesInGame: countriesCopy.cast<Country>(),
    );
  }

  Future<void> selectCard(int index) async {
    // Check if the card is already discovered or selected
    if (state.discoveredIndexes.contains(index) ||
        state.selectedIndex == index ||
        state.selectedIndex2 == index) {
      return;
    }
    // If both indexes are selected, then wait until they get resetted or the game finish
    if (state.selectedIndex != null && state.selectedIndex2 != null) {
      return;
    }

    if (state.selectedIndex == null) {
      state = state.copyWith(selectedIndex: index);
    } else if (state.selectedIndex2 == null && state.selectedIndex != index) {
      state = state.copyWith(selectedIndex2: index);
      await compareCards();
    }
  }

  Future<void> compareCards() async {
    if (state.selectedIndex != null && state.selectedIndex2 != null) {
      state = state.copyWith(attempts: state.attempts + 1);
      final isEqualCard = state.countriesInGame[state.selectedIndex!].country ==
          state.countriesInGame[state.selectedIndex2!].country;
      if (isEqualCard) {
        Future.delayed(const Duration(seconds: 1), () async {
          addDiscoveredCard();
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          state = state.copyWithoutSelectedIndexes();
        });
      }
    }
  }

  void addDiscoveredCard() {
    state = state.copyWith(
      discoveredIndexes: [
        ...state.discoveredIndexes,
        state.selectedIndex!,
        state.selectedIndex2!
      ],
    ).copyWithoutSelectedIndexes();
  }

  void resetGame() {
    shuffleGameCards();
  }
}
