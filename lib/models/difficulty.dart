import 'package:pairs_game/models/grid_layout.dart';

enum Difficulty {
  easy(
    pairsAmount: 6,
    label: 'Easy',
    gridLayout: GridLayout(
      xItems: 3,
      yItems: 4,
    ),
    secondsDuration: 60,
  ),
  medium(
    pairsAmount: 10,
    label: 'Medium',
    gridLayout: GridLayout(
      xItems: 4,
      yItems: 5,
    ),
    secondsDuration: 100,
  ),
  hard(
    pairsAmount: 15,
    label: 'Hard',
    gridLayout: GridLayout(
      xItems: 5,
      yItems: 6,
    ),
    secondsDuration: 150,
  ),
  expert(
    pairsAmount: 20,
    label: 'Expert',
    gridLayout: GridLayout(
      xItems: 5,
      yItems: 8,
    ),
    secondsDuration: 200,
  ),
  ;

  const Difficulty({
    required this.pairsAmount,
    required this.label,
    required this.gridLayout,
    required this.secondsDuration,
  });
  final int pairsAmount;
  final String label;
  final GridLayout gridLayout;
  final int secondsDuration;
}
