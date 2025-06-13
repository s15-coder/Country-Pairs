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
            pairsProviderController.updateDifficulty(Difficulty.easy);
            Navigator.pop(context);
          },
          text: Difficulty.easy.label,
        ),
        WelcomeButton(
          color: Colors.white,
          onPressed: () {
            pairsProviderController.updateDifficulty(Difficulty.medium);
            Navigator.pop(context);
          },
          text: Difficulty.medium.label,
        ),
        WelcomeButton(
          color: Colors.white,
          onPressed: () {
            pairsProviderController.updateDifficulty(Difficulty.hard);
            Navigator.pop(context);
          },
          text: Difficulty.hard.label,
        ),
        WelcomeButton(
          color: Colors.white,
          onPressed: () {
            pairsProviderController.updateDifficulty(Difficulty.expert);
            Navigator.pop(context);
          },
          text: Difficulty.expert.label,
        )
      ],
    );
  }
}
