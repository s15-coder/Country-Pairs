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
    selectDifficulty(state.difficulty);
  }

  void selectDifficulty(Difficulty difficulty) {
    state = PairsState.initial();
    List<dynamic> countriesCopy = [...countries];
    countriesCopy.shuffle();
    countriesCopy = countriesCopy
        .take(difficulty.cardsAmount)
        .map(
          (e) => Country.fromJson(e),
        )
        .toList();
    countriesCopy = [...countriesCopy, ...countriesCopy];
    countriesCopy.shuffle();
    state = state.copyWith(
      difficulty: difficulty,
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
    // If both indexes are selected, then wait until they get resetted
    if (state.selectedIndex != null && state.selectedIndex2 != null) {
      return;
    }

    if (state.selectedIndex == null) {
      state = state.copyWith(selectedIndex: index);
    } else if (state.selectedIndex2 == null && state.selectedIndex != index) {
      state = state.copyWith(selectedIndex2: index);
    }

    if (state.selectedIndex != null && state.selectedIndex2 != null) {
      state = state.copyWith(attempts: state.attempts + 1);
      if (state.countriesInGame[state.selectedIndex!].country ==
          state.countriesInGame[state.selectedIndex2!].country) {
        await audioPlayer.play(AssetSource("sound/success.mp3"));
        Future.delayed(const Duration(seconds: 1), () {
          state = state.copyWith(
            discoveredIndexes: [
              ...state.discoveredIndexes,
              state.selectedIndex!,
              state.selectedIndex2!
            ],
          ).copyWithoutSelectedIndexes();
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          state = state.copyWithoutSelectedIndexes();
        });
      }
    }
  }

  void updateRemainingSeconds(int seconds) {
    state = state.copyWith(remainingSeconds: seconds);
  }

  void resetGame() {
    final oldDifficulty = state.difficulty;
    selectDifficulty(oldDifficulty);
  }

  int calculateScore() {
    final maxSeconds = state.difficulty.secondsDuration;
    final remainingSeconds = state.remainingSeconds;
    final attempts = state.attempts;

    if (attempts == 0 || maxSeconds == 0) return 0;

    final timeFactor = (remainingSeconds / maxSeconds).clamp(0, 1);
    final attemptFactor = (1 / attempts).clamp(0, 1);

    final score = (timeFactor * 0.5 + attemptFactor * 0.5) * 100;
    return score.round();
  }
}
