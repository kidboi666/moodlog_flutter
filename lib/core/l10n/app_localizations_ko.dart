// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get onboarding_welcome_title => '무드로그에 오신것을 환영합니다!';

  @override
  String get onboarding_welcome_description1 =>
      '무드로그는 당신의 일상 감정을 기록하고 그에 대한 AI의 답장을 받을 수 있는 앱입니다.';

  @override
  String get onboarding_welcome_description2 => '매일 감정을 기록하고 AI가 해준 답장을 읽어보세요.';

  @override
  String get onboarding_welcome_next => '함께 준비해볼까요?';

  @override
  String get onboarding_nickname_title => '닉네임 설정';

  @override
  String get onboarding_nickname_description => '무드로그에서 사용할 닉네임을 입력해주세요';

  @override
  String get onboarding_nickname_input_title => '닉네임';

  @override
  String get onboarding_nickname_input_hint => '닉네임을 입력하세요 (2~10자)';

  @override
  String get onboarding_nickname_next => '닉네임은 언제든지 설정 메뉴에서 변경할 수 있어요.';

  @override
  String get onboarding_nickname_input_error => '닉네임을 입력해주세요.';

  @override
  String get onboarding_personality_title => '답장 스타일 정하기';

  @override
  String get onboarding_personality_description =>
      '당신의 일기에 답장해줄 AI의 친절도를 선택하세요.';

  @override
  String get onboarding_personality_rational_title => '냉철한 분석가';

  @override
  String get onboarding_personality_rational_description =>
      '객관적이고 실용적인 조언을 제공합니다';

  @override
  String get onboarding_personality_balanced_title => '균형잡힌 조언자';

  @override
  String get onboarding_personality_balanced_description =>
      '공감과 현실적 조언의 균형을 맞춥니다.';

  @override
  String get onboarding_personality_compassionate_title => '다정한 치유자';

  @override
  String get onboarding_personality_compassionate_description =>
      '따뜻한 위로와 깊은 공감을 전합니다.';

  @override
  String get onboarding_success_title => '시작할 준비가 되었어요!';

  @override
  String get onboarding_success_description => '무드로그를 시작해볼까요?';

  @override
  String get onboarding_success_button => '시작하기';

  @override
  String get home_hello => '안녕하세요!';

  @override
  String home_welcome(Object userName) {
    return '$userName님.';
  }

  @override
  String get home_howareyou => '오늘 기분은 어떠세요?';

  @override
  String get home_empty_box => '당신의 이야기를 기다리고 있어요.';

  @override
  String get tab_home => '홈';

  @override
  String get tab_entries => '기록';

  @override
  String get tab_settings => '설정';

  @override
  String get tab_write => '글쓰기';

  @override
  String get write_input_title => '내용';

  @override
  String get write_input_hint => '오늘의 감정과 경험을 기록해보세요.';

  @override
  String get write_ai_title => 'AI 위로 메시지';

  @override
  String get write_ai_description => '일기 작성 후 AI가 위로와 격려의 메시지를 보내드려요.';
}
