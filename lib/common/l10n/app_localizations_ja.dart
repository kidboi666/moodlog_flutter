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
  String get common_confirm_ok => '確認';

  @override
  String get common_confirm_delete => '削除';

  @override
  String get common_confirm_save => '保存';

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
      'ムードログは、日々の感情を記録し、AIからの返信を受け取ることができるアプリです。';

  @override
  String get onboarding_welcome_description2 => '毎日感情を記録し、AIからの返信を読んでみてください。';

  @override
  String get onboarding_welcome_next => '一緒に準備しましょうか？';

  @override
  String get onboarding_nickname_title => 'ニックネーム設定';

  @override
  String get onboarding_nickname_description => 'ムードログで使用するニックネームを入力してください';

  @override
  String get onboarding_nickname_input_title => 'ニックネーム';

  @override
  String get onboarding_nickname_input_hint => 'ニックネームを入力してください（2〜10文字）';

  @override
  String get onboarding_nickname_next => 'ニックネームは設定メニューでいつでも変更できます。';

  @override
  String get onboarding_nickname_input_error => 'ニックネームを入力してください。';

  @override
  String get onboarding_personality_title => '返信スタイルの決定';

  @override
  String get onboarding_personality_description => 'あなたの日記に返信するAIの性格を選択してください。';

  @override
  String get onboarding_personality_rational_title => '冷静な分析者';

  @override
  String get onboarding_personality_rational_description =>
      '客観的で実用的なアドバイスを提供します';

  @override
  String get onboarding_personality_balanced_title => 'バランスの取れた助言者';

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
  String get onboarding_success_description => 'ムードログを始めましょうか？';

  @override
  String get onboarding_success_next => '始める';

  @override
  String get signin_title => '始める準備ができました！';

  @override
  String get signin_growth => '成長する心を記録しましょう。';

  @override
  String get signin_login_title => 'アカウント登録で記録を保存してください。';

  @override
  String get signin_button_guest => 'ゲストで開始';

  @override
  String get signin_button_google => 'Googleアカウントで開始';

  @override
  String get signin_button_kakao => 'カカオアカウントで開始';

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
  String get entries_empty_box_button => '日記作成へ行く';

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
  String get write_mood_title => '今日の気分はいかがですか？';

  @override
  String get write_input_title => '内容';

  @override
  String get write_input_hint => '今日の感情と経験を記録してみてください。';

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
  String get journal_ai_generating_response_title => 'AIが返答を作成中です。';

  @override
  String get statistics_total_title => '全体統計';

  @override
  String get statistics_total_record_description => '総記録';

  @override
  String statistics_total_record(Object count) {
    return '$count件';
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
  String get settings_common_theme_subtitle => '明度テーマを選択します。';

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
  String get settings_common_font_family_pretendard => 'プリテンダード';

  @override
  String get settings_common_font_family_leeSeoyun => 'イ・ソユン体';

  @override
  String get settings_common_font_family_orbitOfTheMoon => 'ナヌム手書き 月の軌道';

  @override
  String get settings_common_font_family_restart => 'ナヌム手書き 再スタート';

  @override
  String get settings_common_font_family_overcome => 'ナヌム手書き 乗り越える';

  @override
  String get settings_common_font_family_system => 'システム標準';

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
      'キャッシュを削除しますか？\\nこの操作は取り消せません。';

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
  String get profile_button_login => 'ログインへ行く';

  @override
  String get profile_button_logout => 'ログアウト';

  @override
  String get write_ai_limit_reached => 'AI返答は1日1回のみ可能です。明日再度お試しください！';

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
  String get settings_user_info_status => '状態';

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
  String get navigation_home => 'ホーム';

  @override
  String get navigation_entries => '記録';

  @override
  String get navigation_write => '書く';

  @override
  String get navigation_statistics => '統計';

  @override
  String get navigation_settings => '設定';

  @override
  String auth_terms_message(String terms, String privacy) {
    return '続行することで、$termsと$privacyに同意します。';
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
  String journal_count(int count) {
    return '$count件';
  }

  @override
  String get location_current => '現在位置';

  @override
  String get location_add_location => '位置を追加';
}
