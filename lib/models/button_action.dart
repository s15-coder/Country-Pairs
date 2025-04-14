import 'package:flutter/material.dart';

enum ButtonStyleType { outline, material }

class ButtonAction {
  final VoidCallback onPressed;
  final String text;
  final ButtonStyleType buttonStyle;

  ButtonAction({
    required this.onPressed,
    required this.text,
    required this.buttonStyle,
  });
}
