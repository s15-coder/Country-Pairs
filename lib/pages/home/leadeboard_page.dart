import 'package:flutter/material.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/helpers/date_formatter.dart';
import 'package:pairs_game/models/db/score.dart';
import 'package:pairs_game/models/difficulty.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/providers/scores/provider.dart';

class LeaderboardPage extends ConsumerStatefulWidget {
  static const String routeName = '/leaderboardPage';
  const LeaderboardPage({super.key});

  @override
  ConsumerState<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends ConsumerState<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: Difficulty.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Difficulty.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Leaderboard',
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: UIColors.green,
            tabs: [
              for (final diff in Difficulty.values) Tab(text: diff.label),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            for (final diff in Difficulty.values)
              LeaderboardTab(difficultyLabel: diff.label),
          ],
        ),
      ),
    );
  }
}

class LeaderboardTab extends ConsumerWidget {
  final String difficultyLabel;

  const LeaderboardTab({super.key, required this.difficultyLabel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Score>>(
      future: ref.read(scoresProvider.notifier).getTopScores(difficultyLabel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final scores = snapshot.data ?? [];
        if (scores.isEmpty) {
          return Center(
            child: Text(
              'No scores yet.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        return ListView.builder(
          itemCount: scores.length,
          itemBuilder: (context, index) {
            return ScoreListTile(
              index: index,
              score: scores[index],
            );
          },
        );
      },
    );
  }
}

class ScoreListTile extends StatelessWidget {
  final int index;
  final Score score;

  const ScoreListTile({super.key, required this.index, required this.score});

  Color _getRankColor(int rank) {
    switch (rank) {
      case 0:
        return Colors.amber.shade400;
      case 1:
        return Colors.grey.shade400;
      case 2:
        return Colors.brown.shade400;
      default:
        return UIColors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rankColor = _getRankColor(index);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: rankColor,
            child: Text(
              '#${index + 1}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            score.playerName,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
          ),
          subtitle: Text(
            formatDate(score.date),
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: UIColors.green.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              score.score.toString(),
              style: const TextStyle(
                color: UIColors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
