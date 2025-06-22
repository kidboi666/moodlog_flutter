abstract final class Routes {
  static const String home = '/';
  static const String settings = '/$settingsRelative';
  static const String settingsRelative = 'settings';
  static const String entries = '/$entriesRelative';
  static const String entriesRelative = 'entries';
  static const String write = '/$writeRelative';
  static const String writeRelative = 'write';

  static String journal(id) => '/journal/$id';
}
