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
  String get common_date_full => 'yyyy. MM. dd';

  @override
  String get common_confirm_cancel => 'Cancel';

  @override
  String get common_confirm_ok => 'OK';

  @override
  String get common_confirm_delete => 'Delete';

  @override
  String get common_confirm_save => 'Save';

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
  String get onboarding_welcome_title => 'Welcome to MoodLog!';

  @override
  String get onboarding_welcome_description1 =>
      'MoodLog is an app where you can record your daily emotions and receive AI responses.';

  @override
  String get onboarding_welcome_description2 =>
      'Record your emotions daily and read AI responses.';

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
      'Balances empathy and realistic advice.';

  @override
  String get onboarding_personality_compassionate_title =>
      'Compassionate Healer';

  @override
  String get onboarding_personality_compassionate_description =>
      'Provides warm comfort and deep empathy.';

  @override
  String get onboarding_personality_hint =>
      'You can change the setting anytime in the settings menu.';

  @override
  String get onboarding_success_title => 'You\'re ready to start!';

  @override
  String get onboarding_success_description => 'Shall we start MoodLog?';

  @override
  String get onboarding_success_next => 'Start!';

  @override
  String get signin_title => 'You\'re ready to start!';

  @override
  String get signin_growth => 'Record your emotions.';

  @override
  String get signin_login_title => 'Save your entries by logging in.';

  @override
  String get signin_button_guest => 'Start as Guest';

  @override
  String get signin_button_google => 'Start with Google';

  @override
  String get signin_button_kakao => 'Start with Kakao';

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
  String get entries_empty_box_title => 'No entries yet.';

  @override
  String get entries_empty_box_description => 'Your entries will appear here.';

  @override
  String get entries_empty_box_button => 'Start writing';

  @override
  String get entries_calendar_legend_has_journal => 'Has entry';

  @override
  String get entries_calendar_legend_today => 'Today';

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
  String get write_title => 'Write Entry';

  @override
  String get write_edit_title => 'Edit Entry';

  @override
  String get write_mood_title => 'How are you feeling today?';

  @override
  String get write_mood_subtitle => 'Please select your mood';

  @override
  String get write_input_title => 'Content';

  @override
  String get write_input_hint => 'Record your emotions and experiences today.';

  @override
  String get write_ai_title => 'AI Comfort Message';

  @override
  String get write_ai_description =>
      'After writing your diary, AI will send you comfort and encouragement messages.';

  @override
  String get write_location_remove => 'Remove';

  @override
  String get journal_delete_confirm_title => 'Delete Confirmation';

  @override
  String get journal_delete_confirm_description =>
      'Are you sure you want to delete this entry?';

  @override
  String get journal_ai_generating_response_title =>
      'AI is writing a response.';

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
  String get statistics_total_records_count_unit => 'records';

  @override
  String get statistics_total_records_first_record => 'First record';

  @override
  String get statistics_total_records_period => 'Recording period';

  @override
  String statistics_total_records_period_days(int days) {
    return '$days days';
  }

  @override
  String get statistics_total_records_avg_frequency => 'Average frequency';

  @override
  String statistics_total_records_weekly_frequency(String frequency) {
    return '$frequency times/week';
  }

  @override
  String get statistics_streak_status_active => 'Active';

  @override
  String get statistics_streak_status_inactive => 'Inactive';

  @override
  String get statistics_streak_last_record => 'Last record';

  @override
  String statistics_streak_days_ago(int days) {
    return '$days days ago';
  }

  @override
  String get statistics_streak_stopped => 'Consecutive record stopped';

  @override
  String statistics_streak_stopped_days(int days) {
    return '$days days ago';
  }

  @override
  String get statistics_streak_encouragement =>
      'Great! You\'re maintaining a consecutive record';

  @override
  String get statistics_max_streak_new_record => 'New record!';

  @override
  String get statistics_max_streak_progress => 'Current progress';

  @override
  String get statistics_max_streak_remaining => 'Until maximum record';

  @override
  String statistics_max_streak_remaining_days(int days) {
    return '$days days remaining';
  }

  @override
  String get statistics_max_streak_achievement_week =>
      'One week consecutive record achieved! You\'re doing great!';

  @override
  String get statistics_max_streak_achievement_two_weeks =>
      'Two weeks consecutive record achieved! Fantastic!';

  @override
  String get statistics_max_streak_achievement_month =>
      'One month consecutive record achieved! Really impressive!';

  @override
  String get statistics_average_mood_title => 'Average mood';

  @override
  String statistics_average_mood_score(String score) {
    return 'Average $score points';
  }

  @override
  String get statistics_average_mood_most_frequent =>
      'Most frequently felt mood';

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
      'It seems you\'re going through difficult times. Take time to take care of yourself.';

  @override
  String get statistics_writing_frequency_title => 'Writing frequency';

  @override
  String get statistics_writing_frequency_this_week => 'This week';

  @override
  String get statistics_writing_frequency_count_unit => 'times';

  @override
  String get statistics_writing_frequency_daily => 'Daily recording!';

  @override
  String get statistics_writing_frequency_often => 'Frequent recording';

  @override
  String get statistics_writing_frequency_normal => 'Normal';

  @override
  String get statistics_writing_frequency_sometimes => 'Sometimes';

  @override
  String get statistics_writing_frequency_none => 'No records';

  @override
  String get statistics_writing_frequency_weekly_avg => 'Weekly average';

  @override
  String get statistics_writing_frequency_monthly_avg => 'Monthly average';

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
    return '$timeOfDay (${hour}h)';
  }

  @override
  String get statistics_writing_frequency_good_habit =>
      'You\'re recording consistently! Excellent!';

  @override
  String get statistics_writing_frequency_encouragement =>
      'Try recording more frequently. Small moments are precious too!';

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
  String get settings_common_theme_light => 'Light Theme';

  @override
  String get settings_common_theme_dark => 'Dark Theme';

  @override
  String get settings_common_theme_system => 'System Theme';

  @override
  String get settings_common_color_theme_title => 'Color Theme';

  @override
  String get settings_common_color_theme_subtitle => 'Select color theme.';

  @override
  String get settings_common_language_title => 'Language';

  @override
  String get settings_common_language_dialog_title => 'Select Language';

  @override
  String get settings_common_font_family_title => 'Font';

  @override
  String get settings_common_font_family_pretendard => 'Pretendard';

  @override
  String get settings_common_font_family_leeSeoyun => 'LeeSeoyun';

  @override
  String get settings_common_font_family_orbitOfTheMoon => 'Orbit of the Moon';

  @override
  String get settings_common_font_family_restart => 'Restart';

  @override
  String get settings_common_font_family_overcome => 'Overcome';

  @override
  String get settings_common_font_family_system => 'System Font';

  @override
  String get settings_data_title => 'Data';

  @override
  String get settings_data_auto_sync_title => 'Auto Sync';

  @override
  String get settings_data_auto_sync_subtitle => 'Automatically sync data.';

  @override
  String get settings_data_backup_title => 'Data Backup';

  @override
  String get settings_data_backup_subtitle => 'Back up data.';

  @override
  String get settings_data_backup_confirm => 'Do you want to backup your data?';

  @override
  String get settings_data_backup_confirm_ok => 'Backup';

  @override
  String get settings_data_cache_cleanup_title => 'Clear Cache';

  @override
  String get settings_data_cache_cleanup_subtitle => 'Delete temporary files.';

  @override
  String get settings_data_cache_cleanup_confirm =>
      'Do you want to delete the cache?\nThis action cannot be undone.';

  @override
  String get settings_ai_personality_changed =>
      'AI personality has been changed.';

  @override
  String get settings_information_title => 'Information';

  @override
  String get settings_information_app_title => 'App Information';

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

  @override
  String get profile_title => 'Profile';

  @override
  String get profile_account_title => 'Account Information';

  @override
  String get profile_nickname_title => 'Change Nickname';

  @override
  String get profile_nickname_hint => 'Please enter a new nickname';

  @override
  String get profile_creation_time_title => 'Join Date';

  @override
  String get profile_uid_title => 'User ID';

  @override
  String get profile_button_login => 'Go to SignIn';

  @override
  String get profile_button_logout => 'Logout';

  @override
  String get write_ai_limit_reached =>
      'AI responses are limited to once per day. Try again tomorrow!';

  @override
  String get write_timestamp_add => 'Add Time';

  @override
  String get write_location_add => 'Add Location';

  @override
  String get common_language_korean => 'Korean';

  @override
  String get common_language_english => 'English';

  @override
  String get common_language_japanese => 'Japanese';

  @override
  String get common_language_chinese => 'Chinese';

  @override
  String get common_language_spanish => 'Spanish';

  @override
  String get common_language_italian => 'Italian';

  @override
  String get common_language_french => 'French';

  @override
  String get common_language_vietnamese => 'Vietnamese';

  @override
  String get common_language_thai => 'Thai';

  @override
  String get common_developing => 'In Development';

  @override
  String get settings_user_info_title => 'Login Information';

  @override
  String get settings_user_info_empty => 'No login information available.';

  @override
  String get settings_user_info_status => 'Status';

  @override
  String get settings_user_info_anonymous => 'Anonymous Login';

  @override
  String get settings_user_info_logged_in => 'Logged In';

  @override
  String get dialog_storage_init_title => 'Storage Initialization';

  @override
  String get dialog_storage_init_content => 'Initialize SharedPreferences.';

  @override
  String get dialog_database_init_title => 'Database Initialization';

  @override
  String get dialog_database_init_content => 'Initialize SQLite database.';

  @override
  String get dialog_init_button => 'Initialize';

  @override
  String get settings_developer_options => 'Developer Options';

  @override
  String get settings_developer_mode_only => 'Debug mode only';

  @override
  String get settings_ai_section_title => 'AI Settings';

  @override
  String get settings_ai_personality_title => 'AI Personality';

  @override
  String get snackbar_backup_completed => 'Backup completed.';

  @override
  String get snackbar_cache_cleared => 'Cache cleared.';

  @override
  String auth_terms_message(String terms, String privacy) {
    return 'By continuing, you agree to our $terms and $privacy.';
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
  String journal_count(int count) {
    return '$count entries';
  }

  @override
  String get location_current => 'Current location';

  @override
  String get location_add_location => 'Add location';

  @override
  String get tags_manage_title => 'Manage Tags';

  @override
  String get tags_manage_subtitle => 'View and manage your tags';

  @override
  String get tags_filter_all => 'All';

  @override
  String get tags_filter_title => 'Filter by tags';

  @override
  String get tags_suggested_title => 'Suggested Tags';

  @override
  String get tags_add_new => 'Add new tag';

  @override
  String get tags_input_hint => 'Tag name';

  @override
  String get tags_delete_title => 'Delete Tag';

  @override
  String tags_delete_message(String tagName) {
    return 'Are you sure you want to delete \"$tagName\"? This will remove the tag from all journals.';
  }

  @override
  String tags_delete_success(String tagName) {
    return 'Tag \"$tagName\" deleted';
  }

  @override
  String get tags_no_tags => 'No tags found';

  @override
  String get tags_load_failed => 'Failed to load tags';

  @override
  String get tags_delete_failed => 'Failed to delete tag';

  @override
  String get common_unit_day => 'day';
}
