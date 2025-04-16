import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/dialogs/custom_dialog.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/models/button_action.dart';
import 'package:pairs_game/pages/home_pairs_page.dart';
import 'package:pairs_game/providers/pairs/provider.dart';

class HomeBottomNavigator extends ConsumerWidget {
  const HomeBottomNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attempts = ref.watch(pairsProvider.select((state) => state.attempts));
    return BottomNavigationBar(
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      backgroundColor: UIColors.black,
      items: [
        BottomNavigationBarItem(
          icon: Text(
            attempts.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          label: 'Attempts',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                showDialog(
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
                            ref.read(pairsProvider.notifier).resetGame();
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                              context,
                              HomePairsPage.routeName,
                            );
                          },
                        ),
                        text: 'Are you sure you want to restart the game?',
                      );
                    });
              },
              icon: Icon(Icons.restart_alt)),
          label: 'Restart',
        ),
      ],
    );
  }
}
