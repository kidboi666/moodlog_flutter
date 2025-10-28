import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
  ];

  /// No description provided for @common_date_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get common_date_today;

  /// No description provided for @common_date_tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get common_date_tomorrow;

  /// No description provided for @common_date_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get common_date_yesterday;

  /// No description provided for @common_date_full.
  ///
  /// In en, this message translates to:
  /// **'MMM dd, yyyy'**
  String get common_date_full;

  /// No description provided for @common_confirm_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_confirm_cancel;

  /// No description provided for @common_confirm_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get common_confirm_ok;

  /// No description provided for @common_confirm_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_confirm_delete;

  /// No description provided for @common_confirm_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_confirm_save;

  /// No description provided for @common_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get common_reset;

  /// No description provided for @common_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get common_email;

  /// No description provided for @common_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get common_phone;

  /// No description provided for @common_mood_verygood.
  ///
  /// In en, this message translates to:
  /// **'Very Good'**
  String get common_mood_verygood;

  /// No description provided for @common_mood_good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get common_mood_good;

  /// No description provided for @common_mood_neutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get common_mood_neutral;

  /// No description provided for @common_mood_bad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get common_mood_bad;

  /// No description provided for @common_mood_verybad.
  ///
  /// In en, this message translates to:
  /// **'Very Bad'**
  String get common_mood_verybad;

  /// No description provided for @common_month_jan.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get common_month_jan;

  /// No description provided for @common_month_feb.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get common_month_feb;

  /// No description provided for @common_month_mar.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get common_month_mar;

  /// No description provided for @common_month_apr.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get common_month_apr;

  /// No description provided for @common_month_may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get common_month_may;

  /// No description provided for @common_month_jun.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get common_month_jun;

  /// No description provided for @common_month_jul.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get common_month_jul;

  /// No description provided for @common_month_aug.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get common_month_aug;

  /// No description provided for @common_month_sep.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get common_month_sep;

  /// No description provided for @common_month_oct.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get common_month_oct;

  /// No description provided for @common_month_nov.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get common_month_nov;

  /// No description provided for @common_month_dec.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get common_month_dec;

  /// No description provided for @common_weekday_mon.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get common_weekday_mon;

  /// No description provided for @common_weekday_tue.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get common_weekday_tue;

  /// No description provided for @common_weekday_wed.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get common_weekday_wed;

  /// No description provided for @common_weekday_thu.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get common_weekday_thu;

  /// No description provided for @common_weekday_fri.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get common_weekday_fri;

  /// No description provided for @common_weekday_sat.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get common_weekday_sat;

  /// No description provided for @common_weekday_sun.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get common_weekday_sun;

  /// No description provided for @common_weekday_mon_short.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get common_weekday_mon_short;

  /// No description provided for @common_weekday_tue_short.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get common_weekday_tue_short;

  /// No description provided for @common_weekday_wed_short.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get common_weekday_wed_short;

  /// No description provided for @common_weekday_thu_short.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get common_weekday_thu_short;

  /// No description provided for @common_weekday_fri_short.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get common_weekday_fri_short;

  /// No description provided for @common_weekday_sat_short.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get common_weekday_sat_short;

  /// No description provided for @common_weekday_sun_short.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get common_weekday_sun_short;

  /// No description provided for @onboarding_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get onboarding_welcome_title;

  /// No description provided for @onboarding_welcome_description1.
  ///
  /// In en, this message translates to:
  /// **'MoodLog is an app that lets you record your daily emotions and receive AI responses to them.'**
  String get onboarding_welcome_description1;

  /// No description provided for @onboarding_welcome_description2.
  ///
  /// In en, this message translates to:
  /// **'Record your emotions daily and read the AI\'s responses.'**
  String get onboarding_welcome_description2;

  /// No description provided for @onboarding_welcome_next.
  ///
  /// In en, this message translates to:
  /// **'Shall we get started together?'**
  String get onboarding_welcome_next;

  /// No description provided for @onboarding_nickname_title.
  ///
  /// In en, this message translates to:
  /// **'Set Nickname'**
  String get onboarding_nickname_title;

  /// No description provided for @onboarding_nickname_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter the nickname you want to use in MoodLog'**
  String get onboarding_nickname_description;

  /// No description provided for @onboarding_nickname_input_title.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get onboarding_nickname_input_title;

  /// No description provided for @onboarding_nickname_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter nickname (2-10 characters)'**
  String get onboarding_nickname_input_hint;

  /// No description provided for @onboarding_nickname_next.
  ///
  /// In en, this message translates to:
  /// **'You can change your nickname anytime in the settings menu.'**
  String get onboarding_nickname_next;

  /// No description provided for @onboarding_nickname_input_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a nickname.'**
  String get onboarding_nickname_input_error;

  /// No description provided for @onboarding_personality_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Response Style'**
  String get onboarding_personality_title;

  /// No description provided for @onboarding_personality_description.
  ///
  /// In en, this message translates to:
  /// **'Choose the AI personality that will respond to your diary.'**
  String get onboarding_personality_description;

  /// No description provided for @onboarding_personality_rational_title.
  ///
  /// In en, this message translates to:
  /// **'Rational Analyst'**
  String get onboarding_personality_rational_title;

  /// No description provided for @onboarding_personality_rational_description.
  ///
  /// In en, this message translates to:
  /// **'Provides objective and practical advice'**
  String get onboarding_personality_rational_description;

  /// No description provided for @onboarding_personality_balanced_title.
  ///
  /// In en, this message translates to:
  /// **'Balanced Advisor'**
  String get onboarding_personality_balanced_title;

  /// No description provided for @onboarding_personality_balanced_description.
  ///
  /// In en, this message translates to:
  /// **'Balances empathy with realistic advice.'**
  String get onboarding_personality_balanced_description;

  /// No description provided for @onboarding_personality_compassionate_title.
  ///
  /// In en, this message translates to:
  /// **'Compassionate Healer'**
  String get onboarding_personality_compassionate_title;

  /// No description provided for @onboarding_personality_compassionate_description.
  ///
  /// In en, this message translates to:
  /// **'Delivers warm comfort and deep empathy.'**
  String get onboarding_personality_compassionate_description;

  /// No description provided for @onboarding_personality_hint.
  ///
  /// In en, this message translates to:
  /// **'You can change this anytime in settings.'**
  String get onboarding_personality_hint;

  /// No description provided for @onboarding_success_title.
  ///
  /// In en, this message translates to:
  /// **'Ready to start!'**
  String get onboarding_success_title;

  /// No description provided for @onboarding_success_description.
  ///
  /// In en, this message translates to:
  /// **'Shall we start MoodLog?'**
  String get onboarding_success_description;

  /// No description provided for @onboarding_success_next.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboarding_success_next;

  /// No description provided for @signin_title.
  ///
  /// In en, this message translates to:
  /// **'Ready to start!'**
  String get signin_title;

  /// No description provided for @signin_growth.
  ///
  /// In en, this message translates to:
  /// **'Record your growing mind.'**
  String get signin_growth;

  /// No description provided for @signin_login_title.
  ///
  /// In en, this message translates to:
  /// **'Sign up to save your records.'**
  String get signin_login_title;

  /// No description provided for @signin_button_guest.
  ///
  /// In en, this message translates to:
  /// **'Start as Guest'**
  String get signin_button_guest;

  /// No description provided for @signin_button_google.
  ///
  /// In en, this message translates to:
  /// **'Start with Google'**
  String get signin_button_google;

  /// No description provided for @signin_button_apple.
  ///
  /// In en, this message translates to:
  /// **'Start with Apple'**
  String get signin_button_apple;

  /// No description provided for @home_hello.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get home_hello;

  /// No description provided for @home_welcome.
  ///
  /// In en, this message translates to:
  /// **'{nickname}.'**
  String home_welcome(Object nickname);

  /// No description provided for @home_howareyou.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get home_howareyou;

  /// No description provided for @home_empty_box.
  ///
  /// In en, this message translates to:
  /// **'Waiting for your story.'**
  String get home_empty_box;

  /// No description provided for @entries_empty_box_title.
  ///
  /// In en, this message translates to:
  /// **'No diary entries yet.'**
  String get entries_empty_box_title;

  /// No description provided for @entries_empty_box_description.
  ///
  /// In en, this message translates to:
  /// **'Your written entries will appear here.'**
  String get entries_empty_box_description;

  /// No description provided for @entries_empty_box_button.
  ///
  /// In en, this message translates to:
  /// **'Go write a diary entry'**
  String get entries_empty_box_button;

  /// No description provided for @entries_empty_box_check_in_button.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get entries_empty_box_check_in_button;

  /// No description provided for @entries_calendar_legend_has_journal.
  ///
  /// In en, this message translates to:
  /// **'Has entry'**
  String get entries_calendar_legend_has_journal;

  /// No description provided for @entries_calendar_legend_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get entries_calendar_legend_today;

  /// No description provided for @tab_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tab_home;

  /// No description provided for @drawer_activities.
  ///
  /// In en, this message translates to:
  /// **'Manage Activities'**
  String get drawer_activities;

  /// No description provided for @drawer_review.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get drawer_review;

  /// No description provided for @empty_box_write_options_title.
  ///
  /// In en, this message translates to:
  /// **'Which date would you like to write for?'**
  String get empty_box_write_options_title;

  /// No description provided for @empty_box_write_for_selected_date.
  ///
  /// In en, this message translates to:
  /// **'Write for {date}'**
  String empty_box_write_for_selected_date(String date);

  /// No description provided for @empty_box_write_for_today.
  ///
  /// In en, this message translates to:
  /// **'Write for today'**
  String get empty_box_write_for_today;

  /// No description provided for @activities_empty.
  ///
  /// In en, this message translates to:
  /// **'No activities found.'**
  String get activities_empty;

  /// No description provided for @activities_error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String activities_error(String error);

  /// No description provided for @activities_journal_count.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =1{1 journal}other{{count} journals}}'**
  String activities_journal_count(int count);

  /// No description provided for @default_activity_daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get default_activity_daily;

  /// No description provided for @default_activity_work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get default_activity_work;

  /// No description provided for @default_activity_health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get default_activity_health;

  /// No description provided for @default_activity_relationships.
  ///
  /// In en, this message translates to:
  /// **'Relationships'**
  String get default_activity_relationships;

  /// No description provided for @default_activity_hobby.
  ///
  /// In en, this message translates to:
  /// **'Hobby'**
  String get default_activity_hobby;

  /// No description provided for @default_activity_emotions.
  ///
  /// In en, this message translates to:
  /// **'Emotions'**
  String get default_activity_emotions;

  /// No description provided for @tab_entries.
  ///
  /// In en, this message translates to:
  /// **'Entries'**
  String get tab_entries;

  /// No description provided for @tab_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tab_settings;

  /// No description provided for @tab_write.
  ///
  /// In en, this message translates to:
  /// **'Write'**
  String get tab_write;

  /// No description provided for @tab_statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get tab_statistics;

  /// No description provided for @write_title.
  ///
  /// In en, this message translates to:
  /// **'Write Diary'**
  String get write_title;

  /// No description provided for @write_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Diary'**
  String get write_edit_title;

  /// No description provided for @write_mood_title.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get write_mood_title;

  /// No description provided for @write_mood_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please select your mood'**
  String get write_mood_subtitle;

  /// No description provided for @write_input_title.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get write_input_title;

  /// No description provided for @write_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Record today\'s emotions and experiences.'**
  String get write_input_hint;

  /// No description provided for @write_ai_title.
  ///
  /// In en, this message translates to:
  /// **'AI Comfort Message'**
  String get write_ai_title;

  /// No description provided for @write_ai_description.
  ///
  /// In en, this message translates to:
  /// **'After writing your diary, AI will send you a message of comfort and encouragement.'**
  String get write_ai_description;

  /// No description provided for @write_location_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get write_location_remove;

  /// No description provided for @journal_delete_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get journal_delete_confirm_title;

  /// No description provided for @journal_delete_confirm_description.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this entry?'**
  String get journal_delete_confirm_description;

  /// No description provided for @journal_ai_generating_response_title.
  ///
  /// In en, this message translates to:
  /// **'AI is analyzing your journal...'**
  String get journal_ai_generating_response_title;

  /// No description provided for @journal_ai_generating_response_error.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate AI response.'**
  String get journal_ai_generating_response_error;

  /// No description provided for @journal_menu_change_align.
  ///
  /// In en, this message translates to:
  /// **'Change Alignment'**
  String get journal_menu_change_align;

  /// No description provided for @journal_menu_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get journal_menu_edit;

  /// No description provided for @journal_menu_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get journal_menu_delete;

  /// No description provided for @statistics_total_title.
  ///
  /// In en, this message translates to:
  /// **'Overall Statistics'**
  String get statistics_total_title;

  /// No description provided for @statistics_total_record_description.
  ///
  /// In en, this message translates to:
  /// **'Total Records'**
  String get statistics_total_record_description;

  /// Total records
  ///
  /// In en, this message translates to:
  /// **'{count} entries'**
  String statistics_total_record(Object count);

  /// No description provided for @statistics_total_streak_description.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get statistics_total_streak_description;

  /// Current streak
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String statistics_total_streak(Object count);

  /// No description provided for @statistics_total_streak_max_description.
  ///
  /// In en, this message translates to:
  /// **'Longest Streak'**
  String get statistics_total_streak_max_description;

  /// Longest streak
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String statistics_total_streak_max(Object count);

  /// No description provided for @statistics_mood_calendar_title.
  ///
  /// In en, this message translates to:
  /// **'Mood Calendar'**
  String get statistics_mood_calendar_title;

  /// No description provided for @statistics_mood_distribution_title.
  ///
  /// In en, this message translates to:
  /// **'Mood Distribution'**
  String get statistics_mood_distribution_title;

  /// Count
  ///
  /// In en, this message translates to:
  /// **'{count} times'**
  String statistics_mood_distribution_unit(Object count);

  /// No description provided for @statistics_mood_trend_title.
  ///
  /// In en, this message translates to:
  /// **'Mood Trend'**
  String get statistics_mood_trend_title;

  /// No description provided for @statistics_mood_trend_empty.
  ///
  /// In en, this message translates to:
  /// **'No mood trend data available.'**
  String get statistics_mood_trend_empty;

  /// No description provided for @statistics_recent_title.
  ///
  /// In en, this message translates to:
  /// **'Recent Entries'**
  String get statistics_recent_title;

  /// No description provided for @statistics_recent_empty.
  ///
  /// In en, this message translates to:
  /// **'No recent entries.'**
  String get statistics_recent_empty;

  /// No description provided for @statistics_total_records_count_unit.
  ///
  /// In en, this message translates to:
  /// **'records'**
  String get statistics_total_records_count_unit;

  /// No description provided for @statistics_total_records_first_record.
  ///
  /// In en, this message translates to:
  /// **'First Record'**
  String get statistics_total_records_first_record;

  /// No description provided for @statistics_total_records_period.
  ///
  /// In en, this message translates to:
  /// **'Recording Period'**
  String get statistics_total_records_period;

  /// No description provided for @statistics_total_records_period_days.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String statistics_total_records_period_days(int days);

  /// No description provided for @statistics_total_records_avg_frequency.
  ///
  /// In en, this message translates to:
  /// **'Average Frequency'**
  String get statistics_total_records_avg_frequency;

  /// No description provided for @statistics_total_records_weekly_frequency.
  ///
  /// In en, this message translates to:
  /// **'{frequency} times/week'**
  String statistics_total_records_weekly_frequency(String frequency);

  /// No description provided for @statistics_streak_status_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statistics_streak_status_active;

  /// No description provided for @statistics_streak_status_inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get statistics_streak_status_inactive;

  /// No description provided for @statistics_streak_last_record.
  ///
  /// In en, this message translates to:
  /// **'Last Record'**
  String get statistics_streak_last_record;

  /// No description provided for @statistics_streak_days_ago.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String statistics_streak_days_ago(int days);

  /// No description provided for @statistics_streak_stopped.
  ///
  /// In en, this message translates to:
  /// **'Streak Stopped'**
  String get statistics_streak_stopped;

  /// No description provided for @statistics_streak_stopped_days.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String statistics_streak_stopped_days(int days);

  /// No description provided for @statistics_streak_encouragement.
  ///
  /// In en, this message translates to:
  /// **'Great! You\'re keeping up your streak'**
  String get statistics_streak_encouragement;

  /// No description provided for @statistics_max_streak_new_record.
  ///
  /// In en, this message translates to:
  /// **'New Record!'**
  String get statistics_max_streak_new_record;

  /// No description provided for @statistics_max_streak_progress.
  ///
  /// In en, this message translates to:
  /// **'Current Progress'**
  String get statistics_max_streak_progress;

  /// No description provided for @statistics_max_streak_remaining.
  ///
  /// In en, this message translates to:
  /// **'To beat your record'**
  String get statistics_max_streak_remaining;

  /// No description provided for @statistics_max_streak_remaining_days.
  ///
  /// In en, this message translates to:
  /// **'{days} days to go'**
  String statistics_max_streak_remaining_days(int days);

  /// No description provided for @statistics_max_streak_achievement_week.
  ///
  /// In en, this message translates to:
  /// **'One week streak achieved! You\'re doing great!'**
  String get statistics_max_streak_achievement_week;

  /// No description provided for @statistics_max_streak_achievement_two_weeks.
  ///
  /// In en, this message translates to:
  /// **'Two weeks streak achieved! Excellent!'**
  String get statistics_max_streak_achievement_two_weeks;

  /// No description provided for @statistics_max_streak_achievement_month.
  ///
  /// In en, this message translates to:
  /// **'One month streak achieved! Amazing!'**
  String get statistics_max_streak_achievement_month;

  /// No description provided for @statistics_average_mood_title.
  ///
  /// In en, this message translates to:
  /// **'Average Mood'**
  String get statistics_average_mood_title;

  /// No description provided for @statistics_average_mood_score.
  ///
  /// In en, this message translates to:
  /// **'Average {score} points'**
  String statistics_average_mood_score(String score);

  /// No description provided for @statistics_average_mood_most_frequent.
  ///
  /// In en, this message translates to:
  /// **'Most frequent mood'**
  String get statistics_average_mood_most_frequent;

  /// No description provided for @statistics_average_mood_recent_trend.
  ///
  /// In en, this message translates to:
  /// **'Recent 7-day trend'**
  String get statistics_average_mood_recent_trend;

  /// No description provided for @statistics_trend_rising.
  ///
  /// In en, this message translates to:
  /// **'Rising'**
  String get statistics_trend_rising;

  /// No description provided for @statistics_trend_falling.
  ///
  /// In en, this message translates to:
  /// **'Falling'**
  String get statistics_trend_falling;

  /// No description provided for @statistics_trend_stable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get statistics_trend_stable;

  /// No description provided for @statistics_mood_positive_message.
  ///
  /// In en, this message translates to:
  /// **'You\'re maintaining a generally positive mood!'**
  String get statistics_mood_positive_message;

  /// No description provided for @statistics_mood_negative_message.
  ///
  /// In en, this message translates to:
  /// **'You\'re going through a tough time. Take some time to care for yourself.'**
  String get statistics_mood_negative_message;

  /// No description provided for @statistics_writing_frequency_title.
  ///
  /// In en, this message translates to:
  /// **'Writing Frequency'**
  String get statistics_writing_frequency_title;

  /// No description provided for @statistics_writing_frequency_this_week.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get statistics_writing_frequency_this_week;

  /// No description provided for @statistics_writing_frequency_count_unit.
  ///
  /// In en, this message translates to:
  /// **'times'**
  String get statistics_writing_frequency_count_unit;

  /// No description provided for @statistics_writing_frequency_daily.
  ///
  /// In en, this message translates to:
  /// **'Daily record!'**
  String get statistics_writing_frequency_daily;

  /// No description provided for @statistics_writing_frequency_often.
  ///
  /// In en, this message translates to:
  /// **'Frequent records'**
  String get statistics_writing_frequency_often;

  /// No description provided for @statistics_writing_frequency_normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get statistics_writing_frequency_normal;

  /// No description provided for @statistics_writing_frequency_sometimes.
  ///
  /// In en, this message translates to:
  /// **'Sometimes'**
  String get statistics_writing_frequency_sometimes;

  /// No description provided for @statistics_writing_frequency_none.
  ///
  /// In en, this message translates to:
  /// **'No records'**
  String get statistics_writing_frequency_none;

  /// No description provided for @statistics_writing_frequency_weekly_avg.
  ///
  /// In en, this message translates to:
  /// **'Weekly avg'**
  String get statistics_writing_frequency_weekly_avg;

  /// No description provided for @statistics_writing_frequency_monthly_avg.
  ///
  /// In en, this message translates to:
  /// **'Monthly avg'**
  String get statistics_writing_frequency_monthly_avg;

  /// No description provided for @statistics_writing_frequency_weekly_count.
  ///
  /// In en, this message translates to:
  /// **'{count} times'**
  String statistics_writing_frequency_weekly_count(String count);

  /// No description provided for @statistics_writing_frequency_monthly_count.
  ///
  /// In en, this message translates to:
  /// **'{count} times'**
  String statistics_writing_frequency_monthly_count(String count);

  /// No description provided for @statistics_writing_frequency_most_active_time.
  ///
  /// In en, this message translates to:
  /// **'Most active time'**
  String get statistics_writing_frequency_most_active_time;

  /// No description provided for @statistics_writing_frequency_most_active_day.
  ///
  /// In en, this message translates to:
  /// **'Most active day'**
  String get statistics_writing_frequency_most_active_day;

  /// No description provided for @statistics_time_morning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get statistics_time_morning;

  /// No description provided for @statistics_time_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get statistics_time_afternoon;

  /// No description provided for @statistics_time_evening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get statistics_time_evening;

  /// No description provided for @statistics_time_night.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get statistics_time_night;

  /// No description provided for @statistics_time_with_hour.
  ///
  /// In en, this message translates to:
  /// **'{timeOfDay} ({hour} o\'clock)'**
  String statistics_time_with_hour(String timeOfDay, int hour);

  /// No description provided for @statistics_writing_frequency_good_habit.
  ///
  /// In en, this message translates to:
  /// **'You\'re recording consistently! Excellent!'**
  String get statistics_writing_frequency_good_habit;

  /// No description provided for @statistics_writing_frequency_encouragement.
  ///
  /// In en, this message translates to:
  /// **'Try recording a bit more often. Small moments are precious too!'**
  String get statistics_writing_frequency_encouragement;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_common_title.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settings_common_title;

  /// No description provided for @settings_common_notification_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settings_common_notification_title;

  /// No description provided for @settings_common_notification_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive push notifications.'**
  String get settings_common_notification_subtitle;

  /// No description provided for @settings_common_app_lock_title.
  ///
  /// In en, this message translates to:
  /// **'App Lock'**
  String get settings_common_app_lock_title;

  /// No description provided for @settings_common_app_lock_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Lock the app with biometrics or a passcode.'**
  String get settings_common_app_lock_subtitle;

  /// No description provided for @settings_common_theme_title.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_common_theme_title;

  /// No description provided for @settings_common_theme_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose brightness theme.'**
  String get settings_common_theme_subtitle;

  /// No description provided for @settings_common_theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get settings_common_theme_light;

  /// No description provided for @settings_common_theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get settings_common_theme_dark;

  /// No description provided for @settings_common_theme_system.
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get settings_common_theme_system;

  /// No description provided for @settings_common_color_theme_title.
  ///
  /// In en, this message translates to:
  /// **'Color Theme'**
  String get settings_common_color_theme_title;

  /// No description provided for @settings_common_color_theme_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose color theme.'**
  String get settings_common_color_theme_subtitle;

  /// No description provided for @settings_common_language_title.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_common_language_title;

  /// No description provided for @settings_common_language_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settings_common_language_dialog_title;

  /// No description provided for @settings_common_font_family_title.
  ///
  /// In en, this message translates to:
  /// **'Font'**
  String get settings_common_font_family_title;

  /// No description provided for @settings_common_font_family_pretendard.
  ///
  /// In en, this message translates to:
  /// **'Pretendard'**
  String get settings_common_font_family_pretendard;

  /// No description provided for @settings_common_font_family_leeSeoyun.
  ///
  /// In en, this message translates to:
  /// **'Lee Seoyun'**
  String get settings_common_font_family_leeSeoyun;

  /// No description provided for @settings_common_font_family_orbitOfTheMoon.
  ///
  /// In en, this message translates to:
  /// **'Orbit of the Moon'**
  String get settings_common_font_family_orbitOfTheMoon;

  /// No description provided for @settings_common_font_family_restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get settings_common_font_family_restart;

  /// No description provided for @settings_common_font_family_overcome.
  ///
  /// In en, this message translates to:
  /// **'Overcome'**
  String get settings_common_font_family_overcome;

  /// No description provided for @settings_common_font_family_system.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get settings_common_font_family_system;

  /// No description provided for @settings_common_time_format_title.
  ///
  /// In en, this message translates to:
  /// **'Time Format'**
  String get settings_common_time_format_title;

  /// No description provided for @settings_common_time_format_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Select time display format'**
  String get settings_common_time_format_subtitle;

  /// No description provided for @settings_time_format_24hour.
  ///
  /// In en, this message translates to:
  /// **'24-hour'**
  String get settings_time_format_24hour;

  /// No description provided for @settings_time_format_12hour.
  ///
  /// In en, this message translates to:
  /// **'12-hour'**
  String get settings_time_format_12hour;

  /// No description provided for @settings_data_title.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settings_data_title;

  /// No description provided for @settings_data_auto_sync_title.
  ///
  /// In en, this message translates to:
  /// **'Auto Sync'**
  String get settings_data_auto_sync_title;

  /// No description provided for @settings_data_auto_sync_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically sync your data.'**
  String get settings_data_auto_sync_subtitle;

  /// No description provided for @settings_data_backup_title.
  ///
  /// In en, this message translates to:
  /// **'Data Backup'**
  String get settings_data_backup_title;

  /// No description provided for @settings_data_backup_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Securely back up your data to the cloud.'**
  String get settings_data_backup_subtitle;

  /// No description provided for @settings_data_restore_title.
  ///
  /// In en, this message translates to:
  /// **'Data Restore'**
  String get settings_data_restore_title;

  /// No description provided for @settings_data_restore_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Restore your data from the cloud.'**
  String get settings_data_restore_subtitle;

  /// No description provided for @settings_data_backup_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to back up your data?'**
  String get settings_data_backup_confirm;

  /// No description provided for @settings_data_backup_confirm_ok.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get settings_data_backup_confirm_ok;

  /// No description provided for @settings_data_cache_cleanup_title.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get settings_data_cache_cleanup_title;

  /// No description provided for @settings_data_cache_cleanup_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Delete temporary files.'**
  String get settings_data_cache_cleanup_subtitle;

  /// No description provided for @settings_data_cache_cleanup_confirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to clear cache?\nThis action cannot be undone.'**
  String get settings_data_cache_cleanup_confirm;

  /// No description provided for @settings_ai_personality_changed.
  ///
  /// In en, this message translates to:
  /// **'AI personality has been changed.'**
  String get settings_ai_personality_changed;

  /// No description provided for @settings_information_title.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get settings_information_title;

  /// No description provided for @settings_information_app_title.
  ///
  /// In en, this message translates to:
  /// **'App Info'**
  String get settings_information_app_title;

  /// No description provided for @settings_information_app_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Version and build information'**
  String get settings_information_app_subtitle;

  /// No description provided for @settings_information_app_version.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get settings_information_app_version;

  /// No description provided for @settings_information_app_build.
  ///
  /// In en, this message translates to:
  /// **'Build Version'**
  String get settings_information_app_build;

  /// No description provided for @settings_information_app_developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get settings_information_app_developer;

  /// No description provided for @settings_information_license_title.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get settings_information_license_title;

  /// No description provided for @settings_information_license_subtitle.
  ///
  /// In en, this message translates to:
  /// **'License information'**
  String get settings_information_license_subtitle;

  /// No description provided for @settings_information_faq_title.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get settings_information_faq_title;

  /// No description provided for @settings_information_faq_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Usage and FAQ'**
  String get settings_information_faq_subtitle;

  /// No description provided for @settings_information_qna_title.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get settings_information_qna_title;

  /// No description provided for @settings_information_qna_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Contact the developer.'**
  String get settings_information_qna_subtitle;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @profile_account_title.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get profile_account_title;

  /// No description provided for @profile_nickname_title.
  ///
  /// In en, this message translates to:
  /// **'Change Nickname'**
  String get profile_nickname_title;

  /// No description provided for @profile_nickname_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter new nickname.'**
  String get profile_nickname_hint;

  /// No description provided for @profile_creation_time_title.
  ///
  /// In en, this message translates to:
  /// **'Join Date'**
  String get profile_creation_time_title;

  /// No description provided for @profile_uid_title.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get profile_uid_title;

  /// No description provided for @profile_button_login.
  ///
  /// In en, this message translates to:
  /// **'Go to Login'**
  String get profile_button_login;

  /// No description provided for @profile_button_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile_button_logout;

  /// No description provided for @write_ai_limit_reached.
  ///
  /// In en, this message translates to:
  /// **'AI responses are limited to once per day. Please try again tomorrow!'**
  String get write_ai_limit_reached;

  /// No description provided for @write_timestamp_add.
  ///
  /// In en, this message translates to:
  /// **'Add Time'**
  String get write_timestamp_add;

  /// No description provided for @write_location_add.
  ///
  /// In en, this message translates to:
  /// **'Add Location'**
  String get write_location_add;

  /// No description provided for @common_language_korean.
  ///
  /// In en, this message translates to:
  /// **'한국어'**
  String get common_language_korean;

  /// No description provided for @common_language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get common_language_english;

  /// No description provided for @common_language_japanese.
  ///
  /// In en, this message translates to:
  /// **'日本語'**
  String get common_language_japanese;

  /// No description provided for @common_language_chinese.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get common_language_chinese;

  /// No description provided for @common_language_spanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get common_language_spanish;

  /// No description provided for @common_language_italian.
  ///
  /// In en, this message translates to:
  /// **'Italiano'**
  String get common_language_italian;

  /// No description provided for @common_language_french.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get common_language_french;

  /// No description provided for @common_language_vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get common_language_vietnamese;

  /// No description provided for @common_language_thai.
  ///
  /// In en, this message translates to:
  /// **'ไทย'**
  String get common_language_thai;

  /// No description provided for @common_developing.
  ///
  /// In en, this message translates to:
  /// **'In Development'**
  String get common_developing;

  /// No description provided for @settings_user_info_title.
  ///
  /// In en, this message translates to:
  /// **'Login Information'**
  String get settings_user_info_title;

  /// No description provided for @settings_user_info_empty.
  ///
  /// In en, this message translates to:
  /// **'No login information.'**
  String get settings_user_info_empty;

  /// No description provided for @settings_user_info_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get settings_user_info_status;

  /// No description provided for @settings_user_info_anonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous Login'**
  String get settings_user_info_anonymous;

  /// No description provided for @settings_user_info_logged_in.
  ///
  /// In en, this message translates to:
  /// **'Logged In'**
  String get settings_user_info_logged_in;

  /// No description provided for @dialog_storage_init_title.
  ///
  /// In en, this message translates to:
  /// **'Initialize Storage'**
  String get dialog_storage_init_title;

  /// No description provided for @dialog_storage_init_content.
  ///
  /// In en, this message translates to:
  /// **'Initialize SharedPreferences.'**
  String get dialog_storage_init_content;

  /// No description provided for @dialog_database_init_title.
  ///
  /// In en, this message translates to:
  /// **'Initialize Database'**
  String get dialog_database_init_title;

  /// No description provided for @dialog_database_init_content.
  ///
  /// In en, this message translates to:
  /// **'Initialize SQLite database.'**
  String get dialog_database_init_content;

  /// No description provided for @dialog_init_button.
  ///
  /// In en, this message translates to:
  /// **'Initialize'**
  String get dialog_init_button;

  /// No description provided for @settings_developer_options.
  ///
  /// In en, this message translates to:
  /// **'Developer Options'**
  String get settings_developer_options;

  /// No description provided for @settings_developer_mode_only.
  ///
  /// In en, this message translates to:
  /// **'Developer mode only'**
  String get settings_developer_mode_only;

  /// No description provided for @settings_ai_section_title.
  ///
  /// In en, this message translates to:
  /// **'AI Settings'**
  String get settings_ai_section_title;

  /// No description provided for @settings_ai_personality_title.
  ///
  /// In en, this message translates to:
  /// **'AI Personality'**
  String get settings_ai_personality_title;

  /// No description provided for @snackbar_backup_completed.
  ///
  /// In en, this message translates to:
  /// **'Backup completed.'**
  String get snackbar_backup_completed;

  /// No description provided for @snackbar_restore_completed.
  ///
  /// In en, this message translates to:
  /// **'Data restore completed.'**
  String get snackbar_restore_completed;

  /// No description provided for @snackbar_cache_cleared.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared.'**
  String get snackbar_cache_cleared;

  /// No description provided for @backup_in_progress.
  ///
  /// In en, this message translates to:
  /// **'Backing up data...'**
  String get backup_in_progress;

  /// No description provided for @restore_in_progress.
  ///
  /// In en, this message translates to:
  /// **'Restoring data...'**
  String get restore_in_progress;

  /// No description provided for @backup_failed.
  ///
  /// In en, this message translates to:
  /// **'Backup failed. Please try again.'**
  String get backup_failed;

  /// No description provided for @restore_failed_no_backup.
  ///
  /// In en, this message translates to:
  /// **'Restore failed. No backup found.'**
  String get restore_failed_no_backup;

  /// No description provided for @restore_failed_general.
  ///
  /// In en, this message translates to:
  /// **'Restore failed. Please try again.'**
  String get restore_failed_general;

  /// No description provided for @auth_terms_message.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to the {terms} and {privacy}.'**
  String auth_terms_message(String terms, String privacy);

  /// No description provided for @auth_terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get auth_terms_of_service;

  /// No description provided for @auth_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get auth_privacy_policy;

  /// No description provided for @app_info_copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2024 All rights reserved'**
  String get app_info_copyright;

  /// No description provided for @app_info_developer.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get app_info_developer;

  /// No description provided for @profile_sign_out_title.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profile_sign_out_title;

  /// No description provided for @profile_sign_out_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get profile_sign_out_message;

  /// No description provided for @profile_delete_account_button.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profile_delete_account_button;

  /// No description provided for @profile_delete_account_button_description.
  ///
  /// In en, this message translates to:
  /// **'Delete your current account.'**
  String get profile_delete_account_button_description;

  /// No description provided for @profile_delete_account_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profile_delete_account_dialog_title;

  /// No description provided for @profile_delete_account_dialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get profile_delete_account_dialog_content;

  /// No description provided for @profile_delete_account_dialog_warning.
  ///
  /// In en, this message translates to:
  /// **'All your data will be permanently deleted.'**
  String get profile_delete_account_dialog_warning;

  /// No description provided for @profile_delete_account_dialog_confirm.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profile_delete_account_dialog_confirm;

  /// No description provided for @profile_delete_account_dialog_password_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get profile_delete_account_dialog_password_input_hint;

  /// No description provided for @profile_delete_account_dialog_password_description.
  ///
  /// In en, this message translates to:
  /// **'You must enter your password to delete your account.'**
  String get profile_delete_account_dialog_password_description;

  /// No description provided for @journal_count.
  ///
  /// In en, this message translates to:
  /// **'{count} entries'**
  String journal_count(int count);

  /// No description provided for @location_current.
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get location_current;

  /// No description provided for @location_add_location.
  ///
  /// In en, this message translates to:
  /// **'Add Location'**
  String get location_add_location;

  /// No description provided for @activities_manage_title.
  ///
  /// In en, this message translates to:
  /// **'Manage Activities'**
  String get activities_manage_title;

  /// No description provided for @activities_manage_subtitle.
  ///
  /// In en, this message translates to:
  /// **'View and manage your activities'**
  String get activities_manage_subtitle;

  /// No description provided for @activities_filter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get activities_filter_all;

  /// No description provided for @activities_filter_title.
  ///
  /// In en, this message translates to:
  /// **'Filter by Activities'**
  String get activities_filter_title;

  /// No description provided for @activities_suggested_title.
  ///
  /// In en, this message translates to:
  /// **'Suggested Activities'**
  String get activities_suggested_title;

  /// No description provided for @activities_selected_title.
  ///
  /// In en, this message translates to:
  /// **'Selected Activities'**
  String get activities_selected_title;

  /// No description provided for @activities_add_new.
  ///
  /// In en, this message translates to:
  /// **'Add New Activity'**
  String get activities_add_new;

  /// No description provided for @activities_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Activity name'**
  String get activities_input_hint;

  /// No description provided for @activities_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Activity'**
  String get activities_delete_title;

  /// No description provided for @activities_delete_message.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete \"{activityName}\"? This activity will be removed from all diary entries.'**
  String activities_delete_message(String activityName);

  /// No description provided for @activities_delete_success.
  ///
  /// In en, this message translates to:
  /// **'Activity \"{activityName}\" has been deleted'**
  String activities_delete_success(String activityName);

  /// No description provided for @activities_no_activities.
  ///
  /// In en, this message translates to:
  /// **'No activities'**
  String get activities_no_activities;

  /// No description provided for @activities_load_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load activities'**
  String get activities_load_failed;

  /// No description provided for @activities_delete_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete activity'**
  String get activities_delete_failed;

  /// No description provided for @activities_menu_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get activities_menu_edit;

  /// No description provided for @activities_menu_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get activities_menu_delete;

  /// No description provided for @home_monthly_tracker_title.
  ///
  /// In en, this message translates to:
  /// **'Monthly Journaling'**
  String get home_monthly_tracker_title;

  /// No description provided for @home_yearly_tracker_title.
  ///
  /// In en, this message translates to:
  /// **'This Year\'s Diary Writing'**
  String get home_yearly_tracker_title;

  /// No description provided for @home_monthly_tracker_legend_less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get home_monthly_tracker_legend_less;

  /// No description provided for @home_monthly_tracker_legend_more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get home_monthly_tracker_legend_more;

  /// No description provided for @common_unit_day.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get common_unit_day;

  /// No description provided for @entries_mood_filter_title.
  ///
  /// In en, this message translates to:
  /// **'Filter by Mood'**
  String get entries_mood_filter_title;

  /// No description provided for @statistics_mood_distribution_empty.
  ///
  /// In en, this message translates to:
  /// **'No mood distribution data to display.'**
  String get statistics_mood_distribution_empty;

  /// No description provided for @statistics_mood_distribution_description.
  ///
  /// In en, this message translates to:
  /// **'Mood Distribution'**
  String get statistics_mood_distribution_description;

  /// No description provided for @statistics_mood_trend_description.
  ///
  /// In en, this message translates to:
  /// **'Mood Changes'**
  String get statistics_mood_trend_description;

  /// No description provided for @statistics_mood_trend_daily_records.
  ///
  /// In en, this message translates to:
  /// **'Daily Mood Records'**
  String get statistics_mood_trend_daily_records;

  /// No description provided for @statistics_mood_trend_overall_average.
  ///
  /// In en, this message translates to:
  /// **'Overall Average Score'**
  String get statistics_mood_trend_overall_average;

  /// No description provided for @statistics_mood_trend_recent_7days_average.
  ///
  /// In en, this message translates to:
  /// **'Recent 7-day average'**
  String get statistics_mood_trend_recent_7days_average;

  /// No description provided for @statistics_ai_report_title.
  ///
  /// In en, this message translates to:
  /// **'AI Analysis Report'**
  String get statistics_ai_report_title;

  /// No description provided for @statistics_ai_report_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Let AI analyze your mood patterns in depth.'**
  String get statistics_ai_report_subtitle;

  /// No description provided for @statistics_weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get statistics_weekly;

  /// No description provided for @statistics_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get statistics_monthly;

  /// No description provided for @statistics_yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get statistics_yearly;

  /// No description provided for @statistics_weekly_summary.
  ///
  /// In en, this message translates to:
  /// **'Weekly Summary'**
  String get statistics_weekly_summary;

  /// No description provided for @statistics_weekly_total_checkins.
  ///
  /// In en, this message translates to:
  /// **'Total Check-ins'**
  String get statistics_weekly_total_checkins;

  /// No description provided for @statistics_weekly_avg_mood.
  ///
  /// In en, this message translates to:
  /// **'Average Mood'**
  String get statistics_weekly_avg_mood;

  /// No description provided for @statistics_weekly_most_frequent_mood.
  ///
  /// In en, this message translates to:
  /// **'Most Frequent Mood'**
  String get statistics_weekly_most_frequent_mood;

  /// No description provided for @statistics_weekly_mood_trend.
  ///
  /// In en, this message translates to:
  /// **'Mood Trend'**
  String get statistics_weekly_mood_trend;

  /// No description provided for @statistics_weekly_activity_pattern.
  ///
  /// In en, this message translates to:
  /// **'Activity Pattern'**
  String get statistics_weekly_activity_pattern;

  /// No description provided for @statistics_weekly_top_emotions.
  ///
  /// In en, this message translates to:
  /// **'Top Emotions'**
  String get statistics_weekly_top_emotions;

  /// No description provided for @statistics_monthly_calendar.
  ///
  /// In en, this message translates to:
  /// **'Monthly Calendar'**
  String get statistics_monthly_calendar;

  /// No description provided for @statistics_monthly_summary.
  ///
  /// In en, this message translates to:
  /// **'Monthly Summary'**
  String get statistics_monthly_summary;

  /// No description provided for @statistics_monthly_checkin_days.
  ///
  /// In en, this message translates to:
  /// **'Check-in Days'**
  String get statistics_monthly_checkin_days;

  /// No description provided for @statistics_monthly_avg_mood.
  ///
  /// In en, this message translates to:
  /// **'Average Mood'**
  String get statistics_monthly_avg_mood;

  /// No description provided for @statistics_monthly_current_streak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get statistics_monthly_current_streak;

  /// No description provided for @statistics_monthly_vs_last_month.
  ///
  /// In en, this message translates to:
  /// **'vs Last Month'**
  String get statistics_monthly_vs_last_month;

  /// No description provided for @statistics_monthly_weekly_comparison.
  ///
  /// In en, this message translates to:
  /// **'Weekly Comparison'**
  String get statistics_monthly_weekly_comparison;

  /// No description provided for @statistics_monthly_top_activities.
  ///
  /// In en, this message translates to:
  /// **'Top Activities'**
  String get statistics_monthly_top_activities;

  /// No description provided for @statistics_monthly_emotion_distribution.
  ///
  /// In en, this message translates to:
  /// **'Emotion Distribution'**
  String get statistics_monthly_emotion_distribution;

  /// No description provided for @statistics_monthly_positive.
  ///
  /// In en, this message translates to:
  /// **'Positive'**
  String get statistics_monthly_positive;

  /// No description provided for @statistics_monthly_neutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get statistics_monthly_neutral;

  /// No description provided for @statistics_monthly_negative.
  ///
  /// In en, this message translates to:
  /// **'Negative'**
  String get statistics_monthly_negative;

  /// No description provided for @statistics_yearly_trend.
  ///
  /// In en, this message translates to:
  /// **'Yearly Trend'**
  String get statistics_yearly_trend;

  /// No description provided for @statistics_yearly_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Yearly Dashboard'**
  String get statistics_yearly_dashboard;

  /// No description provided for @statistics_yearly_total_checkins.
  ///
  /// In en, this message translates to:
  /// **'Total Check-ins'**
  String get statistics_yearly_total_checkins;

  /// No description provided for @statistics_yearly_avg_mood.
  ///
  /// In en, this message translates to:
  /// **'Average Mood'**
  String get statistics_yearly_avg_mood;

  /// No description provided for @statistics_yearly_best_month.
  ///
  /// In en, this message translates to:
  /// **'Best Month'**
  String get statistics_yearly_best_month;

  /// No description provided for @statistics_yearly_worst_month.
  ///
  /// In en, this message translates to:
  /// **'Worst Month'**
  String get statistics_yearly_worst_month;

  /// No description provided for @statistics_yearly_quarter_comparison.
  ///
  /// In en, this message translates to:
  /// **'Quarterly Comparison'**
  String get statistics_yearly_quarter_comparison;

  /// No description provided for @statistics_yearly_growth.
  ///
  /// In en, this message translates to:
  /// **'Growth Indicator'**
  String get statistics_yearly_growth;

  /// No description provided for @statistics_yearly_activity_report.
  ///
  /// In en, this message translates to:
  /// **'Activity Report'**
  String get statistics_yearly_activity_report;

  /// No description provided for @statistics_yearly_q1.
  ///
  /// In en, this message translates to:
  /// **'Q1'**
  String get statistics_yearly_q1;

  /// No description provided for @statistics_yearly_q2.
  ///
  /// In en, this message translates to:
  /// **'Q2'**
  String get statistics_yearly_q2;

  /// No description provided for @statistics_yearly_q3.
  ///
  /// In en, this message translates to:
  /// **'Q3'**
  String get statistics_yearly_q3;

  /// No description provided for @statistics_yearly_q4.
  ///
  /// In en, this message translates to:
  /// **'Q4'**
  String get statistics_yearly_q4;

  /// No description provided for @statistics_yearly_first_half.
  ///
  /// In en, this message translates to:
  /// **'1st Half'**
  String get statistics_yearly_first_half;

  /// No description provided for @statistics_yearly_second_half.
  ///
  /// In en, this message translates to:
  /// **'2nd Half'**
  String get statistics_yearly_second_half;

  /// No description provided for @statistics_yearly_growth_label.
  ///
  /// In en, this message translates to:
  /// **'Growth'**
  String get statistics_yearly_growth_label;

  /// No description provided for @statistics_yearly_change_label.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get statistics_yearly_change_label;

  /// No description provided for @ai_report_positive_keywords.
  ///
  /// In en, this message translates to:
  /// **'Positive Keywords'**
  String get ai_report_positive_keywords;

  /// No description provided for @ai_report_negative_keywords.
  ///
  /// In en, this message translates to:
  /// **'Negative Keywords'**
  String get ai_report_negative_keywords;

  /// No description provided for @ai_report_emotional_pattern.
  ///
  /// In en, this message translates to:
  /// **'Emotional Pattern Analysis'**
  String get ai_report_emotional_pattern;

  /// No description provided for @ai_report_activity_correlation.
  ///
  /// In en, this message translates to:
  /// **'Activity-Emotion Correlation'**
  String get ai_report_activity_correlation;

  /// No description provided for @ai_report_no_keywords.
  ///
  /// In en, this message translates to:
  /// **'No keywords found.'**
  String get ai_report_no_keywords;

  /// No description provided for @ai_report_not_enough_data.
  ///
  /// In en, this message translates to:
  /// **'Not enough data to analyze. Please write more than 10 journals in 30 days.'**
  String get ai_report_not_enough_data;

  /// No description provided for @home_representative_mood_title.
  ///
  /// In en, this message translates to:
  /// **'My Current Emotion'**
  String get home_representative_mood_title;

  /// No description provided for @home_representative_mood_description.
  ///
  /// In en, this message translates to:
  /// **'Analysis of the last 30 days of emotions'**
  String get home_representative_mood_description;

  /// No description provided for @home_representative_mood_empty.
  ///
  /// In en, this message translates to:
  /// **'No emotional record'**
  String get home_representative_mood_empty;

  /// No description provided for @home_representative_mood_empty_description.
  ///
  /// In en, this message translates to:
  /// **'Write a diary to record your emotions'**
  String get home_representative_mood_empty_description;

  /// No description provided for @calendar_month_jan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get calendar_month_jan;

  /// No description provided for @calendar_month_feb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get calendar_month_feb;

  /// No description provided for @calendar_month_mar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get calendar_month_mar;

  /// No description provided for @calendar_month_apr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get calendar_month_apr;

  /// No description provided for @calendar_month_may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get calendar_month_may;

  /// No description provided for @calendar_month_jun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get calendar_month_jun;

  /// No description provided for @calendar_month_jul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get calendar_month_jul;

  /// No description provided for @calendar_month_aug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get calendar_month_aug;

  /// No description provided for @calendar_month_sep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get calendar_month_sep;

  /// No description provided for @calendar_month_oct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get calendar_month_oct;

  /// No description provided for @calendar_month_nov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get calendar_month_nov;

  /// No description provided for @calendar_month_dec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get calendar_month_dec;

  /// No description provided for @calendar_weekday_sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get calendar_weekday_sun;

  /// No description provided for @calendar_weekday_mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get calendar_weekday_mon;

  /// No description provided for @calendar_weekday_tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get calendar_weekday_tue;

  /// No description provided for @calendar_weekday_wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get calendar_weekday_wed;

  /// No description provided for @calendar_weekday_thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get calendar_weekday_thu;

  /// No description provided for @calendar_weekday_fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get calendar_weekday_fri;

  /// No description provided for @calendar_weekday_sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get calendar_weekday_sat;

  /// No description provided for @activities_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Manage Activities'**
  String get activities_dialog_title;

  /// No description provided for @activities_dialog_empty.
  ///
  /// In en, this message translates to:
  /// **'No activities'**
  String get activities_dialog_empty;

  /// No description provided for @activities_dialog_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get activities_dialog_close;

  /// No description provided for @activities_dialog_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Activity'**
  String get activities_dialog_delete_title;

  /// No description provided for @activities_dialog_delete_message.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete \"{activityName}\"? This activity will be removed from all diary entries.'**
  String activities_dialog_delete_message(String activityName);

  /// No description provided for @activities_dialog_created.
  ///
  /// In en, this message translates to:
  /// **'Created: {date}'**
  String activities_dialog_created(String date);

  /// No description provided for @journal_image_detail_gesture_hint.
  ///
  /// In en, this message translates to:
  /// **'Double tap to zoom in/out, pinch to adjust freely'**
  String get journal_image_detail_gesture_hint;

  /// No description provided for @profile_delete_account_reauthentication_required.
  ///
  /// In en, this message translates to:
  /// **'Reauthentication is required to delete your account.'**
  String get profile_delete_account_reauthentication_required;

  /// No description provided for @profile_delete_account_reauthentication_google.
  ///
  /// In en, this message translates to:
  /// **'Reauthenticate with Google account'**
  String get profile_delete_account_reauthentication_google;

  /// No description provided for @profile_delete_account_reauthentication_apple.
  ///
  /// In en, this message translates to:
  /// **'Reauthenticate with Apple account'**
  String get profile_delete_account_reauthentication_apple;

  /// No description provided for @profile_delete_account_reauthentication_failed.
  ///
  /// In en, this message translates to:
  /// **'Reauthentication failed. Please try again.'**
  String get profile_delete_account_reauthentication_failed;

  /// No description provided for @profile_delete_account_success.
  ///
  /// In en, this message translates to:
  /// **'Account has been successfully deleted.'**
  String get profile_delete_account_success;

  /// No description provided for @profile_delete_account_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting your account.'**
  String get profile_delete_account_error;

  /// No description provided for @profile_delete_account_apple_revoke_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to revoke Apple account connection, but account deletion will proceed.'**
  String get profile_delete_account_apple_revoke_failed;

  /// No description provided for @profile_delete_account_apple_revoke_success.
  ///
  /// In en, this message translates to:
  /// **'Apple account connection has been revoked.'**
  String get profile_delete_account_apple_revoke_success;

  /// No description provided for @profile_delete_account_apple_manual_revoke_guide.
  ///
  /// In en, this message translates to:
  /// **'For complete Apple account disconnection:\n\n1️⃣ Web: appleid.apple.com → Sign-In and Security → Apps using Apple ID → Delete the app\n\n2️⃣ iPhone: Settings → Apple ID → Password & Security → Apple ID logins → Delete the app\n\nThis will allow you to choose email sharing preferences on your next login.'**
  String get profile_delete_account_apple_manual_revoke_guide;

  /// No description provided for @weather_current_weather.
  ///
  /// In en, this message translates to:
  /// **'Current Weather'**
  String get weather_current_weather;

  /// No description provided for @weather_humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get weather_humidity;

  /// No description provided for @weather_wind.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get weather_wind;

  /// No description provided for @weather_pressure.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get weather_pressure;

  /// No description provided for @location_journal_location.
  ///
  /// In en, this message translates to:
  /// **'Journal Location'**
  String get location_journal_location;

  /// No description provided for @location_tap_to_open.
  ///
  /// In en, this message translates to:
  /// **'Tap to open'**
  String get location_tap_to_open;

  /// No description provided for @location_map_load_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to load map'**
  String get location_map_load_error;

  /// No description provided for @location_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get location_address;

  /// No description provided for @location_no_address.
  ///
  /// In en, this message translates to:
  /// **'No address information'**
  String get location_no_address;

  /// No description provided for @location_coordinates.
  ///
  /// In en, this message translates to:
  /// **'Coordinates'**
  String get location_coordinates;

  /// No description provided for @location_open_in_google_maps.
  ///
  /// In en, this message translates to:
  /// **'Open in Google Maps'**
  String get location_open_in_google_maps;

  /// No description provided for @profile_guest_mode.
  ///
  /// In en, this message translates to:
  /// **'You are in guest mode.'**
  String get profile_guest_mode;

  /// No description provided for @profile_guest_login_button.
  ///
  /// In en, this message translates to:
  /// **'Switch to Social Login'**
  String get profile_guest_login_button;

  /// No description provided for @profile_guest_login_description.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google or Apple and sync your data.'**
  String get profile_guest_login_description;

  /// No description provided for @lockScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication Required'**
  String get lockScreenTitle;

  /// No description provided for @lockScreenReason.
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to unlock the app.'**
  String get lockScreenReason;

  /// No description provided for @lockScreenRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get lockScreenRetry;

  /// No description provided for @lockScreenConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your PIN'**
  String get lockScreenConfirmTitle;

  /// No description provided for @lockScreenCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get lockScreenCancel;

  /// No description provided for @lockScreenProFeature.
  ///
  /// In en, this message translates to:
  /// **'This feature is available in the Pro version.'**
  String get lockScreenProFeature;

  /// No description provided for @settings_common_lock_type_title.
  ///
  /// In en, this message translates to:
  /// **'Lock Type'**
  String get settings_common_lock_type_title;

  /// No description provided for @settings_common_lock_type_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric or PIN'**
  String get settings_common_lock_type_subtitle;

  /// No description provided for @lock_type_none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get lock_type_none;

  /// No description provided for @lock_type_biometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric'**
  String get lock_type_biometric;

  /// No description provided for @lock_type_pin.
  ///
  /// In en, this message translates to:
  /// **'PIN (4 digits)'**
  String get lock_type_pin;

  /// No description provided for @proFeatureDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Pro Feature'**
  String get proFeatureDialogTitle;

  /// No description provided for @proFeatureDialogContent.
  ///
  /// In en, this message translates to:
  /// **'App Lock is a Pro feature. Upgrade to enjoy all premium features!'**
  String get proFeatureDialogContent;

  /// No description provided for @proFeatureDialogUpgradeButton.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get proFeatureDialogUpgradeButton;

  /// No description provided for @home_selection_count.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String home_selection_count(int count);

  /// No description provided for @home_delete_journals_confirm_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} journal entries?'**
  String home_delete_journals_confirm_message(int count);

  /// No description provided for @write_ai_content_required.
  ///
  /// In en, this message translates to:
  /// **'Please write something first.'**
  String get write_ai_content_required;

  /// No description provided for @font_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Font Settings'**
  String get font_settings_title;

  /// No description provided for @font_settings_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search fonts'**
  String get font_settings_search_hint;

  /// No description provided for @font_settings_section_default.
  ///
  /// In en, this message translates to:
  /// **'Default Font'**
  String get font_settings_section_default;

  /// No description provided for @font_settings_section_selected.
  ///
  /// In en, this message translates to:
  /// **'Selected Font'**
  String get font_settings_section_selected;

  /// No description provided for @font_settings_section_all.
  ///
  /// In en, this message translates to:
  /// **'All Fonts'**
  String get font_settings_section_all;

  /// No description provided for @font_settings_error_title.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get font_settings_error_title;

  /// No description provided for @font_settings_error_message.
  ///
  /// In en, this message translates to:
  /// **'An error occurred.'**
  String get font_settings_error_message;

  /// No description provided for @font_settings_error_load_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load font list'**
  String get font_settings_error_load_failed;

  /// No description provided for @font_settings_error_apply_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to apply font'**
  String get font_settings_error_apply_failed;

  /// No description provided for @settings_data_export_title.
  ///
  /// In en, this message translates to:
  /// **'Export Backup'**
  String get settings_data_export_title;

  /// No description provided for @settings_data_export_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Export data as JSON file'**
  String get settings_data_export_subtitle;

  /// No description provided for @settings_data_import_title.
  ///
  /// In en, this message translates to:
  /// **'Import Backup'**
  String get settings_data_import_title;

  /// No description provided for @settings_data_import_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Restore data from JSON file'**
  String get settings_data_import_subtitle;

  /// No description provided for @settings_data_export_progress.
  ///
  /// In en, this message translates to:
  /// **'Creating backup file...'**
  String get settings_data_export_progress;

  /// No description provided for @settings_data_export_success.
  ///
  /// In en, this message translates to:
  /// **'Backup file saved: {filename}'**
  String settings_data_export_success(String filename);

  /// No description provided for @settings_data_export_failed.
  ///
  /// In en, this message translates to:
  /// **'Backup failed: {error}'**
  String settings_data_export_failed(String error);

  /// No description provided for @settings_data_import_progress.
  ///
  /// In en, this message translates to:
  /// **'Restoring...'**
  String get settings_data_import_progress;

  /// No description provided for @settings_data_import_success.
  ///
  /// In en, this message translates to:
  /// **'Backup data has been restored'**
  String get settings_data_import_success;

  /// No description provided for @settings_data_import_failed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String settings_data_import_failed(String error);

  /// No description provided for @quick_check_in_title.
  ///
  /// In en, this message translates to:
  /// **'Quick Check-In'**
  String get quick_check_in_title;

  /// No description provided for @quick_check_in_mood_question.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling right now?'**
  String get quick_check_in_mood_question;

  /// No description provided for @quick_check_in_activity_question.
  ///
  /// In en, this message translates to:
  /// **'What are you currently doing?'**
  String get quick_check_in_activity_question;

  /// No description provided for @quick_check_in_activity_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Exercise, Work, Relaxing, etc.'**
  String get quick_check_in_activity_hint;

  /// No description provided for @quick_check_in_emotion_question.
  ///
  /// In en, this message translates to:
  /// **'What emotions are you experiencing?'**
  String get quick_check_in_emotion_question;

  /// No description provided for @quick_check_in_emotion_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Happy, Anxious, Excited, etc.'**
  String get quick_check_in_emotion_hint;

  /// No description provided for @quick_check_in_memo_question.
  ///
  /// In en, this message translates to:
  /// **'Leave a quick note'**
  String get quick_check_in_memo_question;

  /// No description provided for @quick_check_in_memo_hint.
  ///
  /// In en, this message translates to:
  /// **'Today in one sentence'**
  String get quick_check_in_memo_hint;

  /// No description provided for @quick_check_in_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get quick_check_in_next;

  /// No description provided for @quick_check_in_previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get quick_check_in_previous;

  /// No description provided for @quick_check_in_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get quick_check_in_skip;

  /// No description provided for @quick_check_in_submit.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get quick_check_in_submit;

  /// No description provided for @quick_check_in_success.
  ///
  /// In en, this message translates to:
  /// **'Check-in completed'**
  String get quick_check_in_success;

  /// No description provided for @quick_check_in_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during check-in'**
  String get quick_check_in_error;

  /// No description provided for @quick_check_in_weather_question.
  ///
  /// In en, this message translates to:
  /// **'Check current weather and time'**
  String get quick_check_in_weather_question;

  /// No description provided for @home_button_write_journal.
  ///
  /// In en, this message translates to:
  /// **'Write Journal'**
  String get home_button_write_journal;

  /// No description provided for @home_button_quick_check_in.
  ///
  /// In en, this message translates to:
  /// **'Quick Check-In'**
  String get home_button_quick_check_in;

  /// No description provided for @quick_check_in_sleep_quality_title.
  ///
  /// In en, this message translates to:
  /// **'How was your sleep?'**
  String get quick_check_in_sleep_quality_title;

  /// No description provided for @quick_check_in_sleep_quality_1.
  ///
  /// In en, this message translates to:
  /// **'Tossed & turned'**
  String get quick_check_in_sleep_quality_1;

  /// No description provided for @quick_check_in_sleep_quality_2.
  ///
  /// In en, this message translates to:
  /// **'Restless'**
  String get quick_check_in_sleep_quality_2;

  /// No description provided for @quick_check_in_sleep_quality_3.
  ///
  /// In en, this message translates to:
  /// **'So-so'**
  String get quick_check_in_sleep_quality_3;

  /// No description provided for @quick_check_in_sleep_quality_4.
  ///
  /// In en, this message translates to:
  /// **'Slept well'**
  String get quick_check_in_sleep_quality_4;

  /// No description provided for @quick_check_in_sleep_quality_5.
  ///
  /// In en, this message translates to:
  /// **'Slept great'**
  String get quick_check_in_sleep_quality_5;

  /// No description provided for @edit_nickname_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Nickname'**
  String get edit_nickname_title;

  /// No description provided for @edit_nickname_label.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get edit_nickname_label;

  /// No description provided for @edit_nickname_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter new nickname'**
  String get edit_nickname_hint;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @check_in_activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get check_in_activities;

  /// No description provided for @check_in_emotions.
  ///
  /// In en, this message translates to:
  /// **'Emotions'**
  String get check_in_emotions;

  /// No description provided for @check_in_sleep_quality.
  ///
  /// In en, this message translates to:
  /// **'Sleep Quality'**
  String get check_in_sleep_quality;

  /// No description provided for @check_in_emotions_empty.
  ///
  /// In en, this message translates to:
  /// **'No emotions selected'**
  String get check_in_emotions_empty;

  /// No description provided for @check_in_activities_empty.
  ///
  /// In en, this message translates to:
  /// **'No activities selected'**
  String get check_in_activities_empty;

  /// No description provided for @check_in_memo.
  ///
  /// In en, this message translates to:
  /// **'Memo'**
  String get check_in_memo;

  /// No description provided for @check_in_delete_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get check_in_delete_confirm_title;

  /// No description provided for @check_in_delete_confirm_description.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this check-in?'**
  String get check_in_delete_confirm_description;

  /// No description provided for @check_in_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get check_in_edit;

  /// No description provided for @check_in_not_found.
  ///
  /// In en, this message translates to:
  /// **'Check-in not found'**
  String get check_in_not_found;

  /// No description provided for @check_in_not_found_description.
  ///
  /// In en, this message translates to:
  /// **'This check-in has been deleted or does not exist'**
  String get check_in_not_found_description;

  /// No description provided for @timeline_check_in.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get timeline_check_in;

  /// No description provided for @timeline_journal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get timeline_journal;

  /// No description provided for @suggested_activity_exercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get suggested_activity_exercise;

  /// No description provided for @suggested_activity_study.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get suggested_activity_study;

  /// No description provided for @suggested_activity_work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get suggested_activity_work;

  /// No description provided for @suggested_activity_cooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking'**
  String get suggested_activity_cooking;

  /// No description provided for @suggested_activity_reading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get suggested_activity_reading;

  /// No description provided for @suggested_activity_walking.
  ///
  /// In en, this message translates to:
  /// **'Walking'**
  String get suggested_activity_walking;

  /// No description provided for @suggested_activity_cleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get suggested_activity_cleaning;

  /// No description provided for @suggested_activity_shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get suggested_activity_shopping;

  /// No description provided for @suggested_activity_gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get suggested_activity_gaming;

  /// No description provided for @suggested_activity_watching.
  ///
  /// In en, this message translates to:
  /// **'Watching'**
  String get suggested_activity_watching;

  /// No description provided for @suggested_activity_music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get suggested_activity_music;

  /// No description provided for @suggested_activity_travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get suggested_activity_travel;

  /// No description provided for @suggested_activity_friends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get suggested_activity_friends;

  /// No description provided for @suggested_activity_family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get suggested_activity_family;

  /// No description provided for @suggested_activity_rest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get suggested_activity_rest;

  /// No description provided for @suggested_emotion_joy.
  ///
  /// In en, this message translates to:
  /// **'Joy'**
  String get suggested_emotion_joy;

  /// No description provided for @suggested_emotion_happiness.
  ///
  /// In en, this message translates to:
  /// **'Happiness'**
  String get suggested_emotion_happiness;

  /// No description provided for @suggested_emotion_peace.
  ///
  /// In en, this message translates to:
  /// **'Peace'**
  String get suggested_emotion_peace;

  /// No description provided for @suggested_emotion_satisfaction.
  ///
  /// In en, this message translates to:
  /// **'Satisfaction'**
  String get suggested_emotion_satisfaction;

  /// No description provided for @suggested_emotion_excitement.
  ///
  /// In en, this message translates to:
  /// **'Excitement'**
  String get suggested_emotion_excitement;

  /// No description provided for @suggested_emotion_gratitude.
  ///
  /// In en, this message translates to:
  /// **'Gratitude'**
  String get suggested_emotion_gratitude;

  /// No description provided for @suggested_emotion_love.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get suggested_emotion_love;

  /// No description provided for @suggested_emotion_confidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get suggested_emotion_confidence;

  /// No description provided for @suggested_emotion_anxiety.
  ///
  /// In en, this message translates to:
  /// **'Anxiety'**
  String get suggested_emotion_anxiety;

  /// No description provided for @suggested_emotion_worry.
  ///
  /// In en, this message translates to:
  /// **'Worry'**
  String get suggested_emotion_worry;

  /// No description provided for @suggested_emotion_sadness.
  ///
  /// In en, this message translates to:
  /// **'Sadness'**
  String get suggested_emotion_sadness;

  /// No description provided for @suggested_emotion_anger.
  ///
  /// In en, this message translates to:
  /// **'Anger'**
  String get suggested_emotion_anger;

  /// No description provided for @suggested_emotion_irritation.
  ///
  /// In en, this message translates to:
  /// **'Irritation'**
  String get suggested_emotion_irritation;

  /// No description provided for @suggested_emotion_tired.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get suggested_emotion_tired;

  /// No description provided for @suggested_emotion_loneliness.
  ///
  /// In en, this message translates to:
  /// **'Loneliness'**
  String get suggested_emotion_loneliness;

  /// No description provided for @common_less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get common_less;

  /// No description provided for @common_more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get common_more;

  /// No description provided for @statistics_emotion_keywords_empty.
  ///
  /// In en, this message translates to:
  /// **'No emotion keywords'**
  String get statistics_emotion_keywords_empty;

  /// No description provided for @statistics_monthly_checkin_count.
  ///
  /// In en, this message translates to:
  /// **'Check-ins'**
  String get statistics_monthly_checkin_count;

  /// No description provided for @statistics_monthly_week_suffix.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get statistics_monthly_week_suffix;

  /// No description provided for @mood_summary_title.
  ///
  /// In en, this message translates to:
  /// **'Mood Summary'**
  String get mood_summary_title;

  /// No description provided for @mood_summary_daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get mood_summary_daily;

  /// No description provided for @mood_summary_weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get mood_summary_weekly;

  /// No description provided for @mood_summary_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get mood_summary_monthly;

  /// No description provided for @mood_summary_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No summary yet'**
  String get mood_summary_empty_title;

  /// No description provided for @mood_summary_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'AI will analyze your emotions as check-in data accumulates'**
  String get mood_summary_empty_subtitle;

  /// No description provided for @mood_summary_generate.
  ///
  /// In en, this message translates to:
  /// **'Generate Summary'**
  String get mood_summary_generate;

  /// No description provided for @mood_summary_generated_at.
  ///
  /// In en, this message translates to:
  /// **'Generated At'**
  String get mood_summary_generated_at;

  /// No description provided for @mood_summary_period.
  ///
  /// In en, this message translates to:
  /// **'Analysis Period'**
  String get mood_summary_period;

  /// No description provided for @mood_summary_emotional_flow.
  ///
  /// In en, this message translates to:
  /// **'Emotional Flow'**
  String get mood_summary_emotional_flow;

  /// No description provided for @mood_summary_dominant_moods.
  ///
  /// In en, this message translates to:
  /// **'Dominant Moods'**
  String get mood_summary_dominant_moods;

  /// No description provided for @mood_summary_activity_patterns.
  ///
  /// In en, this message translates to:
  /// **'Activity Patterns'**
  String get mood_summary_activity_patterns;

  /// No description provided for @mood_summary_personal_advice.
  ///
  /// In en, this message translates to:
  /// **'Advice for You'**
  String get mood_summary_personal_advice;

  /// No description provided for @mood_summary_key_points.
  ///
  /// In en, this message translates to:
  /// **'Key Points'**
  String get mood_summary_key_points;
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
      <String>['en', 'ja', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
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
