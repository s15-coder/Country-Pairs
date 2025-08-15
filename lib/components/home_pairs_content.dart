import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/game_timer.dart';
import 'package:pairs_game/components/home_bottom_navigator.dart';
import 'package:pairs_game/components/pairs_grid.dart';
import 'package:pairs_game/models/difficulty.dart';
import 'package:pairs_game/providers/pairs/provider.dart';

class HomePairsContent extends ConsumerWidget {
  final VoidCallback onArrowBackPressed;

  const HomePairsContent({
    super.key,
    required this.onArrowBackPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ),
              onPressed: () => onArrowBackPressed(),
            ),
            title: Text(
              difficulty.label,
            ),
            centerTitle: true,
            actions: [
              GameTimer(),
            ],
          ),
          body: Center(child: PairsGrid()),
        ),
      ),
    );
  }
}
