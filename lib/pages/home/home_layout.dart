import 'package:flutter/material.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/pages/home/scores_page.dart';
import 'package:pairs_game/pages/home/welcome_game_page.dart';
import 'package:pairs_game/pages/home/leadeboard_page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  static const String routeName = '/home-layout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    WelcomeGamePage(),
    LeaderboardPage(),
    ScoresPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: UIColors.green,
        backgroundColor: UIColors.black,
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
      backgroundColor: UIColors.darkGray,
      body: _pages[_currentIndex],
    );
  }
}
