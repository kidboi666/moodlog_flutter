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
  String get common_date_full => 'MMM dd, yyyy';

  @override
  String get common_confirm_cancel => 'Cancel';

  @override
  String get common_confirm_ok => 'OK';

  @override
  String get common_confirm_delete => 'Delete';

  @override
  String get common_confirm_save => 'Save';

  @override
  String get common_reset => 'Reset';

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
  String get common_month_jan => 'January';

  @override
  String get common_month_feb => 'February';

  @override
  String get common_month_mar => 'March';

  @override
  String get common_month_apr => 'April';

  @override
  String get common_month_may => 'May';

  @override
  String get common_month_jun => 'June';

  @override
  String get common_month_jul => 'July';

  @override
  String get common_month_aug => 'August';

  @override
  String get common_month_sep => 'September';

  @override
  String get common_month_oct => 'October';

  @override
  String get common_month_nov => 'November';

  @override
  String get common_month_dec => 'December';

  @override
  String get common_weekday_mon => 'Monday';

  @override
  String get common_weekday_tue => 'Tuesday';

  @override
  String get common_weekday_wed => 'Wednesday';

  @override
  String get common_weekday_thu => 'Thursday';

  @override
  String get common_weekday_fri => 'Friday';

  @override
  String get common_weekday_sat => 'Saturday';

  @override
  String get common_weekday_sun => 'Sunday';

  @override
  String get common_weekday_mon_short => 'Mon';

  @override
  String get common_weekday_tue_short => 'Tue';

  @override
  String get common_weekday_wed_short => 'Wed';

  @override
  String get common_weekday_thu_short => 'Thu';

  @override
  String get common_weekday_fri_short => 'Fri';

  @override
  String get common_weekday_sat_short => 'Sat';

  @override
  String get common_weekday_sun_short => 'Sun';

  @override
  String get onboarding_welcome_title => 'Welcome!';

  @override
  String get onboarding_welcome_description1 =>
      'MoodLog is an app that lets you record your daily emotions and receive AI responses to them.';

  @override
  String get onboarding_welcome_description2 =>
      'Record your emotions daily and read the AI\'s responses.';

  @override
  String get onboarding_welcome_next => 'Shall we get started together?';

  @override
  String get onboarding_nickname_title => 'Set Nickname';

  @override
  String get onboarding_nickname_description =>
      'Please enter the nickname you want to use in MoodLog';

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
  String get onboarding_personality_title => 'Choose Response Style';

  @override
  String get onboarding_personality_description =>
      'Choose the AI personality that will respond to your diary.';

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
      'Delivers warm comfort and deep empathy.';

  @override
  String get onboarding_personality_hint =>
      'You can change this anytime in settings.';

  @override
  String get onboarding_success_title => 'Ready to start!';

  @override
  String get onboarding_success_description => 'Shall we start MoodLog?';

  @override
  String get onboarding_success_next => 'Get Started';

  @override
  String get signin_title => 'Ready to start!';

  @override
  String get signin_growth => 'Record your growing mind.';

  @override
  String get signin_login_title => 'Sign up to save your records.';

  @override
  String get signin_button_guest => 'Start as Guest';

  @override
  String get signin_button_google => 'Start with Google';

  @override
  String get signin_button_apple => 'Start with Apple';

  @override
  String get home_hello => 'Hello!';

  @override
  String home_welcome(Object nickname) {
    return '$nickname.';
  }

  @override
  String get home_howareyou => 'How are you feeling today?';

  @override
  String get home_empty_box => 'Waiting for your story.';

  @override
  String get entries_empty_box_title => 'No diary entries yet.';

  @override
  String get entries_empty_box_description =>
      'Your written entries will appear here.';

  @override
  String get entries_empty_box_button => 'Go write a diary entry';

  @override
  String get entries_calendar_legend_has_journal => 'Has entry';

  @override
  String get entries_calendar_legend_today => 'Today';

  @override
  String get tab_home => 'Home';

  @override
  String get drawer_tags => 'Manage Tags';

  @override
  String get empty_box_write_options_title =>
      'Which date would you like to write for?';

  @override
  String empty_box_write_for_selected_date(String date) {
    return 'Write for $date';
  }

  @override
  String get empty_box_write_for_today => 'Write for today';

  @override
  String get tags_empty => 'No tags found.';

  @override
  String tags_error(String error) {
    return 'Error: $error';
  }

  @override
  String tags_journal_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count journals',
      one: '1 journal',
    );
    return '$_temp0';
  }

  @override
  String get default_tag_daily => 'Daily';

  @override
  String get default_tag_work => 'Work';

  @override
  String get default_tag_health => 'Health';

  @override
  String get default_tag_relationships => 'Relationships';

  @override
  String get default_tag_hobby => 'Hobby';

  @override
  String get default_tag_emotions => 'Emotions';

  @override
  String get tab_entries => 'Entries';

  @override
  String get tab_settings => 'Settings';

  @override
  String get tab_write => 'Write';

  @override
  String get tab_statistics => 'Statistics';

  @override
  String get write_title => 'Write Diary';

  @override
  String get write_edit_title => 'Edit Diary';

  @override
  String get write_mood_title => 'How are you feeling today?';

  @override
  String get write_mood_subtitle => 'Please select your mood';

  @override
  String get write_input_title => 'Content';

  @override
  String get write_input_hint => 'Record today\'s emotions and experiences.';

  @override
  String get write_ai_title => 'AI Comfort Message';

  @override
  String get write_ai_description =>
      'After writing your diary, AI will send you a message of comfort and encouragement.';

  @override
  String get write_location_remove => 'Remove';

  @override
  String get journal_delete_confirm_title => 'Confirm Delete';

  @override
  String get journal_delete_confirm_description =>
      'Do you want to delete this entry?';

  @override
  String get journal_ai_generating_response_title =>
      'AI is writing a response.';

  @override
  String get statistics_total_title => 'Overall Statistics';

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
  String get statistics_total_streak_max_description => 'Longest Streak';

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
  String get statistics_mood_trend_title => 'Mood Trend';

  @override
  String get statistics_mood_trend_empty => 'No mood trend data available.';

  @override
  String get statistics_recent_title => 'Recent Entries';

  @override
  String get statistics_recent_empty => 'No recent entries.';

  @override
  String get statistics_total_records_count_unit => 'records';

  @override
  String get statistics_total_records_first_record => 'First Record';

  @override
  String get statistics_total_records_period => 'Recording Period';

  @override
  String statistics_total_records_period_days(int days) {
    return '$days days';
  }

  @override
  String get statistics_total_records_avg_frequency => 'Average Frequency';

  @override
  String statistics_total_records_weekly_frequency(String frequency) {
    return '$frequency times/week';
  }

  @override
  String get statistics_streak_status_active => 'Active';

  @override
  String get statistics_streak_status_inactive => 'Inactive';

  @override
  String get statistics_streak_last_record => 'Last Record';

  @override
  String statistics_streak_days_ago(int days) {
    return '$days days ago';
  }

  @override
  String get statistics_streak_stopped => 'Streak Stopped';

  @override
  String statistics_streak_stopped_days(int days) {
    return '$days days ago';
  }

  @override
  String get statistics_streak_encouragement =>
      'Great! You\'re keeping up your streak';

  @override
  String get statistics_max_streak_new_record => 'New Record!';

  @override
  String get statistics_max_streak_progress => 'Current Progress';

  @override
  String get statistics_max_streak_remaining => 'To beat your record';

  @override
  String statistics_max_streak_remaining_days(int days) {
    return '$days days to go';
  }

  @override
  String get statistics_max_streak_achievement_week =>
      'One week streak achieved! You\'re doing great!';

  @override
  String get statistics_max_streak_achievement_two_weeks =>
      'Two weeks streak achieved! Excellent!';

  @override
  String get statistics_max_streak_achievement_month =>
      'One month streak achieved! Amazing!';

  @override
  String get statistics_average_mood_title => 'Average Mood';

  @override
  String statistics_average_mood_score(String score) {
    return 'Average $score points';
  }

  @override
  String get statistics_average_mood_most_frequent => 'Most frequent mood';

  @override
  String get statistics_average_mood_recent_trend => 'Recent 7-day trend';

  @override
  String get statistics_trend_rising => 'Rising';

  @override
  String get statistics_trend_falling => 'Falling';

  @override
  String get statistics_trend_stable => 'Stable';

  @override
  String get statistics_mood_positive_message =>
      'You\'re maintaining a generally positive mood!';

  @override
  String get statistics_mood_negative_message =>
      'You\'re going through a tough time. Take some time to care for yourself.';

  @override
  String get statistics_writing_frequency_title => 'Writing Frequency';

  @override
  String get statistics_writing_frequency_this_week => 'This Week';

  @override
  String get statistics_writing_frequency_count_unit => 'times';

  @override
  String get statistics_writing_frequency_daily => 'Daily record!';

  @override
  String get statistics_writing_frequency_often => 'Frequent records';

  @override
  String get statistics_writing_frequency_normal => 'Normal';

  @override
  String get statistics_writing_frequency_sometimes => 'Sometimes';

  @override
  String get statistics_writing_frequency_none => 'No records';

  @override
  String get statistics_writing_frequency_weekly_avg => 'Weekly avg';

  @override
  String get statistics_writing_frequency_monthly_avg => 'Monthly avg';

  @override
  String statistics_writing_frequency_weekly_count(String count) {
    return '$count times';
  }

  @override
  String statistics_writing_frequency_monthly_count(String count) {
    return '$count times';
  }

  @override
  String get statistics_writing_frequency_most_active_time =>
      'Most active time';

  @override
  String get statistics_writing_frequency_most_active_day => 'Most active day';

  @override
  String get statistics_time_morning => 'Morning';

  @override
  String get statistics_time_afternoon => 'Afternoon';

  @override
  String get statistics_time_evening => 'Evening';

  @override
  String get statistics_time_night => 'Night';

  @override
  String statistics_time_with_hour(String timeOfDay, int hour) {
    return '$timeOfDay ($hour o\'clock)';
  }

  @override
  String get statistics_writing_frequency_good_habit =>
      'You\'re recording consistently! Excellent!';

  @override
  String get statistics_writing_frequency_encouragement =>
      'Try recording a bit more often. Small moments are precious too!';

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
  String get settings_common_app_lock_title => 'App Lock';

  @override
  String get settings_common_app_lock_subtitle =>
      'Lock the app with biometrics or a passcode.';

  @override
  String get settings_common_theme_title => 'Theme';

  @override
  String get settings_common_theme_subtitle => 'Choose brightness theme.';

  @override
  String get settings_common_theme_light => 'Light Theme';

  @override
  String get settings_common_theme_dark => 'Dark Theme';

  @override
  String get settings_common_theme_system => 'System Theme';

  @override
  String get settings_common_color_theme_title => 'Color Theme';

  @override
  String get settings_common_color_theme_subtitle => 'Choose color theme.';

  @override
  String get settings_common_language_title => 'Language';

  @override
  String get settings_common_language_dialog_title => 'Select Language';

  @override
  String get settings_common_font_family_title => 'Font';

  @override
  String get settings_common_font_family_pretendard => 'Pretendard';

  @override
  String get settings_common_font_family_leeSeoyun => 'Lee Seoyun';

  @override
  String get settings_common_font_family_orbitOfTheMoon => 'Orbit of the Moon';

  @override
  String get settings_common_font_family_restart => 'Restart';

  @override
  String get settings_common_font_family_overcome => 'Overcome';

  @override
  String get settings_common_font_family_system => 'System Default';

  @override
  String get settings_data_title => 'Data';

  @override
  String get settings_data_auto_sync_title => 'Auto Sync';

  @override
  String get settings_data_auto_sync_subtitle =>
      'Automatically sync your data.';

  @override
  String get settings_data_backup_title => 'Data Backup';

  @override
  String get settings_data_backup_subtitle =>
      'Securely back up your data to the cloud.';

  @override
  String get settings_data_restore_title => 'Data Restore';

  @override
  String get settings_data_restore_subtitle =>
      'Restore your data from the cloud.';

  @override
  String get settings_data_backup_confirm =>
      'Are you sure you want to back up your data?';

  @override
  String get settings_data_backup_confirm_ok => 'Backup';

  @override
  String get settings_data_cache_cleanup_title => 'Clear Cache';

  @override
  String get settings_data_cache_cleanup_subtitle => 'Delete temporary files.';

  @override
  String get settings_data_cache_cleanup_confirm =>
      'Do you want to clear cache?\nThis action cannot be undone.';

  @override
  String get settings_ai_personality_changed =>
      'AI personality has been changed.';

  @override
  String get settings_information_title => 'Information';

  @override
  String get settings_information_app_title => 'App Info';

  @override
  String get settings_information_app_subtitle =>
      'Version and build information';

  @override
  String get settings_information_app_version => 'App Version';

  @override
  String get settings_information_app_build => 'Build Version';

  @override
  String get settings_information_app_developer => 'Developer';

  @override
  String get settings_information_license_title => 'License';

  @override
  String get settings_information_license_subtitle => 'License information';

  @override
  String get settings_information_faq_title => 'Help';

  @override
  String get settings_information_faq_subtitle => 'Usage and FAQ';

  @override
  String get settings_information_qna_title => 'Contact Us';

  @override
  String get settings_information_qna_subtitle => 'Contact the developer.';

  @override
  String get profile_title => 'Profile';

  @override
  String get profile_account_title => 'Account Information';

  @override
  String get profile_nickname_title => 'Change Nickname';

  @override
  String get profile_nickname_hint => 'Enter new nickname.';

  @override
  String get profile_creation_time_title => 'Join Date';

  @override
  String get profile_uid_title => 'User ID';

  @override
  String get profile_button_login => 'Go to Login';

  @override
  String get profile_button_logout => 'Logout';

  @override
  String get write_ai_limit_reached =>
      'AI responses are limited to once per day. Please try again tomorrow!';

  @override
  String get write_timestamp_add => 'Add Time';

  @override
  String get write_location_add => 'Add Location';

  @override
  String get common_language_korean => '한국어';

  @override
  String get common_language_english => 'English';

  @override
  String get common_language_japanese => '日本語';

  @override
  String get common_language_chinese => '中文';

  @override
  String get common_language_spanish => 'Español';

  @override
  String get common_language_italian => 'Italiano';

  @override
  String get common_language_french => 'Français';

  @override
  String get common_language_vietnamese => 'Tiếng Việt';

  @override
  String get common_language_thai => 'ไทย';

  @override
  String get common_developing => 'In Development';

  @override
  String get settings_user_info_title => 'Login Information';

  @override
  String get settings_user_info_empty => 'No login information.';

  @override
  String get settings_user_info_status => 'Status';

  @override
  String get settings_user_info_anonymous => 'Anonymous Login';

  @override
  String get settings_user_info_logged_in => 'Logged In';

  @override
  String get dialog_storage_init_title => 'Initialize Storage';

  @override
  String get dialog_storage_init_content => 'Initialize SharedPreferences.';

  @override
  String get dialog_database_init_title => 'Initialize Database';

  @override
  String get dialog_database_init_content => 'Initialize SQLite database.';

  @override
  String get dialog_init_button => 'Initialize';

  @override
  String get settings_developer_options => 'Developer Options';

  @override
  String get settings_developer_mode_only => 'Developer mode only';

  @override
  String get settings_ai_section_title => 'AI Settings';

  @override
  String get settings_ai_personality_title => 'AI Personality';

  @override
  String get snackbar_backup_completed => 'Backup completed.';

  @override
  String get snackbar_restore_completed => 'Data restore completed.';

  @override
  String get snackbar_cache_cleared => 'Cache cleared.';

  @override
  String get backup_in_progress => 'Backing up data...';

  @override
  String get restore_in_progress => 'Restoring data...';

  @override
  String get backup_failed => 'Backup failed. Please try again.';

  @override
  String get restore_failed_no_backup => 'Restore failed. No backup found.';

  @override
  String get restore_failed_general => 'Restore failed. Please try again.';

  @override
  String auth_terms_message(String terms, String privacy) {
    return 'By continuing, you agree to the $terms and $privacy.';
  }

  @override
  String get auth_terms_of_service => 'Terms of Service';

  @override
  String get auth_privacy_policy => 'Privacy Policy';

  @override
  String get app_info_copyright => '© 2024 All rights reserved';

  @override
  String get app_info_developer => 'Your Name';

  @override
  String get profile_sign_out_title => 'Sign Out';

  @override
  String get profile_sign_out_message => 'Are you sure you want to sign out?';

  @override
  String get profile_delete_account_button => 'Delete Account';

  @override
  String get profile_delete_account_button_description =>
      'Delete your current account.';

  @override
  String get profile_delete_account_dialog_title => 'Delete Account';

  @override
  String get profile_delete_account_dialog_content =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get profile_delete_account_dialog_warning =>
      'All your data will be permanently deleted.';

  @override
  String get profile_delete_account_dialog_confirm => 'Delete Account';

  @override
  String get profile_delete_account_dialog_password_input_hint =>
      'Enter your password';

  @override
  String get profile_delete_account_dialog_password_description =>
      'You must enter your password to delete your account.';

  @override
  String journal_count(int count) {
    return '$count entries';
  }

  @override
  String get location_current => 'Current Location';

  @override
  String get location_add_location => 'Add Location';

  @override
  String get tags_manage_title => 'Manage Tags';

  @override
  String get tags_manage_subtitle => 'View and manage your tags';

  @override
  String get tags_filter_all => 'All';

  @override
  String get tags_filter_title => 'Filter by Tags';

  @override
  String get tags_suggested_title => 'Suggested Tags';

  @override
  String get tags_selected_title => 'Selected Tags';

  @override
  String get tags_add_new => 'Add New Tag';

  @override
  String get tags_input_hint => 'Tag name';

  @override
  String get tags_delete_title => 'Delete Tag';

  @override
  String tags_delete_message(String tagName) {
    return 'Do you want to delete \"$tagName\"? This tag will be removed from all diary entries.';
  }

  @override
  String tags_delete_success(String tagName) {
    return 'Tag \"$tagName\" has been deleted';
  }

  @override
  String get tags_no_tags => 'No tags';

  @override
  String get tags_load_failed => 'Failed to load tags';

  @override
  String get tags_delete_failed => 'Failed to delete tag';

  @override
  String get tags_menu_edit => 'Edit';

  @override
  String get tags_menu_delete => 'Delete';

  @override
  String get home_monthly_tracker_title => 'Monthly Journaling';

  @override
  String get home_yearly_tracker_title => 'This Year\'s Diary Writing';

  @override
  String get home_monthly_tracker_legend_less => 'Less';

  @override
  String get home_monthly_tracker_legend_more => 'More';

  @override
  String get common_unit_day => 'day';

  @override
  String get entries_mood_filter_title => 'Filter by Mood';

  @override
  String get statistics_mood_distribution_empty =>
      'No mood distribution data to display.';

  @override
  String get statistics_mood_distribution_description => 'Mood Distribution';

  @override
  String get statistics_mood_trend_description => 'Mood Changes';

  @override
  String get statistics_mood_trend_daily_records => 'Daily Mood Records';

  @override
  String get statistics_mood_trend_overall_average => 'Overall Average Score';

  @override
  String get statistics_mood_trend_recent_7days_average =>
      'Recent 7-day average';

  @override
  String get statistics_ai_report_title => 'AI Analysis Report';

  @override
  String get statistics_ai_report_subtitle =>
      'Let AI analyze your mood patterns in depth.';

  @override
  String get ai_report_positive_keywords => 'Positive Keywords';

  @override
  String get ai_report_negative_keywords => 'Negative Keywords';

  @override
  String get ai_report_emotional_pattern => 'Emotional Pattern Analysis';

  @override
  String get ai_report_tag_correlation => 'Tag-Emotion Correlation';

  @override
  String get ai_report_no_keywords => 'No keywords found.';

  @override
  String get ai_report_not_enough_data =>
      'Not enough data to analyze. Please write more than 10 journals in 30 days.';

  @override
  String get home_representative_mood_title => 'My Current Emotion';

  @override
  String get home_representative_mood_description =>
      'Analysis of the last 30 days of emotions';

  @override
  String get home_representative_mood_empty => 'No emotional record';

  @override
  String get home_representative_mood_empty_description =>
      'Write a diary to record your emotions';

  @override
  String get calendar_month_jan => 'Jan';

  @override
  String get calendar_month_feb => 'Feb';

  @override
  String get calendar_month_mar => 'Mar';

  @override
  String get calendar_month_apr => 'Apr';

  @override
  String get calendar_month_may => 'May';

  @override
  String get calendar_month_jun => 'Jun';

  @override
  String get calendar_month_jul => 'Jul';

  @override
  String get calendar_month_aug => 'Aug';

  @override
  String get calendar_month_sep => 'Sep';

  @override
  String get calendar_month_oct => 'Oct';

  @override
  String get calendar_month_nov => 'Nov';

  @override
  String get calendar_month_dec => 'Dec';

  @override
  String get calendar_weekday_sun => 'Sun';

  @override
  String get calendar_weekday_mon => 'Mon';

  @override
  String get calendar_weekday_tue => 'Tue';

  @override
  String get calendar_weekday_wed => 'Wed';

  @override
  String get calendar_weekday_thu => 'Thu';

  @override
  String get calendar_weekday_fri => 'Fri';

  @override
  String get calendar_weekday_sat => 'Sat';

  @override
  String get tags_dialog_title => 'Manage Tags';

  @override
  String get tags_dialog_empty => 'No tags';

  @override
  String get tags_dialog_close => 'Close';

  @override
  String get tags_dialog_delete_title => 'Delete Tag';

  @override
  String tags_dialog_delete_message(String tagName) {
    return 'Do you want to delete \"$tagName\"? This tag will be removed from all diary entries.';
  }

  @override
  String tags_dialog_created(String date) {
    return 'Created: $date';
  }

  @override
  String get journal_image_detail_gesture_hint =>
      'Double tap to zoom in/out, pinch to adjust freely';

  @override
  String get profile_delete_account_reauthentication_required =>
      'Reauthentication is required to delete your account.';

  @override
  String get profile_delete_account_reauthentication_google =>
      'Reauthenticate with Google account';

  @override
  String get profile_delete_account_reauthentication_apple =>
      'Reauthenticate with Apple account';

  @override
  String get profile_delete_account_reauthentication_failed =>
      'Reauthentication failed. Please try again.';

  @override
  String get profile_delete_account_success =>
      'Account has been successfully deleted.';

  @override
  String get profile_delete_account_error =>
      'An error occurred while deleting your account.';

  @override
  String get profile_delete_account_apple_revoke_failed =>
      'Failed to revoke Apple account connection, but account deletion will proceed.';

  @override
  String get profile_delete_account_apple_revoke_success =>
      'Apple account connection has been revoked.';

  @override
  String get profile_delete_account_apple_manual_revoke_guide =>
      'For complete Apple account disconnection:\n\n1️⃣ Web: appleid.apple.com → Sign-In and Security → Apps using Apple ID → Delete the app\n\n2️⃣ iPhone: Settings → Apple ID → Password & Security → Apple ID logins → Delete the app\n\nThis will allow you to choose email sharing preferences on your next login.';

  @override
  String get weather_current_weather => 'Current Weather';

  @override
  String get weather_humidity => 'Humidity';

  @override
  String get weather_wind => 'Wind';

  @override
  String get weather_pressure => 'Pressure';

  @override
  String get location_journal_location => 'Journal Location';

  @override
  String get location_tap_to_open => 'Tap to open';

  @override
  String get location_map_load_error => 'Unable to load map';

  @override
  String get location_address => 'Address';

  @override
  String get location_no_address => 'No address information';

  @override
  String get location_coordinates => 'Coordinates';

  @override
  String get location_open_in_google_maps => 'Open in Google Maps';

  @override
  String get profile_guest_mode => 'You are in guest mode.';

  @override
  String get profile_guest_login_button => 'Switch to Social Login';

  @override
  String get profile_guest_login_description =>
      'Sign in with Google or Apple and sync your data.';

  @override
  String get lockScreenTitle => 'Authentication Required';

  @override
  String get lockScreenReason => 'Please authenticate to unlock the app.';

  @override
  String get lockScreenRetry => 'Retry';

  @override
  String get lockScreenConfirmTitle => 'Confirm your PIN';

  @override
  String get lockScreenCancel => 'Cancel';

  @override
  String get lockScreenProFeature =>
      'This feature is available in the Pro version.';

  @override
  String get settings_common_lock_type_title => 'Lock Type';

  @override
  String get settings_common_lock_type_subtitle => 'Biometric or PIN';

  @override
  String get lock_type_none => 'None';

  @override
  String get lock_type_biometric => 'Biometric';

  @override
  String get lock_type_pin => 'PIN (4 digits)';

  @override
  String get proFeatureDialogTitle => 'Pro Feature';

  @override
  String get proFeatureDialogContent =>
      'App Lock is a Pro feature. Upgrade to enjoy all premium features!';

  @override
  String get proFeatureDialogUpgradeButton => 'Upgrade';

  @override
  String home_selection_count(int count) {
    return '$count selected';
  }

  @override
  String home_delete_journals_confirm_message(int count) {
    return 'Are you sure you want to delete $count journal entries?';
  }
}
