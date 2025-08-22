import 'package:flutter/material.dart';
import 'package:pairs_game/models/db/score.dart';

class ScoreTile extends StatelessWidget {
  const ScoreTile({required this.index, required this.score, super.key});
  final int index;
  final Score score;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("#${index + 1}",
          style: Theme.of(context).textTheme.displaySmall),
      title: Text(
        score.playerName,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(
        "Score: ${score.score}",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      trailing: Text(
        score.difficulty,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
