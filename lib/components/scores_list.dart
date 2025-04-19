import 'package:flutter/material.dart';
import 'package:pairs_game/components/score_tile.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/models/db/score.dart';

class ScoresList extends StatelessWidget {
  const ScoresList({
    required this.scores,
    super.key,
  });
  final List<Score> scores;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: UIColors.green,
      ),
      itemCount: scores.length,
      itemBuilder: (context, index) {
        final score = scores[index];
        return ScoreTile(
          index: index,
          score: score,
        );
      },
    );
  }
}
