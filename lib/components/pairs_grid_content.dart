import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pairs_game/components/pair_item.dart';
import 'package:pairs_game/providers/pairs/provider.dart';

class PairsGridContent extends ConsumerWidget {
  const PairsGridContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double spacingGrid = 5;
    final pairsState = ref.watch(pairsProvider);

    final size = MediaQuery.of(context).size;
    final widthMinusSpaces = (size.width -
        ((pairsState.difficulty.gridLayout.xItems * spacingGrid)) -
        16);
    final width = widthMinusSpaces / pairsState.difficulty.gridLayout.xItems;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        runAlignment: WrapAlignment.center,
        spacing: spacingGrid,
        runSpacing: spacingGrid,
        children: List.generate(pairsState.countriesInGame.length, (index) {
          final countryObj = pairsState.countriesInGame[index];

          return PairItem(
            width: width,
            imageUrl: countryObj.flagPngUrl,
            isFlipped: pairsState.selectedIndex == index ||
                pairsState.selectedIndex2 == index,
            isDiscovered: pairsState.discoveredIndexes.contains(index),
            onTap: () {
              ref.read(pairsProvider.notifier).selectCard(index);
            },
          );
        }),
      ),
    );
  }
}
