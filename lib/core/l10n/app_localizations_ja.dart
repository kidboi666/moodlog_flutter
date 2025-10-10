// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get common_date_today => '今日';

  @override
  String get common_date_tomorrow => '明日';

  @override
  String get common_date_yesterday => '昨日';

  @override
  String get common_date_full => 'yyyy年MM月dd日';

  @override
  String get common_confirm_cancel => 'キャンセル';

  @override
  String get common_confirm_ok => 'OK';

  @override
  String get common_confirm_delete => '削除';

  @override
  String get common_confirm_save => '保存';

  @override
  String get common_reset => 'リセット';

  @override
  String get common_email => 'メール';

  @override
  String get common_phone => '電話';

  @override
  String get common_mood_verygood => 'とても良い';

  @override
  String get common_mood_good => '良い';

  @override
  String get common_mood_neutral => '普通';

  @override
  String get common_mood_bad => '悪い';

  @override
  String get common_mood_verybad => 'とても悪い';

  @override
  String get common_month_jan => '1月';

  @override
  String get common_month_feb => '2月';

  @override
  String get common_month_mar => '3月';

  @override
  String get common_month_apr => '4月';

  @override
  String get common_month_may => '5月';

  @override
  String get common_month_jun => '6月';

  @override
  String get common_month_jul => '7月';

  @override
  String get common_month_aug => '8月';

  @override
  String get common_month_sep => '9月';

  @override
  String get common_month_oct => '10月';

  @override
  String get common_month_nov => '11月';

  @override
  String get common_month_dec => '12月';

  @override
  String get common_weekday_mon => '月曜日';

  @override
  String get common_weekday_tue => '火曜日';

  @override
  String get common_weekday_wed => '水曜日';

  @override
  String get common_weekday_thu => '木曜日';

  @override
  String get common_weekday_fri => '金曜日';

  @override
  String get common_weekday_sat => '土曜日';

  @override
  String get common_weekday_sun => '日曜日';

  @override
  String get common_weekday_mon_short => '月';

  @override
  String get common_weekday_tue_short => '火';

  @override
  String get common_weekday_wed_short => '水';

  @override
  String get common_weekday_thu_short => '木';

  @override
  String get common_weekday_fri_short => '金';

  @override
  String get common_weekday_sat_short => '土';

  @override
  String get common_weekday_sun_short => '日';

  @override
  String get onboarding_welcome_title => 'ムードログへようこそ！';

  @override
  String get onboarding_welcome_description1 =>
      'ムードログは、日常の感情を記録し、AIからの返信を受け取ることができるアプリです。';

  @override
  String get onboarding_welcome_description2 => '毎日感情を記録して、AIからの返信を読んでみましょう。';

  @override
  String get onboarding_welcome_next => '一緒に準備してみませんか？';

  @override
  String get onboarding_nickname_title => 'ニックネーム設定';

  @override
  String get onboarding_nickname_description => 'ムードログで使用するニックネームを入力してください';

  @override
  String get onboarding_nickname_input_title => 'ニックネーム';

  @override
  String get onboarding_nickname_input_hint => 'ニックネームを入力してください（2〜10文字）';

  @override
  String get onboarding_nickname_next => 'ニックネームはいつでも設定メニューで変更できます。';

  @override
  String get onboarding_nickname_input_error => 'ニックネームを入力してください。';

  @override
  String get onboarding_personality_title => '返信スタイルを決める';

  @override
  String get onboarding_personality_description =>
      'あなたの日記に返信してくれるAIの性格を選択してください。';

  @override
  String get onboarding_personality_rational_title => '冷静な分析者';

  @override
  String get onboarding_personality_rational_description =>
      '客観的で実用的なアドバイスを提供します';

  @override
  String get onboarding_personality_balanced_title => 'バランス型アドバイザー';

  @override
  String get onboarding_personality_balanced_description =>
      '共感と現実的なアドバイスのバランスを取ります。';

  @override
  String get onboarding_personality_compassionate_title => '優しいヒーラー';

  @override
  String get onboarding_personality_compassionate_description =>
      '温かい慰めと深い共感を伝えます。';

  @override
  String get onboarding_personality_hint => '設定でいつでも変更できます。';

  @override
  String get onboarding_success_title => '始める準備ができました！';

  @override
  String get onboarding_success_description => 'ムードログを始めてみませんか？';

  @override
  String get onboarding_success_next => '開始する';

  @override
  String get signin_title => '始める準備ができました！';

  @override
  String get signin_growth => '成長する心を記録しましょう。';

  @override
  String get signin_login_title => '登録して記録を保存しましょう。';

  @override
  String get signin_button_guest => 'ゲストとして開始';

  @override
  String get signin_button_google => 'Googleアカウントで開始';

  @override
  String get signin_button_apple => 'Appleアカウントで開始';

  @override
  String get home_hello => 'こんにちは！';

  @override
  String home_welcome(Object nickname) {
    return '$nicknameさん。';
  }

  @override
  String get home_howareyou => '今日の気分はいかがですか？';

  @override
  String get home_empty_box => 'あなたのストーリーを待っています。';

  @override
  String get entries_empty_box_title => '作成された日記がありません。';

  @override
  String get entries_empty_box_description => '作成した日記がここに表示されます。';

  @override
  String get entries_empty_box_button => '日記を書きに行く';

  @override
  String get entries_calendar_legend_has_journal => '日記あり';

  @override
  String get entries_calendar_legend_today => '今日';

  @override
  String get tab_home => 'ホーム';

  @override
  String get tab_entries => '記録';

  @override
  String get tab_settings => '設定';

  @override
  String get tab_write => '書く';

  @override
  String get tab_statistics => '統計';

  @override
  String get write_title => '日記作成';

  @override
  String get write_edit_title => '日記編集';

  @override
  String get write_mood_title => '今日の気分はいかがですか？';

  @override
  String get write_mood_subtitle => '気分を選択してください';

  @override
  String get write_input_title => '内容';

  @override
  String get write_input_hint => '今日の感情と体験を記録してみてください。';

  @override
  String get write_ai_title => 'AI慰めメッセージ';

  @override
  String get write_ai_description => '日記作成後、AIが慰めと励ましのメッセージを送ります。';

  @override
  String get write_location_remove => '削除';

  @override
  String get journal_delete_confirm_title => '削除確認';

  @override
  String get journal_delete_confirm_description => 'この項目を削除しますか？';

  @override
  String get journal_ai_generating_response_title => 'AIが返信を作成中です。';

  @override
  String get statistics_total_title => '全体統計';

  @override
  String get statistics_total_record_description => '総記録';

  @override
  String statistics_total_record(Object count) {
    return '$count個';
  }

  @override
  String get statistics_total_streak_description => '連続記録';

  @override
  String statistics_total_streak(Object count) {
    return '$count日';
  }

  @override
  String get statistics_total_streak_max_description => '最大連続記録';

  @override
  String statistics_total_streak_max(Object count) {
    return '$count日';
  }

  @override
  String get statistics_mood_calendar_title => '感情カレンダー';

  @override
  String get statistics_mood_distribution_title => '気分分布';

  @override
  String statistics_mood_distribution_unit(Object count) {
    return '$count回';
  }

  @override
  String get statistics_mood_trend_title => '気分推移';

  @override
  String get statistics_mood_trend_empty => '気分推移データがありません。';

  @override
  String get statistics_recent_title => '最近の日記';

  @override
  String get statistics_recent_empty => '最近の日記がありません。';

  @override
  String get statistics_total_records_count_unit => '個の記録';

  @override
  String get statistics_total_records_first_record => '最初の記録';

  @override
  String get statistics_total_records_period => '記録期間';

  @override
  String statistics_total_records_period_days(int days) {
    return '$days日';
  }

  @override
  String get statistics_total_records_avg_frequency => '平均頻度';

  @override
  String statistics_total_records_weekly_frequency(String frequency) {
    return '$frequency回/週';
  }

  @override
  String get statistics_streak_status_active => '進行中';

  @override
  String get statistics_streak_status_inactive => '中断';

  @override
  String get statistics_streak_last_record => '最後の記録';

  @override
  String statistics_streak_days_ago(int days) {
    return '$days日前';
  }

  @override
  String get statistics_streak_stopped => '連続記録中断';

  @override
  String statistics_streak_stopped_days(int days) {
    return '$days日前';
  }

  @override
  String get statistics_streak_encouragement => '素晴らしい！連続記録を続けています';

  @override
  String get statistics_max_streak_new_record => '新記録！';

  @override
  String get statistics_max_streak_progress => '現在の進捗';

  @override
  String get statistics_max_streak_remaining => '最高記録まで';

  @override
  String statistics_max_streak_remaining_days(int days) {
    return 'あと$days日';
  }

  @override
  String get statistics_max_streak_achievement_week => '1週間連続記録達成！よくやっています！';

  @override
  String get statistics_max_streak_achievement_two_weeks => '2週間連続記録達成！素晴らしい！';

  @override
  String get statistics_max_streak_achievement_month => '1か月連続記録達成！本当にすごいです！';

  @override
  String get statistics_average_mood_title => '平均気分';

  @override
  String statistics_average_mood_score(String score) {
    return '平均$score点';
  }

  @override
  String get statistics_average_mood_most_frequent => '最も頻繁に感じた気分';

  @override
  String get statistics_average_mood_recent_trend => '最近7日間の推移';

  @override
  String get statistics_trend_rising => '上昇';

  @override
  String get statistics_trend_falling => '下降';

  @override
  String get statistics_trend_stable => '安定';

  @override
  String get statistics_mood_positive_message => '全体的にポジティブな気分を維持していますね！';

  @override
  String get statistics_mood_negative_message =>
      'つらい時間を過ごしていますね。自分を労わる時間を作ってみてください。';

  @override
  String get statistics_writing_frequency_title => '作成頻度';

  @override
  String get statistics_writing_frequency_this_week => '今週';

  @override
  String get statistics_writing_frequency_count_unit => '回';

  @override
  String get statistics_writing_frequency_daily => '毎日記録！';

  @override
  String get statistics_writing_frequency_often => '頻繁に記録';

  @override
  String get statistics_writing_frequency_normal => '普通';

  @override
  String get statistics_writing_frequency_sometimes => '時々';

  @override
  String get statistics_writing_frequency_none => '記録なし';

  @override
  String get statistics_writing_frequency_weekly_avg => '週平均';

  @override
  String get statistics_writing_frequency_monthly_avg => '月平均';

  @override
  String statistics_writing_frequency_weekly_count(String count) {
    return '$count回';
  }

  @override
  String statistics_writing_frequency_monthly_count(String count) {
    return '$count回';
  }

  @override
  String get statistics_writing_frequency_most_active_time => '最も活発な時間';

  @override
  String get statistics_writing_frequency_most_active_day => '最も活発な曜日';

  @override
  String get statistics_time_morning => '午前';

  @override
  String get statistics_time_afternoon => '午後';

  @override
  String get statistics_time_evening => '夕方';

  @override
  String get statistics_time_night => '夜';

  @override
  String statistics_time_with_hour(String timeOfDay, int hour) {
    return '$timeOfDay（$hour時）';
  }

  @override
  String get statistics_writing_frequency_good_habit =>
      '着実に記録を続けていますね！素晴らしいです！';

  @override
  String get statistics_writing_frequency_encouragement =>
      'もう少し頻繁に記録してみてください。小さな瞬間も大切です！';

  @override
  String get settings_title => '設定';

  @override
  String get settings_common_title => '一般';

  @override
  String get settings_common_notification_title => '通知';

  @override
  String get settings_common_notification_subtitle => 'プッシュ通知を受け取ります。';

  @override
  String get settings_common_theme_title => 'テーマ';

  @override
  String get settings_common_theme_subtitle => '明るさテーマを選択します。';

  @override
  String get settings_common_theme_light => 'ライトテーマ';

  @override
  String get settings_common_theme_dark => 'ダークテーマ';

  @override
  String get settings_common_theme_system => 'システムテーマ';

  @override
  String get settings_common_color_theme_title => 'カラーテーマ';

  @override
  String get settings_common_color_theme_subtitle => 'カラーテーマを選択します。';

  @override
  String get settings_common_language_title => '言語';

  @override
  String get settings_common_language_dialog_title => '言語選択';

  @override
  String get settings_common_font_family_title => 'フォント';

  @override
  String get settings_common_font_family_pretendard => 'Pretendard';

  @override
  String get settings_common_font_family_leeSeoyun => 'イ・ソユン体';

  @override
  String get settings_common_font_family_orbitOfTheMoon => 'ナヌム手書き文字 月の軌道';

  @override
  String get settings_common_font_family_restart => 'ナヌム手書き文字 再スタート';

  @override
  String get settings_common_font_family_overcome => 'ナヌム手書き文字 私は乗り越える';

  @override
  String get settings_common_font_family_system => 'システム既定';

  @override
  String get settings_data_title => 'データ';

  @override
  String get settings_data_auto_sync_title => '自動同期';

  @override
  String get settings_data_auto_sync_subtitle => 'データを自動で同期します。';

  @override
  String get settings_data_backup_title => 'データバックアップ';

  @override
  String get settings_data_backup_subtitle => 'データをバックアップします。';

  @override
  String get settings_data_backup_confirm => 'データをバックアップしますか？';

  @override
  String get settings_data_backup_confirm_ok => 'バックアップ';

  @override
  String get settings_data_cache_cleanup_title => 'キャッシュクリア';

  @override
  String get settings_data_cache_cleanup_subtitle => '一時ファイルを削除します。';

  @override
  String get settings_data_cache_cleanup_confirm =>
      'キャッシュを削除しますか？\nこの操作は元に戻せません。';

  @override
  String get settings_ai_personality_changed => 'AI性格が変更されました。';

  @override
  String get settings_information_title => '情報';

  @override
  String get settings_information_app_title => 'アプリ情報';

  @override
  String get settings_information_app_subtitle => 'バージョンとライセンス情報';

  @override
  String get settings_information_app_version => 'バージョン';

  @override
  String get settings_information_app_build => 'ライセンス';

  @override
  String get settings_information_app_developer => '開発者';

  @override
  String get settings_information_faq_title => 'ヘルプ';

  @override
  String get settings_information_faq_subtitle => '使用方法とFAQ';

  @override
  String get settings_information_qna_title => 'お問い合わせ';

  @override
  String get settings_information_qna_subtitle => '開発者にお問い合わせします。';

  @override
  String get profile_title => 'プロフィール';

  @override
  String get profile_account_title => '登録情報';

  @override
  String get profile_nickname_title => 'ニックネーム変更';

  @override
  String get profile_nickname_hint => '新しいニックネームを入力してください。';

  @override
  String get profile_creation_time_title => '登録日';

  @override
  String get profile_uid_title => 'ユーザーID';

  @override
  String get profile_button_login => 'ログインしに行く';

  @override
  String get profile_button_logout => 'ログアウト';

  @override
  String get write_ai_limit_reached => 'AI返信は1日に1回のみ可能です。明日また試してください！';

  @override
  String get write_timestamp_add => '時間追加';

  @override
  String get write_location_add => '位置追加';

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
  String get common_developing => '開発中';

  @override
  String get settings_user_info_title => 'ログイン情報';

  @override
  String get settings_user_info_empty => 'ログイン情報がありません。';

  @override
  String get settings_user_info_status => 'ステータス';

  @override
  String get settings_user_info_anonymous => '匿名ログイン';

  @override
  String get settings_user_info_logged_in => 'ログイン';

  @override
  String get dialog_storage_init_title => 'ストレージ初期化';

  @override
  String get dialog_storage_init_content => 'SharedPreferencesを初期化します。';

  @override
  String get dialog_database_init_title => 'データベース初期化';

  @override
  String get dialog_database_init_content => 'SQLiteデータベースを初期化します。';

  @override
  String get dialog_init_button => '初期化';

  @override
  String get settings_developer_options => '開発者オプション';

  @override
  String get settings_developer_mode_only => '開発モード専用動作';

  @override
  String get settings_ai_section_title => 'AI設定';

  @override
  String get settings_ai_personality_title => 'AI性格';

  @override
  String get snackbar_backup_completed => 'バックアップが完了しました。';

  @override
  String get snackbar_cache_cleared => 'キャッシュが削除されました。';

  @override
  String auth_terms_message(String terms, String privacy) {
    return '続行することで$termsと$privacyに同意します。';
  }

  @override
  String get auth_terms_of_service => '利用規約';

  @override
  String get auth_privacy_policy => 'プライバシーポリシー';

  @override
  String get app_info_copyright => '© 2024 All rights reserved';

  @override
  String get app_info_developer => 'Your Name';

  @override
  String get profile_sign_out_title => 'ログアウト';

  @override
  String get profile_sign_out_message => '本当にログアウトしますか？';

  @override
  String get profile_delete_account_button => 'アカウント削除';

  @override
  String get profile_delete_account_button_description => '現在のアカウントを削除します。';

  @override
  String get profile_delete_account_dialog_title => 'アカウント削除';

  @override
  String get profile_delete_account_dialog_content =>
      'アカウントを削除しますか？この操作は元に戻すことができません。';

  @override
  String get profile_delete_account_dialog_warning => 'すべてのデータが永久に削除されます。';

  @override
  String get profile_delete_account_dialog_confirm => 'アカウント削除';

  @override
  String get profile_delete_account_dialog_password_input_hint =>
      'パスワードを入力してください';

  @override
  String get profile_delete_account_dialog_password_description =>
      'アカウントを削除するには、パスワードを入力する必要があります。';

  @override
  String journal_count(int count) {
    return '$count個';
  }

  @override
  String get location_current => '現在地';

  @override
  String get location_add_location => '位置を追加';

  @override
  String get tags_manage_title => 'タグ管理';

  @override
  String get tags_manage_subtitle => 'タグを表示・管理します';

  @override
  String get tags_filter_all => '全て';

  @override
  String get tags_filter_title => 'タグでフィルタ';

  @override
  String get tags_suggested_title => '推奨タグ';

  @override
  String get tags_selected_title => '選択されたタグ';

  @override
  String get tags_add_new => '新しいタグを追加';

  @override
  String get tags_input_hint => 'タグ名';

  @override
  String get tags_delete_title => 'タグ削除';

  @override
  String tags_delete_message(String tagName) {
    return '「$tagName」を削除しますか？すべての日記からこのタグが削除されます。';
  }

  @override
  String tags_delete_success(String tagName) {
    return 'タグ「$tagName」が削除されました';
  }

  @override
  String get tags_no_tags => 'タグがありません';

  @override
  String get tags_load_failed => 'タグの読み込みに失敗しました';

  @override
  String get tags_delete_failed => 'タグの削除に失敗しました';

  @override
  String get home_monthly_tracker_title => '今月の日記作成';

  @override
  String get home_yearly_tracker_title => '今年の日記作成';

  @override
  String get home_monthly_tracker_legend_less => '少ない';

  @override
  String get home_monthly_tracker_legend_more => '多い';

  @override
  String get common_unit_day => '日';

  @override
  String get entries_mood_filter_title => '感情でフィルタ';

  @override
  String get statistics_mood_distribution_empty => '表示する気分分布データがありません。';

  @override
  String get statistics_mood_distribution_description => '気分分布';

  @override
  String get statistics_mood_trend_description => '気分変化';

  @override
  String get statistics_mood_trend_daily_records => '日間気分記録';

  @override
  String get statistics_mood_trend_overall_average => '全体平均スコア';

  @override
  String get statistics_mood_trend_recent_7days_average => '最近7日間平均';

  @override
  String get home_representative_mood_title => '私の現在の感情';

  @override
  String get home_representative_mood_description => '最近30日間の感情分析結果';

  @override
  String get home_representative_mood_empty => '感情記録なし';

  @override
  String get home_representative_mood_empty_description =>
      '日記を書いて感情を記録してみてください';

  @override
  String get calendar_month_jan => '1月';

  @override
  String get calendar_month_feb => '2月';

  @override
  String get calendar_month_mar => '3月';

  @override
  String get calendar_month_apr => '4月';

  @override
  String get calendar_month_may => '5月';

  @override
  String get calendar_month_jun => '6月';

  @override
  String get calendar_month_jul => '7月';

  @override
  String get calendar_month_aug => '8月';

  @override
  String get calendar_month_sep => '9月';

  @override
  String get calendar_month_oct => '10月';

  @override
  String get calendar_month_nov => '11月';

  @override
  String get calendar_month_dec => '12月';

  @override
  String get calendar_weekday_sun => '日';

  @override
  String get calendar_weekday_mon => '月';

  @override
  String get calendar_weekday_tue => '火';

  @override
  String get calendar_weekday_wed => '水';

  @override
  String get calendar_weekday_thu => '木';

  @override
  String get calendar_weekday_fri => '金';

  @override
  String get calendar_weekday_sat => '土';

  @override
  String get tags_dialog_title => 'タグ管理';

  @override
  String get tags_dialog_empty => 'タグがありません';

  @override
  String get tags_dialog_close => '閉じる';

  @override
  String get tags_dialog_delete_title => 'タグ削除';

  @override
  String tags_dialog_delete_message(String tagName) {
    return '「$tagName」を削除しますか？すべての日記からこのタグが削除されます。';
  }

  @override
  String tags_dialog_created(String date) {
    return '作成日：$date';
  }

  @override
  String get journal_image_detail_gesture_hint => 'ダブルタップでズームイン/アウト、ピンチで自由に調整';

  @override
  String get profile_delete_account_reauthentication_required =>
      'アカウントを削除するには再認証が必要です。';

  @override
  String get profile_delete_account_reauthentication_google =>
      'Googleアカウントで再認証する';

  @override
  String get profile_delete_account_reauthentication_apple =>
      'Appleアカウントで再認証する';

  @override
  String get profile_delete_account_reauthentication_failed =>
      '再認証に失敗しました。もう一度お試しください。';

  @override
  String get profile_delete_account_success => 'アカウントが正常に削除されました。';

  @override
  String get profile_delete_account_error => 'アカウント削除中にエラーが発生しました。';

  @override
  String get profile_delete_account_apple_revoke_failed =>
      'Apple アカウント連携の解除に失敗しましたが、アカウント削除は続行されます。';

  @override
  String get profile_delete_account_apple_revoke_success =>
      'Apple アカウント連携が解除されました。';

  @override
  String get profile_delete_account_apple_manual_revoke_guide =>
      '完全なApple アカウント連携解除を行う場合：\n\n1️⃣ ウェブ: appleid.apple.com → サインインとセキュリティ → Apple IDを使用するApp → 該当アプリを削除\n\n2️⃣ iPhone: 設定 → Apple ID → パスワードとセキュリティ → Apple IDログイン → 該当アプリを削除\n\nこれにより次回ログイン時にメール共有設定を再選択できます。';

  @override
  String get weather_current_weather => '現在の天気';

  @override
  String get weather_humidity => '湿度';

  @override
  String get weather_wind => '風';

  @override
  String get weather_pressure => '気圧';

  @override
  String get location_journal_location => '日記作成場所';

  @override
  String get location_tap_to_open => 'タップして開く';

  @override
  String get location_map_load_error => '地図を読み込めません';

  @override
  String get location_address => '住所';

  @override
  String get location_no_address => '住所情報なし';

  @override
  String get location_coordinates => '座標';

  @override
  String get location_open_in_google_maps => 'Googleマップで開く';

  @override
  String get profile_guest_mode => 'ゲストモードです。';

  @override
  String get profile_guest_login_button => 'ソーシャルログインに切り替え';

  @override
  String get profile_guest_login_description =>
      'GoogleまたはAppleアカウントでログインしてデータを同期します。';
}
