class ScoresState {
  final String playerName;
  final String filter;
  ScoresState({
    required this.playerName,
    required this.filter,
  });
  factory ScoresState.initial() {
    return ScoresState(
      playerName: 'Player 1',
      filter: 'All',
    );
  }
  ScoresState copyWith({
    String? playerName,
    String? filter,
  }) {
    return ScoresState(
      playerName: playerName ?? this.playerName,
      filter: filter ?? this.filter,
    );
  }
}
