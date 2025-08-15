import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/style/theme/dark_theme.dart';
import 'package:pairs_game/style/theme/light_theme.dart';

class ThemeController extends StateNotifier<ThemeData> {
  ThemeController() : super(lightTheme);

  void toggleTheme() {
    state = state == lightTheme ? darkTheme : lightTheme;
  }
}
