import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/constants/countries.dart';
import 'package:pairs_game/models/country.dart';
import 'package:pairs_game/models/difficulty.dart';
import 'package:pairs_game/providers/pairs/state.dart';

class PairsController extends StateNotifier<PairsState> {
  final Ref ref;
  PairsController(this.ref) : super(PairsState.initial());

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

  void selectCard(int index) {
    if (state.discoveredIndexes.contains(index) ||
        state.selectedIndex == index ||
        state.selectedIndex2 == index) {
      return;
    }
    if (state.selectedIndex != null && state.selectedIndex2 != null) {
      return;
    }
    if (state.selectedIndex == null) {
      state = state.copyWith(selectedIndex: index);
    } else if (state.selectedIndex2 == null && state.selectedIndex != index) {
      state = state.copyWith(selectedIndex2: index);
    }

    if (state.selectedIndex != null && state.selectedIndex2 != null) {
      if (state.countriesInGame[state.selectedIndex!].country ==
          state.countriesInGame[state.selectedIndex2!].country) {
        Future.delayed(const Duration(seconds: 1), () {
          state = state.copyWith(
            discoveredIndexes: [
              ...state.discoveredIndexes,
              state.selectedIndex!,
              state.selectedIndex2!
            ],
          );
          state = state.copyWithoutSelectedIndexes();
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          state = state.copyWithoutSelectedIndexes();
        });
      }
    }
  }
}
