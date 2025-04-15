import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/custom_dialog.dart';
import 'package:pairs_game/components/game_timer.dart';
import 'package:pairs_game/components/home_bottom_navigator.dart';
import 'package:pairs_game/components/pairs_grid.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/models/button_action.dart';
import 'package:pairs_game/models/difficulty.dart';
import 'package:pairs_game/providers/pairs/provider.dart';

class HomePairsPage extends ConsumerStatefulWidget {
  const HomePairsPage({super.key});

  static const String routeName = '/homePairsPages';

  @override
  ConsumerState<HomePairsPage> createState() => _HomePairsPageState();
}

class _HomePairsPageState extends ConsumerState<HomePairsPage> {
  late GameTimerController _gameTimerController;
  late AudioPlayer audioPlayer;
  @override
  void initState() {
    audioPlayer = AudioPlayer();
    initializeGameTimer();
    listenWhenGameIsFinished();
    super.initState();
  }

  @override
  void dispose() {
    _gameTimerController.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _gameTimerController,
                onTimerEnd: () => onTimerEnd(context, ref),
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
    _gameTimerController = GameTimerController(initialTime: initialTime);
  }

  void listenWhenGameIsFinished() {
    ref.read(pairsProvider.notifier).addListener((state) async {
      if (state.isGameFinished) {
        _gameTimerController.stop();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return CustomDialog(
              actionLeft: ButtonAction(
                buttonStyle: ButtonStyleType.outline,
                text: 'Exit',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              actionRight: ButtonAction(
                buttonStyle: ButtonStyleType.material,
                text: 'Play again',
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(pairsProvider.notifier).resetGame();
                  _gameTimerController
                      .setTime(state.difficulty.secondsDuration);
                  _gameTimerController.start();
                },
              ),
              text: 'You won! \n'
                  'You made ${state.attempts} attempts in ${state.difficulty.label} mode.',
            );
          },
        );
        await audioPlayer.play(AssetSource("sound/crowd-cheers.mp3"));
      }
      if (state.isEqualCard) {
        await audioPlayer.play(AssetSource("sound/success.mp3"));
      }
    });
  }

  void onTimerEnd(BuildContext context, WidgetRef ref) {
    audioPlayer.play(AssetSource("sound/boo.mp3"));

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return CustomDialog(
            actionLeft: ButtonAction(
              buttonStyle: ButtonStyleType.outline,
              text: 'Exit',
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            actionRight: ButtonAction(
              buttonStyle: ButtonStyleType.material,
              text: 'Try again',
              onPressed: () {
                Navigator.pop(context);
                ref.read(pairsProvider.notifier).resetGame();
                final state = ref.read(pairsProvider);
                _gameTimerController.setTime(state.difficulty.secondsDuration);
                _gameTimerController.start();
              },
            ),
            text: 'Time is up!',
          );
        });
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
