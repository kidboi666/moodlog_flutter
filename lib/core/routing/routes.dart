abstract final class Routes {
  static const String onboarding = '/onboarding';
  static const String signIn = '/signin';
  static const String home = '/';
  static const String entries = '/entries';
  static const String write = '/write';
  static const String statistics = '/statistics';
  static const String settings = '/settings';
  static const String journalPage = '/journal/:id';
  static const String profile = '/profile';
  static const String tags = '/tags';
  static const String tagDetail = '/tags/:id';

  static String journalImageDetail(int id) => '/journal/$id/image';

  static String journal(int id) => '/journal/$id';

  static String tag(int id) => '/tags/$id';
}
