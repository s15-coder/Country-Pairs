class ScoresState {
  final String playerName;
  ScoresState({
    required this.playerName,
  });
  factory ScoresState.initial() {
    return ScoresState(
      playerName: 'Player 1',
    );
  }
  ScoresState copyWith({
    String? playerName,
    int? playerScore,
  }) {
    return ScoresState(
      playerName: playerName ?? this.playerName,
    );
  }
}
