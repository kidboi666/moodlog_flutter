abstract final class Routes {
  static const String splash = '/$splashRelative';
  static const String splashRelative = 'splash';
  static const String onboarding = '/$onboardingRelative';
  static const String onboardingRelative = 'onboarding';
  static const String home = '/';
  static const String entries = '/$entriesRelative';
  static const String entriesRelative = 'entries';
  static const String write = '/$writeRelative';
  static const String writeRelative = 'write';
  static const String statistics = '/$statisticsRelative';
  static const String statisticsRelative = 'statistics';
  static const String settings = '/$settingsRelative';
  static const String settingsRelative = 'settings';

  static String journalImageDetail(id) => '/$id/image';

  static String journal(id) => '/$id';
}
