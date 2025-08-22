import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/constants/country_codes.dart';
import 'package:pairs_game/constants/sounds.dart';
import 'package:pairs_game/models/country.dart';
import 'package:pairs_game/models/difficulty.dart';
import 'package:pairs_game/providers/pairs/repository.dart';
import 'package:pairs_game/providers/pairs/state.dart';
import 'package:pairs_game/providers/scores/provider.dart';
import 'package:pairs_game/providers/timer/provider.dart';
import 'package:pairs_game/services/audio_player_service.dart';
import 'package:pairs_game/services/shared_preferences_provider.dart';

class PairsController extends StateNotifier<PairsState> {
  final Ref ref;
  late final SharedPreferencesProvider sharedPreferences;
  PairsController(this.ref) : super(PairsState.initial()) {
    sharedPreferences = ref.read(sharedPreferencesProvider);
  }

  void updateDifficulty(Difficulty difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void initializeAudioPlayer() {
    ref.read(audioPlayerService).initialize();
  }

  void disposeAudioPlayer() {
    ref.read(audioPlayerService).dispose();
  }

  /// Shuffles the game cards and fetches new countries based on the difficulty.
  ///
  /// Resets the game state and handles loading/error states for country fetching.
  Future<void> shuffleGameCards() async {
    // Reset to initial state, preserving difficulty
    state = PairsState.initial().copyWith(
      difficulty: state.difficulty,
    );

    // Shuffle the country codes and select a subset based on the difficulty
    List<String> countryCodesCopy = List.from(countryCodes);
    countryCodesCopy.shuffle();
    countryCodesCopy =
        countryCodesCopy.take(state.difficulty.pairsAmount).toList();

    try {
      state = state.copyWith(
        getCountriesStatus: RequestStatus.loading,
      );

      List<Country> countriesInGame = await ref
          .read(pairsRepositoryProvider)
          .fetchCountries(countryCodesCopy);

      // Duplicate the countries to create pairs
      countriesInGame = [...countriesInGame, ...countriesInGame];
      countriesInGame.shuffle();
      state = state.copyWith(
        countriesInGame: countriesInGame,
        getCountriesStatus: RequestStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        getCountriesStatus: RequestStatus.error,
      );
      if (kDebugMode) {
        print('Error fetching countries: $e');
      }
    }
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
      await _compareSelectedCards();
    }
  }

  Future<void> _compareSelectedCards() async {
    if (state.selectedIndex == null || state.selectedIndex2 == null) {
      return;
    }
    state = state.copyWith(attempts: state.attempts + 1);
    final areCardsMatched = state.countriesInGame[state.selectedIndex!].name ==
        state.countriesInGame[state.selectedIndex2!].name;

    if (areCardsMatched && await sharedPreferences.isPlayMusicEnabled()) {
      ref.read(audioPlayerService).playSound(Sounds.coinSuccess);
    }
    // Add a delay to allow the UI show both selected cards before checking for a match
    await Future.delayed(const Duration(seconds: 1));

    if (areCardsMatched) {
      await _addDiscoveredCards();
    } else {
      state = state.copyWithoutSelectedIndexes();
    }
  }

  /// Adds the currently selected cards to the list of discovered cards.
  ///
  /// Also resets the selected indexes after adding.
  Future<void> _addDiscoveredCards() async {
    if (state.selectedIndex == null || state.selectedIndex2 == null) {
      return;
    }
    state = state.copyWith(
      discoveredIndexes: [
        ...state.discoveredIndexes,
        state.selectedIndex!,
        state.selectedIndex2!
      ],
    ).copyWithoutSelectedIndexes();
    if (state.didUserWin) {
      if (await sharedPreferences.isPlayMusicEnabled()) {
        ref.read(audioPlayerService).playSound(Sounds.crowdCheers);
      }
      ref.read(timerProvider.notifier).stopTimer();
      ref.read(scoresProvider.notifier).saveScore();
    }
  }

  Future<void> resetGame() async {
    await shuffleGameCards();
  }

  void resetSelectedIndexes() {
    state = state.copyWithoutSelectedIndexes();
  }
}
