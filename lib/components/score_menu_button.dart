import 'package:flutter/material.dart';
import 'package:pairs_game/constants/ui_colors.dart';

class ScoreMenuButton extends StatelessWidget {
  const ScoreMenuButton({
    required this.onMenuItemSelected,
    required this.currentFilter,
    super.key,
  });
  final Function(String) onMenuItemSelected;
  final String currentFilter;
  static const scoreFilters = [
    'All',
    'Easy',
    'Medium',
    'Hard',
    'Expert',
  ];
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: UIColors.darkGray,
        itemBuilder: (_) {
          return scoreFilters
              .map((filter) => PopupMenuItem(
                    onTap: () => onMenuItemSelected(filter),
                    value: filter,
                    child: Row(
                      children: [
                        Checkbox(
                          value: filter == currentFilter,
                          onChanged: (_) {
                            onMenuItemSelected(filter);
                            Navigator.pop(context);
                          },
                          shape: const CircleBorder(),
                          checkColor: Colors.white,
                          activeColor: UIColors.green,
                          side: const BorderSide(
                            color: UIColors.green,
                            width: 2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          filter,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList();
        },
        onSelected: (value) {
          onMenuItemSelected(value);
        },
        icon: const Icon(
          Icons.filter_list,
          color: Colors.white,
          size: 30,
        ));
  }
}
