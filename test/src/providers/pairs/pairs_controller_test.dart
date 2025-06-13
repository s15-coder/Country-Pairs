import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pairs_game/models/country.dart';
import 'package:pairs_game/models/difficulty.dart';
import 'package:pairs_game/providers/pairs/provider.dart';
import 'package:pairs_game/providers/pairs/repository.dart';
import 'package:pairs_game/providers/pairs/state.dart';
import 'package:pairs_game/providers/scores/controller.dart';
import 'package:pairs_game/providers/scores/provider.dart';
import 'package:pairs_game/providers/timer/controller.dart';
import 'package:pairs_game/providers/timer/provider.dart';

import 'pairs_controller_test.mocks.dart';

class MockScoresNotifier extends Mock implements ScoresController {}

class MockTimerNotifier extends Mock implements TimerController {}

@GenerateNiceMocks([MockSpec<PairsRepository>()])
void main() {
  late ProviderContainer container;
  late MockPairsRepository mockRepository;
  late MockScoresNotifier mockScoresNotifier;
  late MockTimerNotifier mockTimerNotifier;
  late List<Country> mockCountries;
  late ProviderSubscription<PairsState> sub;
  setUp(() {
    mockRepository = MockPairsRepository();
    mockScoresNotifier = MockScoresNotifier();
    mockTimerNotifier = MockTimerNotifier();
    mockCountries = [
      Country(
        name: 'A',
        flagPngUrl: 'https://example.com/a.png',
        flagEmoji: '🇦',
        cca3: 'AAA',
      ),
      Country(
        name: 'B',
        flagPngUrl: 'https://example.com/b.png',
        flagEmoji: '🇧',
        cca3: 'BBB',
      ),
      Country(
        name: 'C',
        flagPngUrl: 'https://example.com/c.png',
        flagEmoji: '🇨',
        cca3: 'CCC',
      ),
    ];

    container = ProviderContainer(
      overrides: [
        pairsRepositoryProvider.overrideWithValue(mockRepository),
        scoresProvider.overrideWith((ref) => mockScoresNotifier),
        timerProvider.overrideWith((ref) => mockTimerNotifier),
      ],
    );

    sub = container.listen<PairsState>(
      pairsProvider,
      (previous, next) {},
      fireImmediately: true,
    );
  });

  tearDown(() {
    container.dispose();
    sub.close();
  });
  test('updateDifficulty updates state difficulty', () {
    final controller = container.read(pairsProvider.notifier);
    controller.updateDifficulty(Difficulty.medium);
    expect(controller.state.difficulty, Difficulty.medium);
  });

  test('shuffleGameCards sets loading, fetches countries, sets success',
      () async {
    when(mockRepository.fetchCountries(any))
        .thenAnswer((_) async => mockCountries);

    final controller = container.read(pairsProvider.notifier);
    await controller.shuffleGameCards();

    expect(controller.state.getCountriesStatus, RequestStatus.success);
    expect(controller.state.countriesInGame.length, mockCountries.length * 2);
  });

  test('shuffleGameCards sets error on fetch failure', () async {
    when(mockRepository.fetchCountries(any)).thenThrow(Exception('fail'));

    final controller = container.read(pairsProvider.notifier);
    await controller.shuffleGameCards();

    expect(controller.state.getCountriesStatus, RequestStatus.error);
  });

  test('selectCard selects first and second card, increases attempts',
      () async {
    when(mockRepository.fetchCountries(any)).thenAnswer((_) async => [
          Country(
            name: 'A',
            flagPngUrl: 'https://example.com/a.png',
            flagEmoji: '🇦',
            cca3: 'AAA',
          ),
          Country(
            name: 'A',
            flagPngUrl: 'https://example.com/a.png',
            flagEmoji: '🇦',
            cca3: 'AAA',
          ),
        ]);
    final controller = container.read(pairsProvider.notifier);
    await controller.shuffleGameCards();

    controller.selectCard(0);
    expect(controller.state.selectedIndex, 0);

    controller.selectCard(1);
    expect(controller.state.selectedIndex2, 1);

    // Wait for delayed comparison
    await Future.delayed(const Duration(seconds: 2, milliseconds: 100));
    expect(controller.state.attempts, 1);
  });

  test('selectCard does not select already discovered or selected cards',
      () async {
    when(mockRepository.fetchCountries(any)).thenAnswer((_) async => [
          Country(
            name: 'A',
            flagPngUrl: 'https://example.com/a.png',
            flagEmoji: '🇦',
            cca3: 'AAA',
          ),
          Country(
            name: 'A',
            flagPngUrl: 'https://example.com/a.png',
            flagEmoji: '🇦',
            cca3: 'AAA',
          ),
        ]);
    final controller = container.read(pairsProvider.notifier);
    await controller.shuffleGameCards();

    controller.state = controller.state.copyWith(
      discoveredIndexes: [0],
      selectedIndex: 1,
    );
    await controller.selectCard(0);
    expect(controller.state.selectedIndex2, isNull);
  });

  test('resetGame calls shuffleGameCards', () async {
    when(mockRepository.fetchCountries(any))
        .thenAnswer((_) async => mockCountries);
    final controller = container.read(pairsProvider.notifier);
    await controller.resetGame();
    expect(controller.state.getCountriesStatus, RequestStatus.success);
  });

  test('resetSelectedIndexes resets selected indexes', () {
    final controller = container.read(pairsProvider.notifier);
    controller.state =
        controller.state.copyWith(selectedIndex: 1, selectedIndex2: 2);
    controller.resetSelectedIndexes();
    expect(controller.state.selectedIndex, isNull);
    expect(controller.state.selectedIndex2, isNull);
  });

  test('win triggers timer stop and score save', () async {
    when(mockRepository.fetchCountries(any)).thenAnswer((_) async => [
          Country(
            name: 'A',
            flagPngUrl: 'https://example.com/a.png',
            flagEmoji: '🇦',
            cca3: 'AAA',
          )
        ]);
    final controller = container.read(pairsProvider.notifier);
    await controller.shuffleGameCards();

    // Simulate all pairs discovered after selection
    await controller.selectCard(0);
    await controller.selectCard(1);
    await Future.delayed(const Duration(seconds: 1, milliseconds: 100));

    verify(mockTimerNotifier.stopTimer()).called(1);
    verify(mockScoresNotifier.saveScore()).called(1);
  });
}
