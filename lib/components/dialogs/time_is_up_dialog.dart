import 'package:flutter/material.dart';
import 'package:pairs_game/components/dialogs/custom_dialog.dart';
import 'package:pairs_game/models/button_action.dart';

class TimeIsUpDialog extends StatelessWidget {
  const TimeIsUpDialog({
    super.key,
    required this.onExit,
    required this.onPlayAgain,
  });
  final VoidCallback onExit;
  final VoidCallback onPlayAgain;

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
        text: 'Try again',
        onPressed: onPlayAgain,
      ),
      text: 'Time is up!',
    );
  }
}
