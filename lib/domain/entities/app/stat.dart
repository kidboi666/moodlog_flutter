class Stat {
  final int id;
  final int currentStreak;
  final int maxStreak;
  final DateTime lastActiveDate;

  Stat({
    required this.id,
    required this.currentStreak,
    required this.maxStreak,
    required this.lastActiveDate,
  });
}
