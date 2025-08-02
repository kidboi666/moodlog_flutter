abstract final class Navigation {
  static const String home = 'Home';
  static const String entries = 'Entries';
  static const String statistics = 'Statistics';
  static const String settings = 'Settings';
  static const String write = 'Write';

  static const double bottomNavRadius = 24.0;
  static const double bottomNavHeight = 56.0;
  static const int fabPlaceholderIndex = 2;

  static const Map<int, int> navigationIndexMap = {
    0: 0, // home
    1: 1, // entries
    2: 2, // statistics (skip FAB placeholder)
    3: 3, // settings
  };

  static const Map<int, int> shellIndexMap = {
    0: 0, // home
    1: 1, // entries
    2: 2, // statistics (shell branch 2)
    3: 3, // settings (shell branch 3)
  };
}
