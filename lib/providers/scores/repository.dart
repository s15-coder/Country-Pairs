import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pairs_game/models/db/score.dart';

class ScoresRepository {
  final CollectionReference _scoresCollection =
      FirebaseFirestore.instance.collection('scores');

  Future<void> addScore({
    required String playerName,
    required int score,
    required String difficulty,
    required DateTime date,
  }) async {
    try {
      await _scoresCollection.add({
        'playerName': playerName,
        'score': score,
        'difficulty': difficulty,
        'date': date.toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to add score: $e');
    }
  }

  Future<List<Score>> getTopScores({
    required String difficulty,
    int limit = 10,
  }) async {
    try {
      final querySnapshot = await _scoresCollection
          .where('difficulty', isEqualTo: difficulty)
          .orderBy('score', descending: true)
          .limit(limit)
          .get();
      return querySnapshot.docs
          .map((doc) => Score.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch top scores: $e');
    }
  }
}

final scoresRepositoryProvider = Provider<ScoresRepository>((ref) {
  return ScoresRepository();
});
