import 'package:flutter/material.dart';
import 'package:pairs_game/constants/environment.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/pages/home/scores_page.dart';
import 'package:pairs_game/pages/home/welcome_game_page.dart';
import 'package:pairs_game/pages/home/leadeboard_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/providers/scores/provider.dart';

class HomeLayout extends ConsumerStatefulWidget {
  const HomeLayout({super.key});
  static const String routeName = '/home-layout';

  @override
  ConsumerState<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends ConsumerState<HomeLayout> {
  int _currentIndex = 0;

  List<Widget> get pages {
    final playerName = ref.watch(scoresProvider).playerName;
    return [
      WelcomeGamePage(),
      if (playerName == vipUsers) LeaderboardPage(),
      ScoresPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerName = ref.watch(scoresProvider).playerName;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.play_arrow),
            ),
            label: 'Play',
            backgroundColor: UIColors.black,
          ),
          if (playerName == vipUsers)
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.emoji_events),
              ),
              label: 'Leaderboard',
            ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.person),
            ),
            label: 'My Stats',
          ),
        ],
      ),
      body: pages[_currentIndex],
    );
  }
}
