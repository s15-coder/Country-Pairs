import 'package:flutter/material.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/models/button_action.dart';

class CustomDialog extends StatelessWidget {
  final String? text;
  final Widget? child;
  final ButtonAction? actionLeft;
  final ButtonAction? actionRight;
  const CustomDialog({
    super.key,
    this.text,
    required this.actionLeft,
    required this.actionRight,
    this.child,
  }) : assert(
          text == null || child == null,
          'At least text or child must be provided',
        );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: UIColors.darkGray,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                if (text != null)
                  Text(
                    text!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                if (child != null) child!,
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    actionLeft != null
                        ? Expanded(
                            child: OutlinedButton(
                              style: ButtonStyle(
                                side: WidgetStateProperty.all(
                                  BorderSide(
                                    color: UIColors.green,
                                    width: 2,
                                  ),
                                ),
                                textStyle: WidgetStateProperty.all(
                                  const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  UIColors.green,
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              onPressed: actionLeft!.onPressed,
                              child: Text(actionLeft!.text),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(width: 16),
                    actionRight != null
                        ? Expanded(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: UIColors.green,
                              textColor: Colors.white,
                              onPressed: actionRight!.onPressed,
                              child: Text(actionRight!.text),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              left: 0,
              child: Transform.translate(
                offset: const Offset(0, -60),
                child: Image.asset(
                  'assets/app/world_icon.png',
                  height: 80,
                  width: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
