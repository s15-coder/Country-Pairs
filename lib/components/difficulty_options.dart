import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/welcome_button.dart';
import 'package:pairs_game/models/difficulty.dart';
import 'package:pairs_game/providers/pairs/provider.dart';

class DifficultyOptions extends ConsumerWidget {
  const DifficultyOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pairsProviderController = ref.read(pairsProvider.notifier);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WelcomeButton(
          color: Colors.white,
          onPressed: () {
            pairsProviderController.selectDifficulty(Difficulty.easy);
            Navigator.pop(context);
          },
          text: "Easy",
        ),
        WelcomeButton(
          color: Colors.white,
          onPressed: () {
            pairsProviderController.selectDifficulty(Difficulty.medium);
            Navigator.pop(context);
          },
          text: 'Medium',
        ),
        WelcomeButton(
          color: Colors.white,
          onPressed: () {
            pairsProviderController.selectDifficulty(Difficulty.hard);
            Navigator.pop(context);
          },
          text: 'Hard',
        ),
        WelcomeButton(
          color: Colors.white,
          onPressed: () {
            pairsProviderController.selectDifficulty(Difficulty.expert);
            Navigator.pop(context);
          },
          text: 'Extreme',
        )
      ],
    );
  }
}
