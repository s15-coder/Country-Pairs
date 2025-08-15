import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/providers/theme/provider.dart';
import 'package:pairs_game/style/theme/dark_theme.dart';

class SettingsPage extends ConsumerStatefulWidget {
  static const String routeName = '/settings';
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late String networkUrl;
  late String userName;
  bool _soundsEnabled = true; // Default value for sounds

  @override
  void initState() {
    super.initState();
    // Mock data
    networkUrl =
        'https://thispersondoesnotexist.com/'; // or provide a sample image URL
    userName = 'Esteban';
  }

  void _onThemeChanged() {
    ref.read(themeProvider.notifier).toggleTheme();
  }

  // void _onGoogleSignIn() {
  //   // Mock Google sign-in logic
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Google Sign-In pressed')),
  //   );
  // }

  // void _onAppleSignIn() {
  //   // Mock Apple sign-in logic
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Apple Sign-In pressed')),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // final String initial =
    //     userName.isNotEmpty ? userName[0].toUpperCase() : '?';
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
            // Center(
            //   child: networkUrl.isNotEmpty
            //       ? CircleAvatar(
            //           radius: 48,
            //           backgroundImage: NetworkImage(networkUrl),
            //         )
            //       : CircleAvatar(
            //           radius: 48,
            //           backgroundColor: UIColors.green,
            //           child: Text(
            //             initial,
            //             style: const TextStyle(
            //               fontSize: 40,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            // ),
            // const SizedBox(height: 32),
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
                  activeColor: Theme.of(context).primaryColor,
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
                Switch(
                  activeColor: Theme.of(context).primaryColor,
                  value: _soundsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _soundsEnabled = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            // ElevatedButton.icon(
            //   label: const Text('Sign in with Google'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.white,
            //     foregroundColor: Colors.black,
            //     minimumSize: const Size(double.infinity, 48),
            //   ),
            //   onPressed: _onGoogleSignIn,
            // ),
            // const SizedBox(height: 16),
            // ElevatedButton.icon(
            //   icon: const Icon(Icons.apple, size: 24),
            //   label: const Text('Sign in with Apple'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.black,
            //     foregroundColor: Colors.white,
            //     minimumSize: const Size(double.infinity, 48),
            //   ),
            //   onPressed: _onAppleSignIn,
            // ),
          ],
        ),
      ),
    );
  }
}
