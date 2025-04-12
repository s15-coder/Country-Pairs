import 'package:flutter/material.dart';
import 'package:pairs_game/constants/ui_colors.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = UIColors.green,
  });
  final String text;
  final VoidCallback onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: ButtonStyle(
            side: WidgetStateProperty.all(
              BorderSide(
                color: color,
                width: 2,
              ),
            ),
            textStyle: WidgetStateProperty.all(
              const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            foregroundColor: WidgetStateProperty.all(color),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
