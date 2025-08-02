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
    0: 0, // home -> navigation index 0
    1: 1, // entries -> navigation index 1
    2: 3, // statistics -> navigation index 3 (skip write button at index 2)
    3: 4, // settings -> navigation index 4
  };

  static const Map<int, int> shellIndexMap = {
    0: 0, // navigation index 0 -> shell branch 0 (home)
    1: 1, // navigation index 1 -> shell branch 1 (entries)
    // index 2 is write button (no shell mapping)
    3: 2, // navigation index 3 -> shell branch 2 (statistics)
    4: 3, // navigation index 4 -> shell branch 3 (settings)
  };
}
