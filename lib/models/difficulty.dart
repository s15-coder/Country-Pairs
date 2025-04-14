import 'package:pairs_game/models/grid_layout.dart';

enum Difficulty {
  easy(
    cardsAmount: 6,
    label: 'Easy',
    gridLayout: GridLayout(
      xItems: 3,
      yItems: 4,
    ),
    secondsDuration: 60,
  ),
  medium(
    cardsAmount: 10,
    label: 'Medium',
    gridLayout: GridLayout(
      xItems: 4,
      yItems: 5,
    ),
    secondsDuration: 70,
  ),
  hard(
    cardsAmount: 15,
    label: 'Hard',
    gridLayout: GridLayout(
      xItems: 5,
      yItems: 6,
    ),
    secondsDuration: 80,
  ),
  expert(
    cardsAmount: 20,
    label: 'Expert',
    gridLayout: GridLayout(
      xItems: 5,
      yItems: 8,
    ),
    secondsDuration: 90,
  ),
  ;

  const Difficulty({
    required this.cardsAmount,
    required this.label,
    required this.gridLayout,
    required this.secondsDuration,
  });
  final int cardsAmount;
  final String label;
  final GridLayout gridLayout;
  final int secondsDuration;
}
