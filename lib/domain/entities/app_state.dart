class AppState {
  final bool isInitialApp;
  final bool isDarkMode;
  final DateTime? lastActiveDate;
  final DateTime firstExecutedDate;

  AppState({
    required this.isInitialApp,
    required this.isDarkMode,
    required this.lastActiveDate,
    required this.firstExecutedDate,
  });
}
