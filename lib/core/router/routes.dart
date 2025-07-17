abstract final class Routes {
  static const String splash = '/$splashRelative';
  static const String splashRelative = 'splash';
  static const String onboarding = '/$onboardingRelative';
  static const String onboardingRelative = 'onboarding';
  static const String signIn = '/$signInRelative';
  static const String signInRelative = 'signin';
  static const String home = '/';
  static const String entries = '/$entriesRelative';
  static const String entriesRelative = 'entries';
  static const String write = '/$writeRelative';
  static const String writeRelative = 'write';
  static const String statistics = '/$statisticsRelative';
  static const String statisticsRelative = 'statistics';
  static const String settings = '/$settingsRelative';
  static const String settingsRelative = 'settings';
  static const String journalPage = '/$journalRelative/$idRelative';
  static const String journalRelative = 'journal';
  static const String profile = '/$profileRelative';
  static const String profileRelative = 'profile';
  static const String idRelative = ':id';

  static String journalImageDetail(id) => '/journal/$id/image';

  static String journal(id) => '/journal/$id';
}
