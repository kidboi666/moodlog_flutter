abstract final class Routes {
  static const String splash = '/splash';
  static const String lock = '/lock';
  static const String onboarding = '/onboarding';
  static const String signIn = '/signin';
  static const String home = '/';
  static const String entries = '/entries';
  static const String write = '/write';
  static const String quickCheckIn = '/quick-check-in';
  static const String statistics = '/statistics';
  static const String settings = '/settings';
  static const String journalPage = '/journal/:id';
  static const String checkInPage = '/check-in/:id';
  static const String profile = '/profile';
  static const String activities = '/activities';
  static const String activityDetail = '/activities/:id';
  static const String purchase = '/purchase';
  static const String fontSettings = '/font-settings';
  static const String moodSummary = '/mood-summary';

  static String journalImageDetail(int id) => '/journal/$id/image';

  static String journal(int id) => '/journal/$id';

  static String checkIn(int id) => '/check-in/$id';

  static String activity(int id) => '/activities/$id';
}
