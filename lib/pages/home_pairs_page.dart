import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/dialogs/custom_dialog.dart';
import 'package:pairs_game/components/dialogs/time_is_up_dialog.dart';
import 'package:pairs_game/components/dialogs/you_won_dialog.dart';
import 'package:pairs_game/components/game_timer.dart';
import 'package:pairs_game/components/home_bottom_navigator.dart';
import 'package:pairs_game/components/pairs_grid.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/models/button_action.dart';
import 'package:pairs_game/models/difficulty.dart';
import 'package:pairs_game/providers/pairs/provider.dart';
import 'package:pairs_game/providers/pairs/state.dart';
import 'package:pairs_game/providers/scores/provider.dart';
import 'package:pairs_game/utils/timer_controller.dart';

class HomePairsPage extends ConsumerStatefulWidget {
  const HomePairsPage({super.key});

  static const String routeName = '/homePairsPages';

  @override
  ConsumerState<HomePairsPage> createState() => _HomePairsPageState();
}

class _HomePairsPageState extends ConsumerState<HomePairsPage> {
  late TimerController _timerController;
  late AudioPlayer audioPlayer;
  int remainingSeconds = 0;
  @override
  void initState() {
    audioPlayer = AudioPlayer();
    initializeGameTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timerController.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<PairsState>(
      pairsProvider,
      listenWhenGameIsFinished,
    );
    final Difficulty difficulty =
        ref.watch(pairsProvider.select((state) => state.difficulty));
  return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          bottomNavigationBar: HomeBottomNavigator(),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => onArrowBackPressed(context),
            ),
            title: Text(
              difficulty.label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: UIColors.black,
            actions: [
              GameTimer(
                controller: _timerController,
                onTimerEnd: () => onTimerEnd(context, ref),
                onTimerTick: (remainingTime) {
                  remainingSeconds = remainingTime;
                },
              ),
            ],
          ),
          backgroundColor: UIColors.darkGray,
          body: Center(child: PairsGrid()),
        ),
      ),
    );
  }

  void initializeGameTimer() {
    final initialTime = ref
        .read(pairsProvider.select((state) => state.difficulty))
        .secondsDuration;
    _timerController = TimerController(initialTime: initialTime);
  }

  void listenWhenGameIsFinished(
    PairsState? oldState,
    PairsState currentState,
  ) async {
    final didUserWin = oldState?.didYouWin != currentState.didYouWin;

    if (didUserWin) {
      playerWon(currentState);
      return;
    }
    if (oldState?.isEqualCard != currentState.isEqualCard &&
        currentState.isEqualCard) {
      onCardMatched(currentState);
    }
  }

  Future<void> onCardMatched(PairsState pairsState) async {
    final currentCard =
        pairsState.countriesInGame[pairsState.selectedIndex ?? 0];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${currentCard.name} ${currentCard.flagEmoji}'),
        duration: Duration(seconds: 2),
      ),
    );
    await audioPlayer.play(AssetSource("sound/success.mp3"));
  }

  Future<void> playerWon(PairsState pairsState) async {
    _timerController.stop();
    final score = pairsState.score(remainingSeconds);
    ref.read(scoresControllerProvider.notifier).saveScore(score);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return YouWontDialog(
          score: score,
          onExit: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          onPlayAgain: () {
            Navigator.pop(context);
            ref.read(pairsProvider.notifier).resetGame();
            _timerController.setTime(pairsState.difficulty.secondsDuration);
            _timerController.start();
          },
          state: pairsState,
          remainingSeconds: remainingSeconds,
        );
      },
    );
    await audioPlayer.play(AssetSource("sound/crowd-cheers.mp3"));
  }

  void onTimerEnd(BuildContext context, WidgetRef ref) {
    audioPlayer.play(AssetSource("sound/boo.mp3"));

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
            _timerController.setTime(ref
                .read(pairsProvider.select((state) => state.difficulty))
                .secondsDuration);
            _timerController.start();
          },
        );
      },
    );
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
