import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/services/hive_db.dart';

class ScoresPage extends ConsumerWidget {
  const ScoresPage({super.key});
  static final String routeName = "/scores";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: UIColors.darkGray,
      appBar: AppBar(
        title: const Text("Scores",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: UIColors.black,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              ref.read(hiveServiceProvider).clearScores();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: ref.read(hiveServiceProvider).productBox.listenable(),
        builder: (context, box, widget) {
          final scores = box.values.toList();
          if (scores.isEmpty) {
            return const Center(
              child: Text(
                "No scores available",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return Builder(builder: (context) {
            // Sort the scores in descending order
            scores.sort((a, b) => a.score.compareTo(b.score));
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      color: UIColors.green,
                    ),
                itemCount: scores.length,
                itemBuilder: (context, index) {
                  final score = scores.reversed.toList()[index];
                  return ListTile(
                    leading: Text(
                      "#${index + 1}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(
                      score.playerName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Score: ${score.score}",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      score.difficulty,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                });
          });
        },
      ),
    );
  }
}
