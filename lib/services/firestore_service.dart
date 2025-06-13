import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get scoresCollection => _firestore.collection('scores');

  Future<void> addScore(Map<String, dynamic> data) async {
    try {
      await scoresCollection.add(data);
    } catch (e) {
      throw Exception('Failed to add score: $e');
    }
  }

  Future<QuerySnapshot> getTopScores({
    required String difficulty,
    int limit = 10,
  }) async {
    try {
      return await scoresCollection
          .where('difficulty', isEqualTo: difficulty)
          .orderBy('score', descending: true)
          .limit(limit)
          .get();
    } catch (e) {
      throw Exception('Failed to fetch top scores: $e');
    }
  }
}

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});
