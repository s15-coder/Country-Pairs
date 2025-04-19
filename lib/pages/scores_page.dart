import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pairs_game/components/dialogs/custom_dialog.dart';
import 'package:pairs_game/components/score_menu_button.dart';
import 'package:pairs_game/components/scores_list.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/models/button_action.dart';
import 'package:pairs_game/providers/scores/provider.dart';
import 'package:pairs_game/services/hive_db.dart';

class ScoresPage extends ConsumerWidget {
  const ScoresPage({super.key});
  static final String routeName = "/scores";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoresState = ref.watch(scoresControllerProvider);
    return Scaffold(
      backgroundColor: UIColors.darkGray,
      appBar: AppBar(
        title: const Text(
          "Scores",
          style: TextStyle(
            color: Color.fromARGB(255, 252, 239, 239),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: UIColors.black,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            )),
        actions: [
          ScoreMenuButton(
            currentFilter: scoresState.filter,
            onMenuItemSelected: (String value) {
              ref.read(scoresControllerProvider.notifier).setFilter(value);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    text:
                        "Are you sure you want to remove all the scores? This action cannot be undone.",
                    actionRight: ButtonAction(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        ref.read(hiveServiceProvider).clearScores();
                      },
                      text: 'Delete',
                      buttonStyle: ButtonStyleType.material,
                    ),
                    actionLeft: ButtonAction(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      text: 'Cancel',
                      buttonStyle: ButtonStyleType.outline,
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: ref.read(hiveServiceProvider).productBox.listenable(),
        builder: (context, box, widget) {
          final scores = box.values
              .where((score) =>
                  (score.difficulty == scoresState.filter) ||
                  scoresState.filter == "All")
              .toList();

          if (scores.isEmpty) {
            return const Center(
              child: Text(
                "No scores available",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          scores.sort((a, b) => b.score.compareTo(a.score));

          return ScoresList(scores: scores);
        },
      ),
    );
  }
}
