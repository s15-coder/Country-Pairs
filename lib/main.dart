import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/pages/home/home_layout.dart';
import 'package:pairs_game/pages/pairs_game_page.dart';
import 'package:pairs_game/pages/settings_page.dart';
import 'package:pairs_game/providers/theme/provider.dart';
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

class App extends ConsumerWidget {
  const App({super.key});
  static const bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: themeData,
      routes: {
        HomeLayout.routeName: (context) => const HomeLayout(),
        PairsGamePage.routeName: (context) => const PairsGamePage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
      },
      initialRoute: HomeLayout.routeName,
    );
  }
}
