import 'package:pairs_game/models/grid_layout.dart';

enum Difficulty {
  easy(
    cardsAmount: 6,
    label: 'Easy',
    gridLayout: GridLayout(
      xItems: 3,
      yItems: 4,
    ),
  ),
  medium(
    cardsAmount: 10,
    label: 'Medium',
    gridLayout: GridLayout(
      xItems: 4,
      yItems: 5,
    ),
  ),
  hard(
    cardsAmount: 15,
    label: 'Hard',
    gridLayout: GridLayout(
      xItems: 5,
      yItems: 6,
    ),
  ),
  expert(
    cardsAmount: 20,
    label: 'Expert',
    gridLayout: GridLayout(
      xItems: 5,
      yItems: 8,
    ),
  ),
  ;

  const Difficulty({
    required this.cardsAmount,
    required this.label,
    required this.gridLayout,
  });
  final int cardsAmount;
  final String label;
  final GridLayout gridLayout;
}
