import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/pages/home_pairs_page.dart';
import 'package:pairs_game/pages/scores_page.dart';
import 'package:pairs_game/pages/welcome_game_page.dart';
import 'package:pairs_game/services/hive_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDBService().initializeHive();
  runApp(ProviderScope(child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        WelcomeGamePage.routeName: (context) => const WelcomeGamePage(),
        HomePairsPage.routeName: (context) => const HomePairsPage(),
        ScoresPage.routeName: (context) => const ScoresPage(),
      },
      initialRoute: WelcomeGamePage.routeName,
    );
  }
}
