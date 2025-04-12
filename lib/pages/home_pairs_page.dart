import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/components/pair_item.dart';
import 'package:pairs_game/constants/ui_colors.dart';
import 'package:pairs_game/providers/pairs/provider.dart';

class HomePairsPage extends ConsumerWidget {
  const HomePairsPage({super.key});

  static const String routeName = '/homePairsPages';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerState = ref.watch(pairsProvider);
    final size = MediaQuery.of(context).size;
    final widthMinusSpaces =
        (size.width - ((providerState.difficulty.gridLayout.xItems * 5)) - 16);
    final width = widthMinusSpaces / providerState.difficulty.gridLayout.xItems;

    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 120,
        color: UIColors.black,
      ),
      backgroundColor: UIColors.darkGray,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.center,
              spacing: 5,
              runSpacing: 5,
              children:
                  List.generate(providerState.countriesInGame.length, (index) {
                final countryObj = providerState.countriesInGame[index];
                return PairItem(
                  width: width,
                  countryCode: countryObj.countryCode,
                  isFlipped: providerState.selectedIndex == index ||
                      providerState.selectedIndex2 == index,
                  isDiscovered: providerState.discoveredIndexes.contains(index),
                  onTap: () {
                    ref.read(pairsProvider.notifier).selectCard(index);
                  },
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
