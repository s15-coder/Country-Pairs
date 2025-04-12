import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/difficulty_options.dart';
import 'package:pairs_game/components/welcome_button.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/pages/home_pairs_page.dart';
import 'package:pairs_game/providers/pairs/provider.dart';

class WelcomeGamePage extends ConsumerWidget {
  const WelcomeGamePage({super.key});
  static const String routeName = '/welcomeGamePage';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficulty = ref.watch(pairsProvider.select((e) => e.difficulty));
    return Scaffold(
      backgroundColor: UIColors.darkGray,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/app/world_icon.png",
                width: 200,
              ),
              const SizedBox(height: 20),
              WelcomeButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    HomePairsPage.routeName,
                  );
                },
                text: "Start Game",
              ),
              WelcomeButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: UIColors.darkGray,
                    context: context,
                    builder: (context) {
                      return const DifficultyOptions();
                    },
                  );
                },
                text: "Difficulty: ${difficulty.label} ",
              ),
              WelcomeButton(
                onPressed: () {},
                text: "Scores",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
