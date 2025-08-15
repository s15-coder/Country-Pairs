import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/dialogs/custom_dialog.dart';
import 'package:pairs_game/components/dialogs/time_is_up_dialog.dart';
import 'package:pairs_game/components/dialogs/you_won_dialog.dart';
import 'package:pairs_game/components/home_pairs_content.dart';
import 'package:pairs_game/models/button_action.dart';
import 'package:pairs_game/providers/pairs/controller.dart';
import 'package:pairs_game/providers/pairs/provider.dart';
import 'package:pairs_game/providers/pairs/state.dart';
import 'package:pairs_game/providers/scores/provider.dart';
import 'package:pairs_game/providers/timer/controller.dart';
import 'package:pairs_game/providers/timer/provider.dart';
import 'package:pairs_game/providers/timer/state.dart';

class PairsGamePage extends ConsumerStatefulWidget {
  const PairsGamePage({super.key});

  static const String routeName = '/PairsGamePages';

  @override
  ConsumerState<PairsGamePage> createState() => _PairsGamePageState();
}

class _PairsGamePageState extends ConsumerState<PairsGamePage> {
  TimerController get _timerController => ref.read(timerProvider.notifier);
  PairsController get pairsController => ref.read(pairsProvider.notifier);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        initialize();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    pairsController.disposeAudioPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<PairsState>(pairsProvider, listenGameStatus);
    ref.listen<TimerState>(timerProvider, listenTimer);
    return HomePairsContent(
      onArrowBackPressed: () => onArrowBackPressed(context),
    );
  }

  Future initialize() async {
    pairsController.initializeAudioPlayer();
    await pairsController.shuffleGameCards();
    _timerController
      ..resetTimeForDifficulty()
      ..startTimer();
  }

  void listenGameStatus(
    PairsState? oldState,
    PairsState currentState,
  ) async {
    if (oldState?.didUserWin != currentState.didUserWin &&
        currentState.didUserWin) {
      showWinDialog(currentState);
      return;
    }
    if (oldState?.isEqualCard != currentState.isEqualCard &&
        currentState.isEqualCard) {
      onCardMatched(currentState);
    }
  }

  void listenTimer(TimerState? previous, TimerState current) {
    if (previous?.remainingSeconds != current.remainingSeconds &&
        current.remainingSeconds <= 0) {
      showTimeIsUpDialog();
      return;
    }
  }

  Future<void> onCardMatched(PairsState pairsState) async {
    final currentCard =
        pairsState.countriesInGame[pairsState.selectedIndex ?? 0];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${currentCard.name} ${currentCard.flagEmoji}'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void onArrowBackPressed(BuildContext context) {
    showExitDialog();
  }

  void showWinDialog(PairsState pairsState) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => YouWontDialog(
        score: ref.read(scoresProvider).score,
        onExit: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        onPlayAgain: () {
          Navigator.pop(context);
          pairsController.resetGame();
          _timerController
            ..resetTimeForDifficulty()
            ..startTimer();
        },
        state: pairsState,
        remainingSeconds: ref.read(timerProvider).remainingSeconds,
      ),
    );
  }

  void showTimeIsUpDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => TimeIsUpDialog(
        onExit: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        onPlayAgain: () {
          Navigator.pop(context);
          ref.read(pairsProvider.notifier).resetGame();
          _timerController
            ..resetTimeForDifficulty()
            ..startTimer();
        },
      ),
    );
  }

  void showExitDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => CustomDialog(
        actionLeft: ButtonAction(
          buttonStyle: ButtonStyleType.outline,
          text: 'Cancel',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actionRight: ButtonAction(
          buttonStyle: ButtonStyleType.material,
          text: 'Confirm',
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        text: 'Are you sure you want to exit the game?',
      ),
    );
  }
}
