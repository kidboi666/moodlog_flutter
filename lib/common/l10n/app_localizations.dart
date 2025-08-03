import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_th.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('th'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @common_date_today.
  ///
  /// In ko, this message translates to:
  /// **'오늘'**
  String get common_date_today;

  /// No description provided for @common_date_tomorrow.
  ///
  /// In ko, this message translates to:
  /// **'내일'**
  String get common_date_tomorrow;

  /// No description provided for @common_date_yesterday.
  ///
  /// In ko, this message translates to:
  /// **'어제'**
  String get common_date_yesterday;

  /// No description provided for @common_date_full.
  ///
  /// In ko, this message translates to:
  /// **'yyyy년 MM월 dd일'**
  String get common_date_full;

  /// No description provided for @common_confirm_cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get common_confirm_cancel;

  /// No description provided for @common_confirm_ok.
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get common_confirm_ok;

  /// No description provided for @common_confirm_delete.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get common_confirm_delete;

  /// No description provided for @common_confirm_save.
  ///
  /// In ko, this message translates to:
  /// **'저장'**
  String get common_confirm_save;

  /// No description provided for @common_email.
  ///
  /// In ko, this message translates to:
  /// **'이메일'**
  String get common_email;

  /// No description provided for @common_phone.
  ///
  /// In ko, this message translates to:
  /// **'전화'**
  String get common_phone;

  /// No description provided for @common_mood_verygood.
  ///
  /// In ko, this message translates to:
  /// **'매우 좋음'**
  String get common_mood_verygood;

  /// No description provided for @common_mood_good.
  ///
  /// In ko, this message translates to:
  /// **'좋음'**
  String get common_mood_good;

  /// No description provided for @common_mood_neutral.
  ///
  /// In ko, this message translates to:
  /// **'보통'**
  String get common_mood_neutral;

  /// No description provided for @common_mood_bad.
  ///
  /// In ko, this message translates to:
  /// **'안좋음'**
  String get common_mood_bad;

  /// No description provided for @common_mood_verybad.
  ///
  /// In ko, this message translates to:
  /// **'매우 안좋음'**
  String get common_mood_verybad;

  /// No description provided for @common_month_jan.
  ///
  /// In ko, this message translates to:
  /// **'1월'**
  String get common_month_jan;

  /// No description provided for @common_month_feb.
  ///
  /// In ko, this message translates to:
  /// **'2월'**
  String get common_month_feb;

  /// No description provided for @common_month_mar.
  ///
  /// In ko, this message translates to:
  /// **'3월'**
  String get common_month_mar;

  /// No description provided for @common_month_apr.
  ///
  /// In ko, this message translates to:
  /// **'4월'**
  String get common_month_apr;

  /// No description provided for @common_month_may.
  ///
  /// In ko, this message translates to:
  /// **'5월'**
  String get common_month_may;

  /// No description provided for @common_month_jun.
  ///
  /// In ko, this message translates to:
  /// **'6월'**
  String get common_month_jun;

  /// No description provided for @common_month_jul.
  ///
  /// In ko, this message translates to:
  /// **'7월'**
  String get common_month_jul;

  /// No description provided for @common_month_aug.
  ///
  /// In ko, this message translates to:
  /// **'8월'**
  String get common_month_aug;

  /// No description provided for @common_month_sep.
  ///
  /// In ko, this message translates to:
  /// **'9월'**
  String get common_month_sep;

  /// No description provided for @common_month_oct.
  ///
  /// In ko, this message translates to:
  /// **'10월'**
  String get common_month_oct;

  /// No description provided for @common_month_nov.
  ///
  /// In ko, this message translates to:
  /// **'11월'**
  String get common_month_nov;

  /// No description provided for @common_month_dec.
  ///
  /// In ko, this message translates to:
  /// **'12월'**
  String get common_month_dec;

  /// No description provided for @common_weekday_mon.
  ///
  /// In ko, this message translates to:
  /// **'월요일'**
  String get common_weekday_mon;

  /// No description provided for @common_weekday_tue.
  ///
  /// In ko, this message translates to:
  /// **'화요일'**
  String get common_weekday_tue;

  /// No description provided for @common_weekday_wed.
  ///
  /// In ko, this message translates to:
  /// **'수요일'**
  String get common_weekday_wed;

  /// No description provided for @common_weekday_thu.
  ///
  /// In ko, this message translates to:
  /// **'목요일'**
  String get common_weekday_thu;

  /// No description provided for @common_weekday_fri.
  ///
  /// In ko, this message translates to:
  /// **'금요일'**
  String get common_weekday_fri;

  /// No description provided for @common_weekday_sat.
  ///
  /// In ko, this message translates to:
  /// **'토요일'**
  String get common_weekday_sat;

  /// No description provided for @common_weekday_sun.
  ///
  /// In ko, this message translates to:
  /// **'일요일'**
  String get common_weekday_sun;

  /// No description provided for @common_weekday_mon_short.
  ///
  /// In ko, this message translates to:
  /// **'월'**
  String get common_weekday_mon_short;

  /// No description provided for @common_weekday_tue_short.
  ///
  /// In ko, this message translates to:
  /// **'화'**
  String get common_weekday_tue_short;

  /// No description provided for @common_weekday_wed_short.
  ///
  /// In ko, this message translates to:
  /// **'수'**
  String get common_weekday_wed_short;

  /// No description provided for @common_weekday_thu_short.
  ///
  /// In ko, this message translates to:
  /// **'목'**
  String get common_weekday_thu_short;

  /// No description provided for @common_weekday_fri_short.
  ///
  /// In ko, this message translates to:
  /// **'금'**
  String get common_weekday_fri_short;

  /// No description provided for @common_weekday_sat_short.
  ///
  /// In ko, this message translates to:
  /// **'토'**
  String get common_weekday_sat_short;

  /// No description provided for @common_weekday_sun_short.
  ///
  /// In ko, this message translates to:
  /// **'일'**
  String get common_weekday_sun_short;

  /// No description provided for @onboarding_welcome_title.
  ///
  /// In ko, this message translates to:
  /// **'무드로그에 오신 것을 환영합니다!'**
  String get onboarding_welcome_title;

  /// No description provided for @onboarding_welcome_description1.
  ///
  /// In ko, this message translates to:
  /// **'무드로그는 당신의 일상 감정을 기록하고 그에 대한 AI의 답장을 받을 수 있는 앱입니다.'**
  String get onboarding_welcome_description1;

  /// No description provided for @onboarding_welcome_description2.
  ///
  /// In ko, this message translates to:
  /// **'매일 감정을 기록하고 AI가 해준 답장을 읽어보세요.'**
  String get onboarding_welcome_description2;

  /// No description provided for @onboarding_welcome_next.
  ///
  /// In ko, this message translates to:
  /// **'함께 준비해볼까요?'**
  String get onboarding_welcome_next;

  /// No description provided for @onboarding_nickname_title.
  ///
  /// In ko, this message translates to:
  /// **'닉네임 설정'**
  String get onboarding_nickname_title;

  /// No description provided for @onboarding_nickname_description.
  ///
  /// In ko, this message translates to:
  /// **'무드로그에서 사용할 닉네임을 입력해주세요'**
  String get onboarding_nickname_description;

  /// No description provided for @onboarding_nickname_input_title.
  ///
  /// In ko, this message translates to:
  /// **'닉네임'**
  String get onboarding_nickname_input_title;

  /// No description provided for @onboarding_nickname_input_hint.
  ///
  /// In ko, this message translates to:
  /// **'닉네임을 입력하세요 (2~10자)'**
  String get onboarding_nickname_input_hint;

  /// No description provided for @onboarding_nickname_next.
  ///
  /// In ko, this message translates to:
  /// **'닉네임은 언제든지 설정 메뉴에서 변경할 수 있어요.'**
  String get onboarding_nickname_next;

  /// No description provided for @onboarding_nickname_input_error.
  ///
  /// In ko, this message translates to:
  /// **'닉네임을 입력해주세요.'**
  String get onboarding_nickname_input_error;

  /// No description provided for @onboarding_personality_title.
  ///
  /// In ko, this message translates to:
  /// **'답장 스타일 정하기'**
  String get onboarding_personality_title;

  /// No description provided for @onboarding_personality_description.
  ///
  /// In ko, this message translates to:
  /// **'당신의 일기에 답변해줄 AI의 성격을 선택하세요.'**
  String get onboarding_personality_description;

  /// No description provided for @onboarding_personality_rational_title.
  ///
  /// In ko, this message translates to:
  /// **'냉철한 분석가'**
  String get onboarding_personality_rational_title;

  /// No description provided for @onboarding_personality_rational_description.
  ///
  /// In ko, this message translates to:
  /// **'객관적이고 실용적인 조언을 제공합니다'**
  String get onboarding_personality_rational_description;

  /// No description provided for @onboarding_personality_balanced_title.
  ///
  /// In ko, this message translates to:
  /// **'균형잡힌 조언자'**
  String get onboarding_personality_balanced_title;

  /// No description provided for @onboarding_personality_balanced_description.
  ///
  /// In ko, this message translates to:
  /// **'공감과 현실적 조언의 균형을 맞춥니다.'**
  String get onboarding_personality_balanced_description;

  /// No description provided for @onboarding_personality_compassionate_title.
  ///
  /// In ko, this message translates to:
  /// **'다정한 치유자'**
  String get onboarding_personality_compassionate_title;

  /// No description provided for @onboarding_personality_compassionate_description.
  ///
  /// In ko, this message translates to:
  /// **'따뜻한 위로와 깊은 공감을 전합니다.'**
  String get onboarding_personality_compassionate_description;

  /// No description provided for @onboarding_personality_hint.
  ///
  /// In ko, this message translates to:
  /// **'설정에서 언제든지 바꿀 수 있습니다.'**
  String get onboarding_personality_hint;

  /// No description provided for @onboarding_success_title.
  ///
  /// In ko, this message translates to:
  /// **'시작할 준비가 되었어요!'**
  String get onboarding_success_title;

  /// No description provided for @onboarding_success_description.
  ///
  /// In ko, this message translates to:
  /// **'무드로그를 시작해볼까요?'**
  String get onboarding_success_description;

  /// No description provided for @onboarding_success_next.
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get onboarding_success_next;

  /// No description provided for @signin_title.
  ///
  /// In ko, this message translates to:
  /// **'시작할 준비가 되었어요!'**
  String get signin_title;

  /// No description provided for @signin_growth.
  ///
  /// In ko, this message translates to:
  /// **'성장하는 마음을 기록하세요.'**
  String get signin_growth;

  /// No description provided for @signin_login_title.
  ///
  /// In ko, this message translates to:
  /// **'가입하여 기록을 저장하세요.'**
  String get signin_login_title;

  /// No description provided for @signin_button_guest.
  ///
  /// In ko, this message translates to:
  /// **'게스트로 시작하기'**
  String get signin_button_guest;

  /// No description provided for @signin_button_google.
  ///
  /// In ko, this message translates to:
  /// **'구글 아이디로 시작하기'**
  String get signin_button_google;

  /// No description provided for @signin_button_kakao.
  ///
  /// In ko, this message translates to:
  /// **'카카오 아이디로 시작하기'**
  String get signin_button_kakao;

  /// No description provided for @home_hello.
  ///
  /// In ko, this message translates to:
  /// **'안녕하세요!'**
  String get home_hello;

  /// No description provided for @home_welcome.
  ///
  /// In ko, this message translates to:
  /// **'{nickname} 님.'**
  String home_welcome(Object nickname);

  /// No description provided for @home_howareyou.
  ///
  /// In ko, this message translates to:
  /// **'오늘 기분은 어떠세요?'**
  String get home_howareyou;

  /// No description provided for @home_empty_box.
  ///
  /// In ko, this message translates to:
  /// **'당신의 이야기를 기다리고 있어요.'**
  String get home_empty_box;

  /// No description provided for @entries_empty_box_title.
  ///
  /// In ko, this message translates to:
  /// **'작성된 일기가 없습니다.'**
  String get entries_empty_box_title;

  /// No description provided for @entries_empty_box_description.
  ///
  /// In ko, this message translates to:
  /// **'작성한 일기가 이곳에 나타납니다.'**
  String get entries_empty_box_description;

  /// No description provided for @entries_empty_box_button.
  ///
  /// In ko, this message translates to:
  /// **'일기 작성하러 가기'**
  String get entries_empty_box_button;

  /// No description provided for @entries_calendar_legend_has_journal.
  ///
  /// In ko, this message translates to:
  /// **'일기 있음'**
  String get entries_calendar_legend_has_journal;

  /// No description provided for @entries_calendar_legend_today.
  ///
  /// In ko, this message translates to:
  /// **'오늘'**
  String get entries_calendar_legend_today;

  /// No description provided for @tab_home.
  ///
  /// In ko, this message translates to:
  /// **'홈'**
  String get tab_home;

  /// No description provided for @tab_entries.
  ///
  /// In ko, this message translates to:
  /// **'기록'**
  String get tab_entries;

  /// No description provided for @tab_settings.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get tab_settings;

  /// No description provided for @tab_write.
  ///
  /// In ko, this message translates to:
  /// **'글쓰기'**
  String get tab_write;

  /// No description provided for @tab_statistics.
  ///
  /// In ko, this message translates to:
  /// **'통계'**
  String get tab_statistics;

  /// No description provided for @write_mood_title.
  ///
  /// In ko, this message translates to:
  /// **'오늘의 기분은 어떠신가요?'**
  String get write_mood_title;

  /// No description provided for @write_input_title.
  ///
  /// In ko, this message translates to:
  /// **'내용'**
  String get write_input_title;

  /// No description provided for @write_input_hint.
  ///
  /// In ko, this message translates to:
  /// **'오늘의 감정과 경험을 기록해보세요.'**
  String get write_input_hint;

  /// No description provided for @write_ai_title.
  ///
  /// In ko, this message translates to:
  /// **'AI 위로 메시지'**
  String get write_ai_title;

  /// No description provided for @write_ai_description.
  ///
  /// In ko, this message translates to:
  /// **'일기 작성 후 AI가 위로와 격려의 메시지를 보내드려요.'**
  String get write_ai_description;

  /// No description provided for @write_location_remove.
  ///
  /// In ko, this message translates to:
  /// **'제거'**
  String get write_location_remove;

  /// No description provided for @journal_delete_confirm_title.
  ///
  /// In ko, this message translates to:
  /// **'삭제 확인'**
  String get journal_delete_confirm_title;

  /// No description provided for @journal_delete_confirm_description.
  ///
  /// In ko, this message translates to:
  /// **'이 항목을 삭제하시겠습니까?'**
  String get journal_delete_confirm_description;

  /// No description provided for @journal_ai_generating_response_title.
  ///
  /// In ko, this message translates to:
  /// **'AI가 답변을 작성 중입니다.'**
  String get journal_ai_generating_response_title;

  /// No description provided for @statistics_total_title.
  ///
  /// In ko, this message translates to:
  /// **'전체 통계'**
  String get statistics_total_title;

  /// No description provided for @statistics_total_record_description.
  ///
  /// In ko, this message translates to:
  /// **'총 기록'**
  String get statistics_total_record_description;

  /// 총 기록
  ///
  /// In ko, this message translates to:
  /// **'{count}개'**
  String statistics_total_record(Object count);

  /// No description provided for @statistics_total_streak_description.
  ///
  /// In ko, this message translates to:
  /// **'연속 기록'**
  String get statistics_total_streak_description;

  /// 연속 기록
  ///
  /// In ko, this message translates to:
  /// **'{count}일'**
  String statistics_total_streak(Object count);

  /// No description provided for @statistics_total_streak_max_description.
  ///
  /// In ko, this message translates to:
  /// **'최대 연속 기록'**
  String get statistics_total_streak_max_description;

  /// 최대 연속 기록
  ///
  /// In ko, this message translates to:
  /// **'{count}일'**
  String statistics_total_streak_max(Object count);

  /// No description provided for @statistics_mood_calendar_title.
  ///
  /// In ko, this message translates to:
  /// **'감정 달력'**
  String get statistics_mood_calendar_title;

  /// No description provided for @statistics_mood_distribution_title.
  ///
  /// In ko, this message translates to:
  /// **'기분 분포'**
  String get statistics_mood_distribution_title;

  /// 횟수
  ///
  /// In ko, this message translates to:
  /// **'{count}회'**
  String statistics_mood_distribution_unit(Object count);

  /// No description provided for @statistics_mood_trend_title.
  ///
  /// In ko, this message translates to:
  /// **'기분 추이'**
  String get statistics_mood_trend_title;

  /// No description provided for @statistics_mood_trend_empty.
  ///
  /// In ko, this message translates to:
  /// **'기분 추이 데이터가 없습니다.'**
  String get statistics_mood_trend_empty;

  /// No description provided for @statistics_recent_title.
  ///
  /// In ko, this message translates to:
  /// **'최근 일기'**
  String get statistics_recent_title;

  /// No description provided for @statistics_recent_empty.
  ///
  /// In ko, this message translates to:
  /// **'최근 일기가 없습니다.'**
  String get statistics_recent_empty;

  /// No description provided for @settings_title.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settings_title;

  /// No description provided for @settings_common_title.
  ///
  /// In ko, this message translates to:
  /// **'일반'**
  String get settings_common_title;

  /// No description provided for @settings_common_notification_title.
  ///
  /// In ko, this message translates to:
  /// **'알림'**
  String get settings_common_notification_title;

  /// No description provided for @settings_common_notification_subtitle.
  ///
  /// In ko, this message translates to:
  /// **'푸시 알림을 받습니다.'**
  String get settings_common_notification_subtitle;

  /// No description provided for @settings_common_theme_title.
  ///
  /// In ko, this message translates to:
  /// **'테마'**
  String get settings_common_theme_title;

  /// No description provided for @settings_common_theme_subtitle.
  ///
  /// In ko, this message translates to:
  /// **'밝기 테마를 선택합니다.'**
  String get settings_common_theme_subtitle;

  /// No description provided for @settings_common_theme_light.
  ///
  /// In ko, this message translates to:
  /// **'밝은 테마'**
  String get settings_common_theme_light;

  /// No description provided for @settings_common_theme_dark.
  ///
  /// In ko, this message translates to:
  /// **'어두운 테마'**
  String get settings_common_theme_dark;

  /// No description provided for @settings_common_theme_system.
  ///
  /// In ko, this message translates to:
  /// **'시스템 테마'**
  String get settings_common_theme_system;

  /// No description provided for @settings_common_color_theme_title.
  ///
  /// In ko, this message translates to:
  /// **'색상 테마'**
  String get settings_common_color_theme_title;

  /// No description provided for @settings_common_color_theme_subtitle.
  ///
  /// In ko, this message translates to:
  /// **'색상 테마를 선택합니다.'**
  String get settings_common_color_theme_subtitle;

  /// No description provided for @settings_common_language_title.
  ///
  /// In ko, this message translates to:
  /// **'언어'**
  String get settings_common_language_title;

  /// No description provided for @settings_common_language_dialog_title.
  ///
  /// In ko, this message translates to:
  /// **'언어 선택'**
  String get settings_common_language_dialog_title;

  /// No description provided for @settings_common_font_family_title.
  ///
  /// In ko, this message translates to:
  /// **'폰트'**
  String get settings_common_font_family_title;

  /// No description provided for @settings_common_font_family_pretendard.
  ///
  /// In ko, this message translates to:
  /// **'프리텐다드'**
  String get settings_common_font_family_pretendard;

  /// No description provided for @settings_common_font_family_leeSeoyun.
  ///
  /// In ko, this message translates to:
  /// **'이서윤체'**
  String get settings_common_font_family_leeSeoyun;

  /// No description provided for @settings_common_font_family_orbitOfTheMoon.
  ///
  /// In ko, this message translates to:
  /// **'나눔손글씨 달의궤도'**
  String get settings_common_font_family_orbitOfTheMoon;

  /// No description provided for @settings_common_font_family_restart.
  ///
  /// In ko, this message translates to:
  /// **'나눔손글씨 다시 시작해'**
  String get settings_common_font_family_restart;

  /// No description provided for @settings_common_font_family_overcome.
  ///
  /// In ko, this message translates to:
  /// **'나눔손글씨 나는 이겨낸다'**
  String get settings_common_font_family_overcome;

  /// No description provided for @settings_common_font_family_system.
  ///
  /// In ko, this message translates to:
  /// **'시스템 기본'**
  String get settings_common_font_family_system;

  /// No description provided for @settings_data_title.
  ///
  /// In ko, this message translates to:
  /// **'데이터'**
  String get settings_data_title;

  /// No description provided for @settings_data_auto_sync_title.
  ///
  /// In ko, this message translates to:
  /// **'자동 동기화'**
  String get settings_data_auto_sync_title;

  /// No description provided for @settings_data_auto_sync_subtitle.
  ///
  /// In ko, this message translates to:
  /// **'데이터를 자동으로 동기화합니다.'**
  String get settings_data_auto_sync_subtitle;

  /// No description provided for @settings_data_backup_title.
  ///
  /// In ko, this message translates to:
  /// **'데이터 백업'**
  String get settings_data_backup_title;

  /// No description provided for @settings_data_backup_subtitle.
  ///
  /// In ko, this message translates to:
  /// **'데이터를 백업합니다.'**
  String get settings_data_backup_subtitle;

  /// No description provided for @settings_data_backup_confirm.
  ///
  /// In ko, this message translates to:
  /// **'데이터 백업하시겠습니까?'**
  String get settings_data_backup_confirm;

  /// No description provided for @settings_data_backup_confirm_ok.
  ///
  /// In ko, this message translates to:
  /// **'백업'**
  String get settings_data_backup_confirm_ok;

  /// No description provided for @settings_data_cache_cleanup_title.
  ///
  /// In ko, this message translates to:
  /// **'캐시 정리'**
  String get settings_data_cache_cleanup_title;

  /// No description provided for @settings_data_cache_cleanup_subtitle.
  ///
  /// In ko, this message translates to:
  /// **'임시 파일을 삭제합니다.'**
  String get settings_data_cache_cleanup_subtitle;

  /// No description provided for @settings_data_cache_cleanup_confirm.
  ///
  /// In ko, this message translates to:
  /// **'캐시를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'**
  String get settings_data_cache_cleanup_confirm;

  /// No description provided for @settings_ai_personality_changed.
  ///
  /// In ko, this message translates to:
  /// **'AI 성격이 변경되었습니다.'**
  String get settings_ai_personality_changed;

  /// No description provided for @settings_information_title.
  ///
  /// In ko, this message translates to:
  /// **'정보'**
  String get settings_information_title;

  /// No description provided for @settings_information_app_title.
  ///
  /// In ko, this message translates to:
  /// **'앱 정보'**
  String get settings_information_app_title;

  /// No description provided for @settings_information_app_subtitle.
  ///
  /// In ko, this message translates to:
  /// **'버전 및 라이선스 정보'**
  String get settings_information_app_subtitle;

  /// No description provided for @settings_information_app_version.
  ///
  /// In ko, this message translates to:
  /// **'버전'**
  String get settings_information_app_version;

  /// No description provided for @settings_information_app_build.
  ///
  /// In ko, this message translates to:
  /// **'라이선스'**
  String get settings_information_app_build;

  /// No description provided for @settings_information_app_developer.
  ///
  /// In ko, this message translates to:
  /// **'개발자'**
  String get settings_information_app_developer;

  /// No description provided for @settings_information_faq_title.
  ///
  /// In ko, this message translates to:
  /// **'도움말'**
  String get settings_information_faq_title;

  /// No description provided for @settings_information_faq_subtitle.
  ///
  /// In ko, this message translates to:
  /// **'사용법 및 FAQ'**
  String get settings_information_faq_subtitle;

  /// No description provided for @settings_information_qna_title.
  ///
  /// In ko, this message translates to:
  /// **'문의하기'**
  String get settings_information_qna_title;

  /// No description provided for @settings_information_qna_subtitle.
  ///
  /// In ko, this message translates to:
  /// **'개발자에게 문의합니다.'**
  String get settings_information_qna_subtitle;

  /// No description provided for @profile_title.
  ///
  /// In ko, this message translates to:
  /// **'프로필'**
  String get profile_title;

  /// No description provided for @profile_account_title.
  ///
  /// In ko, this message translates to:
  /// **'가입 정보'**
  String get profile_account_title;

  /// No description provided for @profile_nickname_title.
  ///
  /// In ko, this message translates to:
  /// **'닉네임 변경'**
  String get profile_nickname_title;

  /// No description provided for @profile_nickname_hint.
  ///
  /// In ko, this message translates to:
  /// **'새 닉네임을 입력하세요.'**
  String get profile_nickname_hint;

  /// No description provided for @profile_creation_time_title.
  ///
  /// In ko, this message translates to:
  /// **'가입일'**
  String get profile_creation_time_title;

  /// No description provided for @profile_uid_title.
  ///
  /// In ko, this message translates to:
  /// **'유저 ID'**
  String get profile_uid_title;

  /// No description provided for @profile_button_login.
  ///
  /// In ko, this message translates to:
  /// **'로그인 하러 가기'**
  String get profile_button_login;

  /// No description provided for @profile_button_logout.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃'**
  String get profile_button_logout;

  /// No description provided for @write_ai_limit_reached.
  ///
  /// In ko, this message translates to:
  /// **'AI 답변은 하루에 한 번만 가능합니다. 내일 다시 시도해주세요!'**
  String get write_ai_limit_reached;

  /// No description provided for @write_timestamp_add.
  ///
  /// In ko, this message translates to:
  /// **'시간 추가'**
  String get write_timestamp_add;

  /// No description provided for @write_location_add.
  ///
  /// In ko, this message translates to:
  /// **'위치 추가'**
  String get write_location_add;

  /// No description provided for @common_language_korean.
  ///
  /// In ko, this message translates to:
  /// **'한국어'**
  String get common_language_korean;

  /// No description provided for @common_language_english.
  ///
  /// In ko, this message translates to:
  /// **'English'**
  String get common_language_english;

  /// No description provided for @common_language_japanese.
  ///
  /// In ko, this message translates to:
  /// **'日本語'**
  String get common_language_japanese;

  /// No description provided for @common_language_chinese.
  ///
  /// In ko, this message translates to:
  /// **'中文'**
  String get common_language_chinese;

  /// No description provided for @common_language_spanish.
  ///
  /// In ko, this message translates to:
  /// **'Español'**
  String get common_language_spanish;

  /// No description provided for @common_language_italian.
  ///
  /// In ko, this message translates to:
  /// **'Italiano'**
  String get common_language_italian;

  /// No description provided for @common_language_french.
  ///
  /// In ko, this message translates to:
  /// **'Français'**
  String get common_language_french;

  /// No description provided for @common_language_vietnamese.
  ///
  /// In ko, this message translates to:
  /// **'Tiếng Việt'**
  String get common_language_vietnamese;

  /// No description provided for @common_language_thai.
  ///
  /// In ko, this message translates to:
  /// **'ไทย'**
  String get common_language_thai;

  /// No description provided for @common_developing.
  ///
  /// In ko, this message translates to:
  /// **'개발중'**
  String get common_developing;

  /// No description provided for @settings_user_info_title.
  ///
  /// In ko, this message translates to:
  /// **'로그인 정보'**
  String get settings_user_info_title;

  /// No description provided for @settings_user_info_empty.
  ///
  /// In ko, this message translates to:
  /// **'로그인 정보가 없습니다.'**
  String get settings_user_info_empty;

  /// No description provided for @settings_user_info_status.
  ///
  /// In ko, this message translates to:
  /// **'상태'**
  String get settings_user_info_status;

  /// No description provided for @settings_user_info_anonymous.
  ///
  /// In ko, this message translates to:
  /// **'익명 로그인'**
  String get settings_user_info_anonymous;

  /// No description provided for @settings_user_info_logged_in.
  ///
  /// In ko, this message translates to:
  /// **'로그인'**
  String get settings_user_info_logged_in;

  /// No description provided for @dialog_storage_init_title.
  ///
  /// In ko, this message translates to:
  /// **'스토리지 초기화'**
  String get dialog_storage_init_title;

  /// No description provided for @dialog_storage_init_content.
  ///
  /// In ko, this message translates to:
  /// **'SharedPreferences를 초기화합니다.'**
  String get dialog_storage_init_content;

  /// No description provided for @dialog_database_init_title.
  ///
  /// In ko, this message translates to:
  /// **'데이터베이스 초기화'**
  String get dialog_database_init_title;

  /// No description provided for @dialog_database_init_content.
  ///
  /// In ko, this message translates to:
  /// **'SQLite 데이터베이스를 초기화합니다.'**
  String get dialog_database_init_content;

  /// No description provided for @dialog_init_button.
  ///
  /// In ko, this message translates to:
  /// **'초기화'**
  String get dialog_init_button;

  /// No description provided for @settings_developer_options.
  ///
  /// In ko, this message translates to:
  /// **'개발용 옵션'**
  String get settings_developer_options;

  /// No description provided for @settings_developer_mode_only.
  ///
  /// In ko, this message translates to:
  /// **'개발모드 전용 동작'**
  String get settings_developer_mode_only;

  /// No description provided for @settings_ai_section_title.
  ///
  /// In ko, this message translates to:
  /// **'AI 설정'**
  String get settings_ai_section_title;

  /// No description provided for @settings_ai_personality_title.
  ///
  /// In ko, this message translates to:
  /// **'AI 성격'**
  String get settings_ai_personality_title;

  /// No description provided for @snackbar_backup_completed.
  ///
  /// In ko, this message translates to:
  /// **'백업이 완료되었습니다.'**
  String get snackbar_backup_completed;

  /// No description provided for @snackbar_cache_cleared.
  ///
  /// In ko, this message translates to:
  /// **'캐시가 삭제되었습니다.'**
  String get snackbar_cache_cleared;

  /// No description provided for @navigation_home.
  ///
  /// In ko, this message translates to:
  /// **'홈'**
  String get navigation_home;

  /// No description provided for @navigation_entries.
  ///
  /// In ko, this message translates to:
  /// **'기록'**
  String get navigation_entries;

  /// No description provided for @navigation_write.
  ///
  /// In ko, this message translates to:
  /// **'글쓰기'**
  String get navigation_write;

  /// No description provided for @navigation_statistics.
  ///
  /// In ko, this message translates to:
  /// **'통계'**
  String get navigation_statistics;

  /// No description provided for @navigation_settings.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get navigation_settings;

  /// No description provided for @auth_terms_message.
  ///
  /// In ko, this message translates to:
  /// **'계속 함으로써 {terms}과 {privacy}에 동의합니다.'**
  String auth_terms_message(String terms, String privacy);

  /// No description provided for @auth_terms_of_service.
  ///
  /// In ko, this message translates to:
  /// **'이용약관'**
  String get auth_terms_of_service;

  /// No description provided for @auth_privacy_policy.
  ///
  /// In ko, this message translates to:
  /// **'개인정보처리방침'**
  String get auth_privacy_policy;

  /// No description provided for @app_info_copyright.
  ///
  /// In ko, this message translates to:
  /// **'© 2024 All rights reserved'**
  String get app_info_copyright;

  /// No description provided for @app_info_developer.
  ///
  /// In ko, this message translates to:
  /// **'Your Name'**
  String get app_info_developer;

  /// No description provided for @profile_sign_out_title.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃'**
  String get profile_sign_out_title;

  /// No description provided for @profile_sign_out_message.
  ///
  /// In ko, this message translates to:
  /// **'정말로 로그아웃하시겠습니까?'**
  String get profile_sign_out_message;

  /// No description provided for @journal_count.
  ///
  /// In ko, this message translates to:
  /// **'{count}개'**
  String journal_count(int count);

  /// No description provided for @location_current.
  ///
  /// In ko, this message translates to:
  /// **'현재 위치'**
  String get location_current;

  /// No description provided for @location_add_location.
  ///
  /// In ko, this message translates to:
  /// **'위치 추가하기'**
  String get location_add_location;

  /// No description provided for @tags_manage_title.
  ///
  /// In ko, this message translates to:
  /// **'태그 관리'**
  String get tags_manage_title;

  /// No description provided for @tags_manage_subtitle.
  ///
  /// In ko, this message translates to:
  /// **'태그를 보고 관리하세요'**
  String get tags_manage_subtitle;

  /// No description provided for @tags_filter_all.
  ///
  /// In ko, this message translates to:
  /// **'전체'**
  String get tags_filter_all;

  /// No description provided for @tags_filter_title.
  ///
  /// In ko, this message translates to:
  /// **'태그로 필터링'**
  String get tags_filter_title;

  /// No description provided for @tags_suggested_title.
  ///
  /// In ko, this message translates to:
  /// **'추천 태그'**
  String get tags_suggested_title;

  /// No description provided for @tags_add_new.
  ///
  /// In ko, this message translates to:
  /// **'새 태그 추가'**
  String get tags_add_new;

  /// No description provided for @tags_input_hint.
  ///
  /// In ko, this message translates to:
  /// **'태그 이름'**
  String get tags_input_hint;

  /// No description provided for @tags_delete_title.
  ///
  /// In ko, this message translates to:
  /// **'태그 삭제'**
  String get tags_delete_title;

  /// No description provided for @tags_delete_message.
  ///
  /// In ko, this message translates to:
  /// **'\"{tagName}\"을(를) 삭제하시겠습니까? 모든 일기에서 이 태그가 제거됩니다.'**
  String tags_delete_message(String tagName);

  /// No description provided for @tags_delete_success.
  ///
  /// In ko, this message translates to:
  /// **'태그 \"{tagName}\"이(가) 삭제되었습니다'**
  String tags_delete_success(String tagName);

  /// No description provided for @tags_no_tags.
  ///
  /// In ko, this message translates to:
  /// **'태그가 없습니다'**
  String get tags_no_tags;

  /// No description provided for @tags_load_failed.
  ///
  /// In ko, this message translates to:
  /// **'태그를 불러오지 못했습니다'**
  String get tags_load_failed;

  /// No description provided for @tags_delete_failed.
  ///
  /// In ko, this message translates to:
  /// **'태그 삭제에 실패했습니다'**
  String get tags_delete_failed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'ko',
    'th',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'th':
      return AppLocalizationsTh();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
