import 'package:flutter/material.dart';
import 'package:pairs_game/models/db/score.dart';

class ScoreTile extends StatelessWidget {
  const ScoreTile({
    required this.index,
    required this.score,
    super.key
  });
  final int index;
  final Score score;
  @override
  Widget build(BuildContext context) {
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
  }
}
