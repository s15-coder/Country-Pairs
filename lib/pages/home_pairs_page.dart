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
  @override
  void initState() {
    final initialTime = ref
        .read(pairsProvider.select((state) => state.difficulty))
        .secondsDuration;
    _gameTimerController = GameTimerController(initialTime: initialTime);
    super.initState();
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
                onTimerTick: (remainingSeconds) {
                  ref
                      .read(pairsProvider.notifier)
                      .updateRemainingSeconds(remainingSeconds);
                },
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

  void onTimerEnd(BuildContext context, WidgetRef ref) {
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
