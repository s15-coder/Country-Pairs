// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScoreAdapter extends TypeAdapter<Score> {
  @override
  final int typeId = 0;

  @override
  Score read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Score(
      difficulty: fields[0] as String,
      score: fields[1] as int,
      modality: fields[2] as String?,
      playerName: fields[3] as String,
      date: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Score obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.difficulty)
      ..writeByte(1)
      ..write(obj.score)
      ..writeByte(2)
      ..write(obj.modality)
      ..writeByte(3)
      ..write(obj.playerName)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
