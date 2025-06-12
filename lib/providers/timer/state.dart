class TimerState {
  int remainingSeconds;
  bool isRunning;
  TimerState({
    required this.remainingSeconds,
    required this.isRunning,
  });
  TimerState copyWith({
    int? initialTimeInSeconds,
    int? remainingSeconds,
    bool? isRunning,
  }) {
    return TimerState(
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  TimerState.initial()
      : remainingSeconds = 0,
        isRunning = false;

  @override
  String toString() {
    return '''
    TimerState(
      remainingSeconds: $remainingSeconds,
      isRunning: $isRunning,
    )
    ''';
  }
}
