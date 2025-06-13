import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/dialogs/custom_dialog.dart';
import 'package:pairs_game/components/dialogs/time_is_up_dialog.dart';
import 'package:pairs_game/components/dialogs/you_won_dialog.dart';
import 'package:pairs_game/components/home_pairs_content.dart';
import 'package:pairs_game/constants/sounds.dart';
import 'package:pairs_game/models/button_action.dart';
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
  late AudioPlayer audioPlayer;

  TimerController get _timerController => ref.read(timerProvider.notifier);

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        initializeTimer();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
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

  void initializeTimer() {
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
      playerWon(currentState);
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
      timeIsUp();
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
    await audioPlayer.play(AssetSource(Sounds.coinSuccess));
  }

  Future<void> playerWon(PairsState pairsState) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return YouWontDialog(
          score: ref.read(scoresProvider).score,
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
          state: pairsState,
          remainingSeconds: ref.read(timerProvider).remainingSeconds,
        );
      },
    );
    await audioPlayer.play(AssetSource(Sounds.crowdCheers));
  }

  Future<void> timeIsUp() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return TimeIsUpDialog(
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
        );
      },
    );
    await audioPlayer.play(AssetSource(Sounds.boo));
  }

  void onArrowBackPressed(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return CustomDialog(
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
        );
      },
    );
  }
}
