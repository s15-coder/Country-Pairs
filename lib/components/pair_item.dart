import 'package:flutter/material.dart';
import 'package:pairs_game/constants/ui_colors.dart';

class PairItem extends StatelessWidget {
  const PairItem({
    super.key,
    required this.width,
    required this.countryCode,
    required this.isFlipped,
    required this.isDiscovered,
    required this.onTap,
  });

  final double width;
  final String countryCode;
  final bool isFlipped;
  final bool isDiscovered;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: !isDiscovered
          ? Stack(
              children: [
                SizedBox(
                  width: width,
                  height: width,
                  child: Image.asset(
                    'assets/flags/$countryCode.png',
                    fit: BoxFit.fill,
                  ),
                ),
                GestureDetector(
                  onTap: isFlipped ? null : onTap,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: isFlipped ? 0 : width,
                      color: UIColors.green,
                      alignment: Alignment.center,
                      child: Text(
                        "?",
                        style: TextStyle(
                          fontSize: width / 2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ],
            )
          : null,
    );
  }
}
