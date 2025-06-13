import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/pages/layout/home_layout.dart';
import 'package:pairs_game/pages/pairs_game_page.dart';
import 'package:pairs_game/services/hive_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        HomeLayout.routeName: (context) => const HomeLayout(),
        PairsGamePage.routeName: (context) => const PairsGamePage(),
      },
      initialRoute: HomeLayout.routeName,
    );
  }
}
