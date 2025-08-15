import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/providers/theme/controller.dart';

final themeProvider = StateNotifierProvider<ThemeController, ThemeData>((ref) {
  return ThemeController();
});
