// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get home_hello => '안녕하세요!';

  @override
  String home_welcome(Object userName) {
    return '$userName님.';
  }

  @override
  String get home_howareyou => '오늘 기분은 어떠세요?';

  @override
  String get tab_home => '홈';

  @override
  String get tab_entries => '기록';

  @override
  String get tab_settings => '설정';

  @override
  String get tab_write => '글쓰기';
}
