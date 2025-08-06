// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get common_date_today => '今天';

  @override
  String get common_date_tomorrow => '明天';

  @override
  String get common_date_yesterday => '昨天';

  @override
  String get common_date_full => 'yyyy年MM月dd日';

  @override
  String get common_confirm_cancel => '取消';

  @override
  String get common_confirm_ok => '确认';

  @override
  String get common_confirm_delete => '删除';

  @override
  String get common_confirm_save => '保存';

  @override
  String get common_email => '邮箱';

  @override
  String get common_phone => '电话';

  @override
  String get common_mood_verygood => '非常好';

  @override
  String get common_mood_good => '好';

  @override
  String get common_mood_neutral => '一般';

  @override
  String get common_mood_bad => '不好';

  @override
  String get common_mood_verybad => '非常不好';

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
  String get common_weekday_mon => '星期一';

  @override
  String get common_weekday_tue => '星期二';

  @override
  String get common_weekday_wed => '星期三';

  @override
  String get common_weekday_thu => '星期四';

  @override
  String get common_weekday_fri => '星期五';

  @override
  String get common_weekday_sat => '星期六';

  @override
  String get common_weekday_sun => '星期日';

  @override
  String get common_weekday_mon_short => '一';

  @override
  String get common_weekday_tue_short => '二';

  @override
  String get common_weekday_wed_short => '三';

  @override
  String get common_weekday_thu_short => '四';

  @override
  String get common_weekday_fri_short => '五';

  @override
  String get common_weekday_sat_short => '六';

  @override
  String get common_weekday_sun_short => '日';

  @override
  String get onboarding_welcome_title => '欢迎来到心情日志！';

  @override
  String get onboarding_welcome_description1 => '心情日志是一个可以记录你日常情感并接收AI回复的应用。';

  @override
  String get onboarding_welcome_description2 => '每天记录你的情感，阅读AI的回复。';

  @override
  String get onboarding_welcome_next => '让我们一起开始准备吧？';

  @override
  String get onboarding_nickname_title => '设置昵称';

  @override
  String get onboarding_nickname_description => '请输入在心情日志中使用的昵称';

  @override
  String get onboarding_nickname_input_title => '昵称';

  @override
  String get onboarding_nickname_input_hint => '请输入昵称（2-10个字符）';

  @override
  String get onboarding_nickname_next => '昵称可以随时在设置菜单中更改。';

  @override
  String get onboarding_nickname_input_error => '请输入昵称。';

  @override
  String get onboarding_personality_title => '选择回复风格';

  @override
  String get onboarding_personality_description => '请选择回复你日记的AI性格。';

  @override
  String get onboarding_personality_rational_title => '理性分析师';

  @override
  String get onboarding_personality_rational_description => '提供客观实用的建议';

  @override
  String get onboarding_personality_balanced_title => '平衡顾问';

  @override
  String get onboarding_personality_balanced_description => '平衡共情和现实建议。';

  @override
  String get onboarding_personality_compassionate_title => '温柔治愈师';

  @override
  String get onboarding_personality_compassionate_description => '传递温暖安慰和深度共情。';

  @override
  String get onboarding_personality_hint => '可以随时在设置中更改。';

  @override
  String get onboarding_success_title => '准备开始了！';

  @override
  String get onboarding_success_description => '让我们开始心情日志吧？';

  @override
  String get onboarding_success_next => '开始';

  @override
  String get signin_title => '准备开始了！';

  @override
  String get signin_growth => '记录成长的心情。';

  @override
  String get signin_login_title => '注册以保存记录。';

  @override
  String get signin_button_guest => '以访客身份开始';

  @override
  String get signin_button_google => '用Google账户开始';

  @override
  String get signin_button_kakao => '用Kakao账户开始';

  @override
  String get home_hello => '您好！';

  @override
  String home_welcome(Object nickname) {
    return '$nickname。';
  }

  @override
  String get home_howareyou => '今天心情如何？';

  @override
  String get home_empty_box => '等待着你的故事。';

  @override
  String get entries_empty_box_title => '没有已创建的日记。';

  @override
  String get entries_empty_box_description => '创建的日记会显示在这里。';

  @override
  String get entries_empty_box_button => '去写日记';

  @override
  String get entries_calendar_legend_has_journal => '有日记';

  @override
  String get entries_calendar_legend_today => '今天';

  @override
  String get tab_home => '首页';

  @override
  String get tab_entries => '记录';

  @override
  String get tab_settings => '设置';

  @override
  String get tab_write => '写作';

  @override
  String get tab_statistics => '统计';

  @override
  String get write_title => '일기 작성';

  @override
  String get write_edit_title => '일기 수정';

  @override
  String get write_mood_title => '今天心情如何？';

  @override
  String get write_mood_subtitle => '기분을 선택해주세요';

  @override
  String get write_input_title => '内容';

  @override
  String get write_input_hint => '记录今天的情感和体验。';

  @override
  String get write_ai_title => 'AI安慰消息';

  @override
  String get write_ai_description => '写完日记后，AI会发送安慰和鼓励的消息。';

  @override
  String get write_location_remove => '删除';

  @override
  String get journal_delete_confirm_title => '确认删除';

  @override
  String get journal_delete_confirm_description => '您确定要删除这个条目吗？';

  @override
  String get journal_ai_generating_response_title => 'AI正在撰写回复。';

  @override
  String get statistics_total_title => '总体统计';

  @override
  String get statistics_total_record_description => '总记录';

  @override
  String statistics_total_record(Object count) {
    return '$count个';
  }

  @override
  String get statistics_total_streak_description => '连续记录';

  @override
  String statistics_total_streak(Object count) {
    return '$count天';
  }

  @override
  String get statistics_total_streak_max_description => '最大连续记录';

  @override
  String statistics_total_streak_max(Object count) {
    return '$count天';
  }

  @override
  String get statistics_mood_calendar_title => '情感日历';

  @override
  String get statistics_mood_distribution_title => '心情分布';

  @override
  String statistics_mood_distribution_unit(Object count) {
    return '$count次';
  }

  @override
  String get statistics_mood_trend_title => '心情趋势';

  @override
  String get statistics_mood_trend_empty => '没有心情趋势数据。';

  @override
  String get statistics_recent_title => '最近日记';

  @override
  String get statistics_recent_empty => '没有最近日记。';

  @override
  String get statistics_total_records_count_unit => '个记录';

  @override
  String get statistics_total_records_first_record => '首次记录';

  @override
  String get statistics_total_records_period => '记录周期';

  @override
  String statistics_total_records_period_days(int days) {
    return '$days天';
  }

  @override
  String get statistics_total_records_avg_frequency => '平均频率';

  @override
  String statistics_total_records_weekly_frequency(String frequency) {
    return '$frequency次/周';
  }

  @override
  String get statistics_streak_status_active => '进行中';

  @override
  String get statistics_streak_status_inactive => '已中断';

  @override
  String get statistics_streak_last_record => '最后记录';

  @override
  String statistics_streak_days_ago(int days) {
    return '$days天前';
  }

  @override
  String get statistics_streak_stopped => '连续记录中断';

  @override
  String statistics_streak_stopped_days(int days) {
    return '$days天前';
  }

  @override
  String get statistics_streak_encouragement => '太棒了！你正在保持连续记录';

  @override
  String get statistics_max_streak_new_record => '新纪录！';

  @override
  String get statistics_max_streak_progress => '当前进度';

  @override
  String get statistics_max_streak_remaining => '距最高纪录';

  @override
  String statistics_max_streak_remaining_days(int days) {
    return '还剩$days天';
  }

  @override
  String get statistics_max_streak_achievement_week => '一周连续记录达成！做得很好！';

  @override
  String get statistics_max_streak_achievement_two_weeks => '两周连续记录达成！太棒了！';

  @override
  String get statistics_max_streak_achievement_month => '一个月连续记录达成！真的很了不起！';

  @override
  String get statistics_average_mood_title => '平均心情';

  @override
  String statistics_average_mood_score(String score) {
    return '平均$score分';
  }

  @override
  String get statistics_average_mood_most_frequent => '最常感受的心情';

  @override
  String get statistics_average_mood_recent_trend => '最近7天趋势';

  @override
  String get statistics_trend_rising => '上升';

  @override
  String get statistics_trend_falling => '下降';

  @override
  String get statistics_trend_stable => '稳定';

  @override
  String get statistics_mood_positive_message => '总体上保持着积极的心情！';

  @override
  String get statistics_mood_negative_message => '看起来你正在经历困难时期。请花时间照顾自己。';

  @override
  String get statistics_writing_frequency_title => '写作频率';

  @override
  String get statistics_writing_frequency_this_week => '本周';

  @override
  String get statistics_writing_frequency_count_unit => '次';

  @override
  String get statistics_writing_frequency_daily => '每日记录！';

  @override
  String get statistics_writing_frequency_often => '经常记录';

  @override
  String get statistics_writing_frequency_normal => '一般';

  @override
  String get statistics_writing_frequency_sometimes => '偶尔';

  @override
  String get statistics_writing_frequency_none => '无记录';

  @override
  String get statistics_writing_frequency_weekly_avg => '周平均';

  @override
  String get statistics_writing_frequency_monthly_avg => '月平均';

  @override
  String statistics_writing_frequency_weekly_count(String count) {
    return '$count次';
  }

  @override
  String statistics_writing_frequency_monthly_count(String count) {
    return '$count次';
  }

  @override
  String get statistics_writing_frequency_most_active_time => '最活跃的时间';

  @override
  String get statistics_writing_frequency_most_active_day => '最活跃的星期';

  @override
  String get statistics_time_morning => '上午';

  @override
  String get statistics_time_afternoon => '下午';

  @override
  String get statistics_time_evening => '傍晚';

  @override
  String get statistics_time_night => '夜晚';

  @override
  String statistics_time_with_hour(String timeOfDay, int hour) {
    return '$timeOfDay ($hour点)';
  }

  @override
  String get statistics_writing_frequency_good_habit => '你在稳定地记录！太棒了！';

  @override
  String get statistics_writing_frequency_encouragement =>
      '试着更频繁地记录吧。小小的时刻也很珍贵！';

  @override
  String get settings_title => '设置';

  @override
  String get settings_common_title => '通用';

  @override
  String get settings_common_notification_title => '通知';

  @override
  String get settings_common_notification_subtitle => '接收推送通知。';

  @override
  String get settings_common_theme_title => '主题';

  @override
  String get settings_common_theme_subtitle => '选择亮度主题。';

  @override
  String get settings_common_theme_light => '浅色主题';

  @override
  String get settings_common_theme_dark => '深色主题';

  @override
  String get settings_common_theme_system => '系统主题';

  @override
  String get settings_common_color_theme_title => '颜色主题';

  @override
  String get settings_common_color_theme_subtitle => '选择颜色主题。';

  @override
  String get settings_common_language_title => '语言';

  @override
  String get settings_common_language_dialog_title => '选择语言';

  @override
  String get settings_common_font_family_title => '字体';

  @override
  String get settings_common_font_family_pretendard => 'Pretendard';

  @override
  String get settings_common_font_family_leeSeoyun => '李瑞允体';

  @override
  String get settings_common_font_family_orbitOfTheMoon => 'Nanum手写体 月之轨道';

  @override
  String get settings_common_font_family_restart => 'Nanum手写体 重新开始';

  @override
  String get settings_common_font_family_overcome => 'Nanum手写体 我能克服';

  @override
  String get settings_common_font_family_system => '系统默认';

  @override
  String get settings_data_title => '数据';

  @override
  String get settings_data_auto_sync_title => '自动同步';

  @override
  String get settings_data_auto_sync_subtitle => '自动同步数据。';

  @override
  String get settings_data_backup_title => '数据备份';

  @override
  String get settings_data_backup_subtitle => '备份数据。';

  @override
  String get settings_data_backup_confirm => '您要备份数据吗？';

  @override
  String get settings_data_backup_confirm_ok => '备份';

  @override
  String get settings_data_cache_cleanup_title => '清理缓存';

  @override
  String get settings_data_cache_cleanup_subtitle => '删除临时文件。';

  @override
  String get settings_data_cache_cleanup_confirm => '您要删除缓存吗？\n此操作无法撤销。';

  @override
  String get settings_ai_personality_changed => 'AI性格已更改。';

  @override
  String get settings_information_title => '信息';

  @override
  String get settings_information_app_title => '应用信息';

  @override
  String get settings_information_app_subtitle => '版本和许可证信息';

  @override
  String get settings_information_app_version => '版本';

  @override
  String get settings_information_app_build => '许可证';

  @override
  String get settings_information_app_developer => '开发者';

  @override
  String get settings_information_faq_title => '帮助';

  @override
  String get settings_information_faq_subtitle => '使用方法和FAQ';

  @override
  String get settings_information_qna_title => '联系我们';

  @override
  String get settings_information_qna_subtitle => '联系开发者。';

  @override
  String get profile_title => '个人资料';

  @override
  String get profile_account_title => '注册信息';

  @override
  String get profile_nickname_title => '更改昵称';

  @override
  String get profile_nickname_hint => '请输入新昵称。';

  @override
  String get profile_creation_time_title => '注册日期';

  @override
  String get profile_uid_title => '用户ID';

  @override
  String get profile_button_login => '去登录';

  @override
  String get profile_button_logout => '登出';

  @override
  String get write_ai_limit_reached => 'AI回复每天只能使用一次。请明天再试！';

  @override
  String get write_timestamp_add => '添加时间';

  @override
  String get write_location_add => '添加位置';

  @override
  String get common_language_korean => '韩语';

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
  String get common_developing => '开发中';

  @override
  String get settings_user_info_title => '登录信息';

  @override
  String get settings_user_info_empty => '没有登录信息。';

  @override
  String get settings_user_info_status => '状态';

  @override
  String get settings_user_info_anonymous => '匿名登录';

  @override
  String get settings_user_info_logged_in => '已登录';

  @override
  String get dialog_storage_init_title => '存储初始化';

  @override
  String get dialog_storage_init_content => '初始化SharedPreferences。';

  @override
  String get dialog_database_init_title => '数据库初始化';

  @override
  String get dialog_database_init_content => '初始化SQLite数据库。';

  @override
  String get dialog_init_button => '初始化';

  @override
  String get settings_developer_options => '开发选项';

  @override
  String get settings_developer_mode_only => '仅开发模式操作';

  @override
  String get settings_ai_section_title => 'AI设置';

  @override
  String get settings_ai_personality_title => 'AI性格';

  @override
  String get snackbar_backup_completed => '备份已完成。';

  @override
  String get snackbar_cache_cleared => '缓存已清除。';

  @override
  String auth_terms_message(String terms, String privacy) {
    return '继续即表示您同意我们的$terms和$privacy。';
  }

  @override
  String get auth_terms_of_service => '服务条款';

  @override
  String get auth_privacy_policy => '隐私政策';

  @override
  String get app_info_copyright => '© 2024 保留所有权利';

  @override
  String get app_info_developer => '您的姓名';

  @override
  String get profile_sign_out_title => '登出';

  @override
  String get profile_sign_out_message => '您确定要登出吗？';

  @override
  String journal_count(int count) {
    return '$count个记录';
  }

  @override
  String get location_current => '当前位置';

  @override
  String get location_add_location => '添加位置';

  @override
  String get tags_manage_title => '标签管理';

  @override
  String get tags_manage_subtitle => '查看和管理你的标签';

  @override
  String get tags_filter_all => '全部';

  @override
  String get tags_filter_title => '按标签筛选';

  @override
  String get tags_suggested_title => '推荐标签';

  @override
  String get tags_selected_title => '已选择的标签';

  @override
  String get tags_add_new => '添加新标签';

  @override
  String get tags_input_hint => '标签名称';

  @override
  String get tags_delete_title => '删除标签';

  @override
  String tags_delete_message(String tagName) {
    return '确定要删除\"$tagName\"吗？这将从所有日记中移除此标签。';
  }

  @override
  String tags_delete_success(String tagName) {
    return '标签\"$tagName\"已删除';
  }

  @override
  String get tags_no_tags => '没有找到标签';

  @override
  String get tags_load_failed => '加载标签失败';

  @override
  String get tags_delete_failed => '删除标签失败';

  @override
  String get home_monthly_tracker_title => '本月日记记录';

  @override
  String get home_yearly_tracker_title => '今年日记记录';

  @override
  String get home_monthly_tracker_legend_less => '较少';

  @override
  String get home_monthly_tracker_legend_more => '较多';

  @override
  String get common_unit_day => '天';

  @override
  String get entries_mood_filter_title => '按心情筛选';

  @override
  String get statistics_mood_distribution_empty => '표시할 기분 분포 데이터가 없습니다.';

  @override
  String get statistics_mood_distribution_description => '기분 분포';

  @override
  String get statistics_mood_trend_description => '기분 변화';

  @override
  String get statistics_mood_trend_daily_records => '일간 기분 기록';

  @override
  String get statistics_mood_trend_overall_average => '전체 평균 점수';

  @override
  String get statistics_mood_trend_recent_7days_average => '최근 7일 평균';

  @override
  String get home_representative_mood_title => '나의 현재 감정';

  @override
  String get home_representative_mood_description => '최근 30일 감정 분석 결과';
}
