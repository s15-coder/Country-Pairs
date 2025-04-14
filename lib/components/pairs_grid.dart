import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/pair_item.dart';
import 'package:pairs_game/providers/pairs/provider.dart';

class PairsGrid extends ConsumerWidget {
  const PairsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current state of the game for each variable in order to avoid rebuilds each second
    final difficulty =
        ref.watch(pairsProvider.select((state) => state.difficulty));
    final countriesInGame =
        ref.watch(pairsProvider.select((state) => state.countriesInGame));
    final discoveredIndexes =
        ref.watch(pairsProvider.select((state) => state.discoveredIndexes));
    final selectedIndex =
        ref.watch(pairsProvider.select((state) => state.selectedIndex));
    final selectedIndex2 =
        ref.watch(pairsProvider.select((state) => state.selectedIndex2));

    final size = MediaQuery.of(context).size;
    final widthMinusSpaces =
        (size.width - ((difficulty.gridLayout.xItems * 5)) - 16);
    final width = widthMinusSpaces / difficulty.gridLayout.xItems;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        runAlignment: WrapAlignment.center,
        spacing: 5,
        runSpacing: 5,
        children: List.generate(countriesInGame.length, (index) {
          final countryObj = countriesInGame[index];
          return PairItem(
            width: width,
            countryCode: countryObj.countryCode,
            isFlipped: selectedIndex == index || selectedIndex2 == index,
            isDiscovered: discoveredIndexes.contains(index),
            onTap: () {
              ref.read(pairsProvider.notifier).selectCard(index);
            },
          );
        }),
      ),
    );
  }
}
