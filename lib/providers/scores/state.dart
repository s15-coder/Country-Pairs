class ScoresState {
  final String playerName;
  final String filter;
  final int score;
  ScoresState({
    required this.playerName,
    required this.filter,
    required this.score,
  });
  factory ScoresState.initial() {
    return ScoresState(
      playerName: 'Player 1',
      filter: 'All',
      score: 0,
    );
  }
  ScoresState copyWith({
    String? playerName,
    String? filter,
    int? score,
  }) {
    return ScoresState(
      playerName: playerName ?? this.playerName,
      filter: filter ?? this.filter,
      score: score ?? this.score,
    );
  }
}
