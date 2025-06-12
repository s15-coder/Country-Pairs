import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/pairs_grid_content.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/providers/pairs/provider.dart';
import 'package:pairs_game/providers/pairs/state.dart';

class PairsGrid extends ConsumerWidget {
  const PairsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestStatus =
        ref.watch(pairsProvider.select((state) => state.getCountriesStatus));

    if (requestStatus == RequestStatus.loading) {
      return const SizedBox(
        width: 100,
        height: 100,
        child: Center(
            child: CircularProgressIndicator(
          color: UIColors.darkGreen,
        )),
      );
    }
    if (requestStatus == RequestStatus.error) {
      return const Text(
        'Error loading countries',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      );
    }
    return const PairsGridContent();
  }
}
