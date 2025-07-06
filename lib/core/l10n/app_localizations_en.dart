// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get common_date_today => 'Today';

  @override
  String get common_date_tomorrow => 'Tomorrow';

  @override
  String get common_date_yesterday => 'Yesterday';

  @override
  String get common_confirm_cancel => 'Cancel';

  @override
  String get common_confirm_ok => 'OK';

  @override
  String get common_confirm_delete => 'Delete';

  @override
  String get common_email => 'Email';

  @override
  String get common_phone => 'Phone';

  @override
  String get common_mood_verygood => 'Very Good';

  @override
  String get common_mood_good => 'Good';

  @override
  String get common_mood_neutral => 'Neutral';

  @override
  String get common_mood_bad => 'Bad';

  @override
  String get common_mood_verybad => 'Very Bad';

  @override
  String get onboarding_welcome_title => 'Welcome to MoodLog!';

  @override
  String get onboarding_welcome_description1 =>
      'MoodLog is an app where you can record your daily emotions and receive AI responses to them.';

  @override
  String get onboarding_welcome_description2 =>
      'Record your emotions every day and read the responses from AI.';

  @override
  String get onboarding_welcome_next => 'Shall we get started together?';

  @override
  String get onboarding_nickname_title => 'Set Nickname';

  @override
  String get onboarding_nickname_description =>
      'Please enter a nickname to use in MoodLog';

  @override
  String get onboarding_nickname_input_title => 'Nickname';

  @override
  String get onboarding_nickname_input_hint =>
      'Enter nickname (2-10 characters)';

  @override
  String get onboarding_nickname_next =>
      'You can change your nickname anytime in the settings menu.';

  @override
  String get onboarding_nickname_input_error => 'Please enter a nickname.';

  @override
  String get onboarding_personality_title => 'Choose Reply Style';

  @override
  String get onboarding_personality_description =>
      'Choose the kindness level of the AI that will reply to your journal.';

  @override
  String get onboarding_personality_rational_title => 'Rational Analyst';

  @override
  String get onboarding_personality_rational_description =>
      'Provides objective and practical advice';

  @override
  String get onboarding_personality_balanced_title => 'Balanced Advisor';

  @override
  String get onboarding_personality_balanced_description =>
      'Balances empathy with realistic advice.';

  @override
  String get onboarding_personality_compassionate_title =>
      'Compassionate Healer';

  @override
  String get onboarding_personality_compassionate_description =>
      'Provides warm comfort and deep empathy.';

  @override
  String get onboarding_success_title => 'Ready to start!';

  @override
  String get onboarding_success_description => 'Shall we start MoodLog?';

  @override
  String get onboarding_success_button => 'Get Started';

  @override
  String get home_hello => 'Hello!';

  @override
  String home_welcome(Object userName) {
    return '$userName.';
  }

  @override
  String get home_howareyou => 'How are you feeling today?';

  @override
  String get home_empty_box => 'Waiting for your story.';

  @override
  String get tab_home => 'Home';

  @override
  String get tab_entries => 'Entries';

  @override
  String get tab_settings => 'Settings';

  @override
  String get tab_write => 'Write';

  @override
  String get tab_statistics => 'Statistics';

  @override
  String get write_mood_title => 'How are you feeling today?';

  @override
  String get write_input_title => 'Content';

  @override
  String get write_input_hint => 'Record your emotions and experiences today.';

  @override
  String get write_ai_title => 'AI Comfort Message';

  @override
  String get write_ai_description =>
      'After writing your journal, AI will send you messages of comfort and encouragement.';

  @override
  String get journal_delete_confirm_title => 'Confirm Delete';

  @override
  String get journal_delete_confirm_description =>
      'Are you sure you want to delete this entry?';

  @override
  String get journal_ai_generating_response_title =>
      'AI is generating a response.';

  @override
  String get statistics_total_title => 'Total Statistics';

  @override
  String get statistics_total_record_description => 'Total Records';

  @override
  String statistics_total_record(Object count) {
    return '$count entries';
  }

  @override
  String get statistics_total_streak_description => 'Current Streak';

  @override
  String statistics_total_streak(Object count) {
    return '$count days';
  }

  @override
  String get statistics_total_streak_max_description => 'Max Streak';

  @override
  String statistics_total_streak_max(Object count) {
    return '$count days';
  }

  @override
  String get statistics_mood_calendar_title => 'Mood Calendar';

  @override
  String get statistics_mood_distribution_title => 'Mood Distribution';

  @override
  String statistics_mood_distribution_unit(Object count) {
    return '$count times';
  }

  @override
  String get statistics_mood_trend_title => 'Mood Trends';

  @override
  String get statistics_mood_trend_empty => 'No mood trend data available.';

  @override
  String get statistics_recent_title => 'Recent Entries';

  @override
  String get statistics_recent_empty => 'No recent entries.';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_common_title => 'General';

  @override
  String get settings_common_notification_title => 'Notifications';

  @override
  String get settings_common_notification_subtitle =>
      'Receive push notifications.';

  @override
  String get settings_common_theme_title => 'Theme';

  @override
  String get settings_common_theme_subtitle => 'Select brightness theme.';

  @override
  String get settings_common_color_theme_title => 'Color Theme';

  @override
  String get settings_common_color_theme_subtitle => 'Select color theme.';

  @override
  String get settings_common_language_title => 'Language';

  @override
  String get settings_common_language_dialog_title => 'Select Language';

  @override
  String get settings_data_title => 'Data';

  @override
  String get settings_data_auto_sync_title => 'Auto Sync';

  @override
  String get settings_data_auto_sync_subtitle => 'Automatically sync data.';

  @override
  String get settings_data_backup_title => 'Data Backup';

  @override
  String get settings_data_backup_subtitle => 'Backup your data.';

  @override
  String get settings_data_backup_confirm => 'Do you want to backup your data?';

  @override
  String get settings_data_backup_confirm_ok => 'Backup';

  @override
  String get settings_data_cash_cleanup_title => 'Clear Cache';

  @override
  String get settings_data_cash_cleanup_subtitle => 'Delete temporary files.';

  @override
  String get settings_data_cash_cleanup_confirm =>
      'Are you sure you want to clear the cache?\nThis action cannot be undone.';

  @override
  String get settings_information_title => 'Information';

  @override
  String get settings_information_app_title => 'App Info';

  @override
  String get settings_information_app_subtitle =>
      'Version and license information';

  @override
  String get settings_information_app_version => 'Version';

  @override
  String get settings_information_app_build => 'License';

  @override
  String get settings_information_app_developer => 'Developer';

  @override
  String get settings_information_faq_title => 'Help';

  @override
  String get settings_information_faq_subtitle => 'Usage and FAQ';

  @override
  String get settings_information_qna_title => 'Contact';

  @override
  String get settings_information_qna_subtitle => 'Contact the developer.';
}
