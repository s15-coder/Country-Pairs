import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:pairs_game/models/db/score.dart';
import 'package:path_provider/path_provider.dart';

class HiveDBService {
  static final HiveDBService _instance = HiveDBService._internal();

  factory HiveDBService() => _instance;

  HiveDBService._internal();

  late Box<Score> productBox;

  Future<void> initializeHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(ScoreAdapter());
    productBox = await Hive.openBox<Score>('scores');
  }

  Future<void> addScore(Score score) async {
    await productBox.add(score);
  }

  Future<List<Score>> getScores() async {
    return productBox.values.toList();
  }

  Future<void> save(List<Score> scores) async {
    await productBox.clear();
    for (var score in scores) {
      await productBox.add(score);
    }
  }

  Future<void> deleteScore(int index) async {
    await productBox.deleteAt(index);
  }

  Future<void> clearScores() async {
    await productBox.clear();
  }

  Future<void> closeHive() async {
    await productBox.close();
    await Hive.close();
  }
}

final hiveServiceProvider = Provider<HiveDBService>((ref) {
  return HiveDBService();
});
