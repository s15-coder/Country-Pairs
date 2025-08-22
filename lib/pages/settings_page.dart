import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/providers/theme/provider.dart';
import 'package:pairs_game/services/shared_preferences_provider.dart';
import 'package:pairs_game/style/theme/dark_theme.dart';

class SettingsPage extends ConsumerStatefulWidget {
  static const String routeName = '/settings';
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  void _onThemeChanged() {
    ref.read(themeProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.nightlight_round,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Dark Theme',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Switch(
                  activeThumbColor: Theme.of(context).primaryColor,
                  value: themeData == darkTheme,
                  onChanged: (_) {
                    _onThemeChanged();
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.volume_up,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Sounds',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                FutureBuilder<bool>(
                    future: ref
                        .read(sharedPreferencesProvider)
                        .isPlayMusicEnabled(),
                    builder: (context, snapshot) {
                      return Switch(
                        activeThumbColor: Theme.of(context).primaryColor,
                        value: snapshot.data ?? true,
                        onChanged: (value) {
                          ref
                              .read(sharedPreferencesProvider)
                              .setPlayMusicEnabled(value);
                          setState(() {});
                        },
                      );
                    }),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
