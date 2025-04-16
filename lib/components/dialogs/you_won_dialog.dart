import 'package:flutter/material.dart';
import 'package:pairs_game/components/dialogs/custom_dialog.dart';
import 'package:pairs_game/models/button_action.dart';
import 'package:pairs_game/providers/pairs/state.dart';

class YouWontDialog extends StatelessWidget {
  const YouWontDialog({
    super.key,
    required this.onExit,
    required this.onPlayAgain,
    required this.state,
    required this.remainingSeconds,
    required this.score,
  });
  final VoidCallback onExit;
  final VoidCallback onPlayAgain;
  final PairsState state;
  final int score;
  final int remainingSeconds;
  final titleStyle = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      actionLeft: ButtonAction(
        buttonStyle: ButtonStyleType.outline,
        text: 'Exit',
        onPressed: onExit,
      ),
      actionRight: ButtonAction(
        buttonStyle: ButtonStyleType.material,
        text: 'Play again',
        onPressed: onPlayAgain,
      ),
      child: Column(
        children: [
          Text(
            'You won! ',
            style: titleStyle.copyWith(),
            textAlign: TextAlign.center,
          ),
          Divider(
            color: Colors.white,
          ),
          Text(
            'Attempts: ${state.attempts}\n'
            'Time: ${state.difficulty.secondsDuration - remainingSeconds} left\n'
            'Score: $score%',
            style: titleStyle,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
