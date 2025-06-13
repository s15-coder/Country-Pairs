import 'package:hive_flutter/hive_flutter.dart';

part 'score.g.dart';

@HiveType(typeId: 0)
class Score {
  @HiveField(0)
  final String difficulty;

  @HiveField(1)
  final int score;

  @HiveField(2)
  final String? modality;

  @HiveField(3)
  final String playerName;

  @HiveField(4)
  final String date;

  Score({
    required this.difficulty,
    required this.score,
    required this.modality,
    required this.playerName,
    required this.date,
  });

  String get formattedDate {
    final dateTime = DateTime.tryParse(date);
    if (dateTime == null) return date;
    return "${dateTime.day.toString().padLeft(2, '0')}-"
        "${dateTime.month.toString().padLeft(2, '0')}-"
        "${dateTime.year}";
  }

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      difficulty: json['difficulty'] as String,
      score: json['score'] as int,
      modality: json['modality'] as String?,
      playerName: json['playerName'] as String,
      date: json['date'] as String,
    );
  }
}
