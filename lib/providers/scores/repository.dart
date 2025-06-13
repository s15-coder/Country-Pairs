import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/models/db/score.dart';
import 'package:pairs_game/services/firestore_service.dart';

class ScoresRepository {
  final FirestoreService firestoreService;
  ScoresRepository(this.firestoreService);

  Future<void> addScore({
    required String playerName,
    required int score,
    required String difficulty,
    required DateTime date,
  }) async {
    try {
      await firestoreService.addScore(
        {
          'playerName': playerName,
          'score': score,
          'difficulty': difficulty,
          'date': date.toIso8601String(),
        },
      );
    } catch (e) {
      throw Exception('Failed to add score: $e');
    }
  }

  Future<List<Score>> getTopScores({
    required String difficulty,
    int limit = 10,
  }) async {
    try {
      final querySnapshot = await firestoreService.getTopScores(
        difficulty: difficulty,
        limit: limit,
      );
      return querySnapshot.docs
          .map((doc) => Score.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch top scores: $e');
    }
  }
}

final scoresRepositoryProvider = Provider<ScoresRepository>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return ScoresRepository(firestoreService);
});
