import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ko.dart';

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
  static const List<Locale> supportedLocales = <Locale>[Locale('ko')];

  /// No description provided for @onboarding_welcome_title.
  ///
  /// In ko, this message translates to:
  /// **'무드로그에 오신것을 환영합니다!'**
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
  /// **'당신의 일기에 답장해줄 AI의 친절도를 선택하세요.'**
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

  /// No description provided for @onboarding_success_button.
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get onboarding_success_button;

  /// No description provided for @home_hello.
  ///
  /// In ko, this message translates to:
  /// **'안녕하세요!'**
  String get home_hello;

  /// userName
  ///
  /// In ko, this message translates to:
  /// **'{userName}님.'**
  String home_welcome(Object userName);

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

  /// No description provided for @journal_delete_confirm_delete.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get journal_delete_confirm_delete;

  /// No description provided for @journal_delete_confirm_cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get journal_delete_confirm_cancel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
