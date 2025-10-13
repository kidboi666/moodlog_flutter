// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get common_date_today => '오늘';

  @override
  String get common_date_tomorrow => '내일';

  @override
  String get common_date_yesterday => '어제';

  @override
  String get common_date_full => 'yyyy년 MM월 dd일';

  @override
  String get common_confirm_cancel => '취소';

  @override
  String get common_confirm_ok => '확인';

  @override
  String get common_confirm_delete => '삭제';

  @override
  String get common_confirm_save => '저장';

  @override
  String get common_reset => '초기화';

  @override
  String get common_email => '이메일';

  @override
  String get common_phone => '전화번호';

  @override
  String get common_mood_verygood => '매우 좋음';

  @override
  String get common_mood_good => '좋음';

  @override
  String get common_mood_neutral => '보통';

  @override
  String get common_mood_bad => '나쁨';

  @override
  String get common_mood_verybad => '매우 나쁨';

  @override
  String get common_month_jan => '1월';

  @override
  String get common_month_feb => '2월';

  @override
  String get common_month_mar => '3월';

  @override
  String get common_month_apr => '4월';

  @override
  String get common_month_may => '5월';

  @override
  String get common_month_jun => '6월';

  @override
  String get common_month_jul => '7월';

  @override
  String get common_month_aug => '8월';

  @override
  String get common_month_sep => '9월';

  @override
  String get common_month_oct => '10월';

  @override
  String get common_month_nov => '11월';

  @override
  String get common_month_dec => '12월';

  @override
  String get common_weekday_mon => '월요일';

  @override
  String get common_weekday_tue => '화요일';

  @override
  String get common_weekday_wed => '수요일';

  @override
  String get common_weekday_thu => '목요일';

  @override
  String get common_weekday_fri => '금요일';

  @override
  String get common_weekday_sat => '토요일';

  @override
  String get common_weekday_sun => '일요일';

  @override
  String get common_weekday_mon_short => '월';

  @override
  String get common_weekday_tue_short => '화';

  @override
  String get common_weekday_wed_short => '수';

  @override
  String get common_weekday_thu_short => '목';

  @override
  String get common_weekday_fri_short => '금';

  @override
  String get common_weekday_sat_short => '토';

  @override
  String get common_weekday_sun_short => '일';

  @override
  String get onboarding_welcome_title => 'MoodLog에 오신 것을 환영합니다!';

  @override
  String get onboarding_welcome_description1 =>
      'MoodLog는 매일의 감정을 기록하고 AI의 응답을 받을 수 있는 앱입니다.';

  @override
  String get onboarding_welcome_description2 => '매일 감정을 기록하고 AI의 응답을 읽어보세요.';

  @override
  String get onboarding_welcome_next => '함께 시작해볼까요?';

  @override
  String get onboarding_nickname_title => '닉네임 설정';

  @override
  String get onboarding_nickname_description => 'MoodLog에서 사용할 닉네임을 입력해주세요';

  @override
  String get onboarding_nickname_input_title => '닉네임';

  @override
  String get onboarding_nickname_input_hint => '닉네임 입력 (2-10글자)';

  @override
  String get onboarding_nickname_next => '닉네임은 설정 메뉴에서 언제든 변경할 수 있습니다.';

  @override
  String get onboarding_nickname_input_error => '닉네임을 입력해주세요.';

  @override
  String get onboarding_personality_title => '응답 스타일 선택';

  @override
  String get onboarding_personality_description => '일기에 응답할 AI 성격을 선택해주세요.';

  @override
  String get onboarding_personality_rational_title => '합리적 분석가';

  @override
  String get onboarding_personality_rational_description =>
      '객관적이고 실용적인 조언을 제공합니다';

  @override
  String get onboarding_personality_balanced_title => '균형잡힌 조언자';

  @override
  String get onboarding_personality_balanced_description =>
      '공감과 현실적인 조언의 균형을 맞춥니다.';

  @override
  String get onboarding_personality_compassionate_title => '따뜻한 치유자';

  @override
  String get onboarding_personality_compassionate_description =>
      '따뜻한 위로와 깊은 공감을 전달합니다.';

  @override
  String get onboarding_personality_hint => '설정에서 언제든 변경할 수 있습니다.';

  @override
  String get onboarding_success_title => '시작할 준비가 되었습니다!';

  @override
  String get onboarding_success_description => 'MoodLog를 시작해볼까요?';

  @override
  String get onboarding_success_next => '시작하기';

  @override
  String get signin_title => '시작할 준비가 되었습니다!';

  @override
  String get signin_growth => '성장하는 마음을 기록하세요.';

  @override
  String get signin_login_title => '기록을 저장하려면 로그인하세요.';

  @override
  String get signin_button_guest => '게스트로 시작';

  @override
  String get signin_button_google => 'Google로 시작';

  @override
  String get signin_button_apple => 'Apple로 시작';

  @override
  String get home_hello => '안녕하세요!';

  @override
  String home_welcome(Object nickname) {
    return '$nickname님.';
  }

  @override
  String get home_howareyou => '오늘 기분이 어떠신가요?';

  @override
  String get home_empty_box => '당신의 이야기를 기다리고 있어요.';

  @override
  String get entries_empty_box_title => '아직 일기가 없습니다.';

  @override
  String get entries_empty_box_description => '작성한 일기가 여기에 표시됩니다.';

  @override
  String get entries_empty_box_button => '일기 쓰러 가기';

  @override
  String get entries_calendar_legend_has_journal => '일기 있음';

  @override
  String get entries_calendar_legend_today => '오늘';

  @override
  String get tab_home => '홈';

  @override
  String get drawer_tags => '태그 관리';

  @override
  String get empty_box_write_options_title => '어떤 날짜의 일기를 작성하시겠어요?';

  @override
  String empty_box_write_for_selected_date(String date) {
    return '$date 일기 쓰기';
  }

  @override
  String get empty_box_write_for_today => '오늘 일기 쓰기';

  @override
  String get tags_empty => '태그가 없습니다.';

  @override
  String tags_error(String error) {
    return '오류 발생: $error';
  }

  @override
  String tags_journal_count(int count) {
    return '$count개의 일기';
  }

  @override
  String get default_tag_daily => '일상';

  @override
  String get default_tag_work => '업무';

  @override
  String get default_tag_health => '건강';

  @override
  String get default_tag_relationships => '관계';

  @override
  String get default_tag_hobby => '취미';

  @override
  String get default_tag_emotions => '감정';

  @override
  String get tab_entries => '일기 목록';

  @override
  String get tab_settings => '설정';

  @override
  String get tab_write => '쓰기';

  @override
  String get tab_statistics => '통계';

  @override
  String get write_title => '일기 쓰기';

  @override
  String get write_edit_title => '일기 수정';

  @override
  String get write_mood_title => '오늘 기분이 어떤가요?';

  @override
  String get write_mood_subtitle => '기분을 선택해주세요';

  @override
  String get write_input_title => '내용';

  @override
  String get write_input_hint => '오늘의 감정과 경험을 기록해보세요.';

  @override
  String get write_ai_title => 'AI 위로 메시지';

  @override
  String get write_ai_description => '일기를 작성하면 AI가 위로와 격려의 메시지를 보내드려요.';

  @override
  String get write_location_remove => '제거';

  @override
  String get journal_delete_confirm_title => '삭제 확인';

  @override
  String get journal_delete_confirm_description => '이 일기를 삭제하시겠습니까?';

  @override
  String get journal_ai_generating_response_title => 'AI가 응답을 작성하고 있습니다.';

  @override
  String get statistics_total_title => '전체 통계';

  @override
  String get statistics_total_record_description => '총 기록수';

  @override
  String statistics_total_record(Object count) {
    return '$count개';
  }

  @override
  String get statistics_total_streak_description => '현재 연속기록';

  @override
  String statistics_total_streak(Object count) {
    return '$count일';
  }

  @override
  String get statistics_total_streak_max_description => '최대 연속기록';

  @override
  String statistics_total_streak_max(Object count) {
    return '$count일';
  }

  @override
  String get statistics_mood_calendar_title => '기분 달력';

  @override
  String get statistics_mood_distribution_title => '기분 분포';

  @override
  String statistics_mood_distribution_unit(Object count) {
    return '$count회';
  }

  @override
  String get statistics_mood_trend_title => '기분 변화';

  @override
  String get statistics_mood_trend_empty => '기분 변화 데이터가 없습니다.';

  @override
  String get statistics_recent_title => '최근 일기';

  @override
  String get statistics_recent_empty => '최근 일기가 없습니다.';

  @override
  String get statistics_total_records_count_unit => '개';

  @override
  String get statistics_total_records_first_record => '첫 번째 기록';

  @override
  String get statistics_total_records_period => '기록 기간';

  @override
  String statistics_total_records_period_days(int days) {
    return '$days일';
  }

  @override
  String get statistics_total_records_avg_frequency => '평균 빈도';

  @override
  String statistics_total_records_weekly_frequency(String frequency) {
    return '주 $frequency회';
  }

  @override
  String get statistics_streak_status_active => '활성';

  @override
  String get statistics_streak_status_inactive => '비활성';

  @override
  String get statistics_streak_last_record => '마지막 기록';

  @override
  String statistics_streak_days_ago(int days) {
    return '$days일 전';
  }

  @override
  String get statistics_streak_stopped => '연속기록 중단';

  @override
  String statistics_streak_stopped_days(int days) {
    return '$days일 전';
  }

  @override
  String get statistics_streak_encouragement => '훌륭해요! 연속기록을 이어가고 있네요';

  @override
  String get statistics_max_streak_new_record => '신기록!';

  @override
  String get statistics_max_streak_progress => '현재 진행도';

  @override
  String get statistics_max_streak_remaining => '기록 갱신까지';

  @override
  String statistics_max_streak_remaining_days(int days) {
    return '$days일 남음';
  }

  @override
  String get statistics_max_streak_achievement_week =>
      '1주 연속기록 달성! 정말 잘하고 있어요!';

  @override
  String get statistics_max_streak_achievement_two_weeks => '2주 연속기록 달성! 훌륭해요!';

  @override
  String get statistics_max_streak_achievement_month => '한 달 연속기록 달성! 놀라워요!';

  @override
  String get statistics_average_mood_title => '평균 기분';

  @override
  String statistics_average_mood_score(String score) {
    return '평균 $score점';
  }

  @override
  String get statistics_average_mood_most_frequent => '가장 많은 기분';

  @override
  String get statistics_average_mood_recent_trend => '최근 7일 동향';

  @override
  String get statistics_trend_rising => '상승';

  @override
  String get statistics_trend_falling => '하락';

  @override
  String get statistics_trend_stable => '안정';

  @override
  String get statistics_mood_positive_message => '전반적으로 긍정적인 기분을 유지하고 있어요!';

  @override
  String get statistics_mood_negative_message =>
      '힘든 시간을 보내고 있군요. 자신을 돌보는 시간을 가져보세요.';

  @override
  String get statistics_writing_frequency_title => '작성 빈도';

  @override
  String get statistics_writing_frequency_this_week => '이번 주';

  @override
  String get statistics_writing_frequency_count_unit => '회';

  @override
  String get statistics_writing_frequency_daily => '매일 기록!';

  @override
  String get statistics_writing_frequency_often => '자주 기록';

  @override
  String get statistics_writing_frequency_normal => '보통';

  @override
  String get statistics_writing_frequency_sometimes => '가끔';

  @override
  String get statistics_writing_frequency_none => '기록 없음';

  @override
  String get statistics_writing_frequency_weekly_avg => '주평균';

  @override
  String get statistics_writing_frequency_monthly_avg => '월평균';

  @override
  String statistics_writing_frequency_weekly_count(String count) {
    return '$count회';
  }

  @override
  String statistics_writing_frequency_monthly_count(String count) {
    return '$count회';
  }

  @override
  String get statistics_writing_frequency_most_active_time => '가장 활발한 시간';

  @override
  String get statistics_writing_frequency_most_active_day => '가장 활발한 요일';

  @override
  String get statistics_time_morning => '오전';

  @override
  String get statistics_time_afternoon => '오후';

  @override
  String get statistics_time_evening => '저녁';

  @override
  String get statistics_time_night => '밤';

  @override
  String statistics_time_with_hour(String timeOfDay, int hour) {
    return '$timeOfDay ($hour시)';
  }

  @override
  String get statistics_writing_frequency_good_habit => '꾸준히 기록하고 있어요! 훌륭해요!';

  @override
  String get statistics_writing_frequency_encouragement =>
      '조금 더 자주 기록해보세요. 작은 순간들도 소중하니까요!';

  @override
  String get settings_title => '설정';

  @override
  String get settings_common_title => '일반';

  @override
  String get settings_common_notification_title => '알림';

  @override
  String get settings_common_notification_subtitle => '푸시 알림을 받습니다.';

  @override
  String get settings_common_app_lock_title => '앱 잠금';

  @override
  String get settings_common_app_lock_subtitle => '생체인증 또는 비밀번호로 앱을 잠급니다.';

  @override
  String get settings_common_theme_title => '테마';

  @override
  String get settings_common_theme_subtitle => '밝기 테마를 선택하세요.';

  @override
  String get settings_common_theme_light => '라이트 테마';

  @override
  String get settings_common_theme_dark => '다크 테마';

  @override
  String get settings_common_theme_system => '시스템 테마';

  @override
  String get settings_common_color_theme_title => '컬러 테마';

  @override
  String get settings_common_color_theme_subtitle => '컬러 테마를 선택하세요.';

  @override
  String get settings_common_language_title => '언어';

  @override
  String get settings_common_language_dialog_title => '언어 선택';

  @override
  String get settings_common_font_family_title => '폰트';

  @override
  String get settings_common_font_family_pretendard => '프리텐다드';

  @override
  String get settings_common_font_family_leeSeoyun => '이서윤체';

  @override
  String get settings_common_font_family_orbitOfTheMoon => '달의 궤도';

  @override
  String get settings_common_font_family_restart => '재시작';

  @override
  String get settings_common_font_family_overcome => '극복';

  @override
  String get settings_common_font_family_system => '시스템 기본';

  @override
  String get settings_data_title => '데이터';

  @override
  String get settings_data_auto_sync_title => '자동 동기화';

  @override
  String get settings_data_auto_sync_subtitle => '데이터를 자동으로 동기화합니다.';

  @override
  String get settings_data_backup_title => '데이터 백업';

  @override
  String get settings_data_backup_subtitle => '데이터를 백업합니다.';

  @override
  String get settings_data_backup_confirm => '데이터를 백업하시겠습니까?';

  @override
  String get settings_data_backup_confirm_ok => '백업';

  @override
  String get settings_data_cache_cleanup_title => '캐시 정리';

  @override
  String get settings_data_cache_cleanup_subtitle => '임시 파일을 삭제합니다.';

  @override
  String get settings_data_cache_cleanup_confirm =>
      '캐시를 정리하시겠습니까?\n이 작업은 되돌릴 수 없습니다.';

  @override
  String get settings_ai_personality_changed => 'AI 성격이 변경되었습니다.';

  @override
  String get settings_information_title => '정보';

  @override
  String get settings_information_app_title => '앱 정보';

  @override
  String get settings_information_app_subtitle => '버전 및 빌드 정보';

  @override
  String get settings_information_app_version => '앱 버전';

  @override
  String get settings_information_app_build => '빌드 버전';

  @override
  String get settings_information_app_developer => '개발자';

  @override
  String get settings_information_license_title => '라이센스';

  @override
  String get settings_information_license_subtitle => '라이센스 정보';

  @override
  String get settings_information_faq_title => '도움말';

  @override
  String get settings_information_faq_subtitle => '사용법 및 자주 묻는 질문';

  @override
  String get settings_information_qna_title => '문의하기';

  @override
  String get settings_information_qna_subtitle => '개발자에게 문의하세요.';

  @override
  String get profile_title => '프로필';

  @override
  String get profile_account_title => '계정 정보';

  @override
  String get profile_nickname_title => '닉네임 변경';

  @override
  String get profile_nickname_hint => '새 닉네임을 입력하세요.';

  @override
  String get profile_creation_time_title => '가입일';

  @override
  String get profile_uid_title => '사용자 ID';

  @override
  String get profile_button_login => '로그인 하러 가기';

  @override
  String get profile_button_logout => '로그아웃';

  @override
  String get write_ai_limit_reached => 'AI 응답은 하루에 한 번만 가능합니다. 내일 다시 시도해주세요!';

  @override
  String get write_timestamp_add => '시간 추가';

  @override
  String get write_location_add => '위치 추가';

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
  String get common_developing => '개발 중';

  @override
  String get settings_user_info_title => '로그인 정보';

  @override
  String get settings_user_info_empty => '로그인 정보가 없습니다.';

  @override
  String get settings_user_info_status => '상태';

  @override
  String get settings_user_info_anonymous => '익명 로그인';

  @override
  String get settings_user_info_logged_in => '로그인됨';

  @override
  String get dialog_storage_init_title => '스토리지 초기화';

  @override
  String get dialog_storage_init_content => 'SharedPreferences를 초기화합니다.';

  @override
  String get dialog_database_init_title => '데이터베이스 초기화';

  @override
  String get dialog_database_init_content => 'SQLite 데이터베이스를 초기화합니다.';

  @override
  String get dialog_init_button => '초기화';

  @override
  String get settings_developer_options => '개발자 옵션';

  @override
  String get settings_developer_mode_only => '개발자 모드 전용';

  @override
  String get settings_ai_section_title => 'AI 설정';

  @override
  String get settings_ai_personality_title => 'AI 성격';

  @override
  String get snackbar_backup_completed => '백업이 완료되었습니다.';

  @override
  String get snackbar_cache_cleared => '캐시가 정리되었습니다.';

  @override
  String auth_terms_message(String terms, String privacy) {
    return '계속하면 $terms 및 $privacy에 동의하는 것으로 간주됩니다.';
  }

  @override
  String get auth_terms_of_service => '서비스 약관';

  @override
  String get auth_privacy_policy => '개인정보 처리방침';

  @override
  String get app_info_copyright => '© 2024 All rights reserved';

  @override
  String get app_info_developer => '개발자명';

  @override
  String get profile_sign_out_title => '로그아웃';

  @override
  String get profile_sign_out_message => '정말 로그아웃하시겠습니까?';

  @override
  String get profile_delete_account_button => '계정 탈퇴';

  @override
  String get profile_delete_account_button_description => '현재 가입한 계정을 탈퇴합니다.';

  @override
  String get profile_delete_account_dialog_title => '계정 탈퇴';

  @override
  String get profile_delete_account_dialog_content =>
      '계정을 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get profile_delete_account_dialog_warning => '모든 데이터가 영구적으로 삭제됩니다.';

  @override
  String get profile_delete_account_dialog_confirm => '계정 탈퇴';

  @override
  String get profile_delete_account_dialog_password_input_hint =>
      '비밀번호를 입력하세요.';

  @override
  String get profile_delete_account_dialog_password_description =>
      '계정 탈퇴를 위해 로그인 비밀번호를 입력해야 합니다.';

  @override
  String journal_count(int count) {
    return '$count개';
  }

  @override
  String get location_current => '현재 위치';

  @override
  String get location_add_location => '위치 추가';

  @override
  String get tags_manage_title => '태그 관리';

  @override
  String get tags_manage_subtitle => '태그를 보고 관리하세요';

  @override
  String get tags_filter_all => '전체';

  @override
  String get tags_filter_title => '태그로 필터링';

  @override
  String get tags_suggested_title => '추천 태그';

  @override
  String get tags_selected_title => '선택된 태그';

  @override
  String get tags_add_new => '새 태그 추가';

  @override
  String get tags_input_hint => '태그 이름';

  @override
  String get tags_delete_title => '태그 삭제';

  @override
  String tags_delete_message(String tagName) {
    return '\"$tagName\"을(를) 삭제하시겠습니까? 이 태그는 모든 일기에서 제거됩니다.';
  }

  @override
  String tags_delete_success(String tagName) {
    return '\"$tagName\" 태그가 삭제되었습니다';
  }

  @override
  String get tags_no_tags => '태그 없음';

  @override
  String get tags_load_failed => '태그를 불러오지 못했습니다';

  @override
  String get tags_delete_failed => '태그 삭제에 실패했습니다';

  @override
  String get tags_menu_edit => '수정';

  @override
  String get tags_menu_delete => '삭제';

  @override
  String get home_monthly_tracker_title => '이번 달 일기 작성';

  @override
  String get home_yearly_tracker_title => '올해 일기 작성';

  @override
  String get home_monthly_tracker_legend_less => '적음';

  @override
  String get home_monthly_tracker_legend_more => '많음';

  @override
  String get common_unit_day => '일';

  @override
  String get entries_mood_filter_title => '기분으로 필터링';

  @override
  String get statistics_mood_distribution_empty => '표시할 기분 분포 데이터가 없습니다.';

  @override
  String get statistics_mood_distribution_description => '기분 분포';

  @override
  String get statistics_mood_trend_description => '기분 변화';

  @override
  String get statistics_mood_trend_daily_records => '일별 기분 기록';

  @override
  String get statistics_mood_trend_overall_average => '전체 평균 점수';

  @override
  String get statistics_mood_trend_recent_7days_average => '최근 7일 평균';

  @override
  String get home_representative_mood_title => '나의 현재 감정';

  @override
  String get home_representative_mood_description => '최근 30일 감정 분석 결과';

  @override
  String get home_representative_mood_empty => '감정 기록 없음';

  @override
  String get home_representative_mood_empty_description =>
      '일기를 작성해서 감정을 기록해보세요';

  @override
  String get calendar_month_jan => '1월';

  @override
  String get calendar_month_feb => '2월';

  @override
  String get calendar_month_mar => '3월';

  @override
  String get calendar_month_apr => '4월';

  @override
  String get calendar_month_may => '5월';

  @override
  String get calendar_month_jun => '6월';

  @override
  String get calendar_month_jul => '7월';

  @override
  String get calendar_month_aug => '8월';

  @override
  String get calendar_month_sep => '9월';

  @override
  String get calendar_month_oct => '10월';

  @override
  String get calendar_month_nov => '11월';

  @override
  String get calendar_month_dec => '12월';

  @override
  String get calendar_weekday_sun => '일';

  @override
  String get calendar_weekday_mon => '월';

  @override
  String get calendar_weekday_tue => '화';

  @override
  String get calendar_weekday_wed => '수';

  @override
  String get calendar_weekday_thu => '목';

  @override
  String get calendar_weekday_fri => '금';

  @override
  String get calendar_weekday_sat => '토';

  @override
  String get tags_dialog_title => '태그 관리';

  @override
  String get tags_dialog_empty => '태그 없음';

  @override
  String get tags_dialog_close => '닫기';

  @override
  String get tags_dialog_delete_title => '태그 삭제';

  @override
  String tags_dialog_delete_message(String tagName) {
    return '\"$tagName\"을(를) 삭제하시겠습니까? 이 태그는 모든 일기에서 제거됩니다.';
  }

  @override
  String tags_dialog_created(String date) {
    return '생성일: $date';
  }

  @override
  String get journal_image_detail_gesture_hint => '두 번 탭하여 확대/축소, 핀치로 자유롭게 조절';

  @override
  String get profile_delete_account_reauthentication_required =>
      '계정을 삭제하기 위해서는 재인증이 필요합니다.';

  @override
  String get profile_delete_account_reauthentication_google =>
      'Google 계정으로 재인증하기';

  @override
  String get profile_delete_account_reauthentication_apple =>
      'Apple 계정으로 재인증하기';

  @override
  String get profile_delete_account_reauthentication_failed =>
      '재인증에 실패했습니다. 다시 시도해주세요.';

  @override
  String get profile_delete_account_success => '계정이 성공적으로 삭제되었습니다.';

  @override
  String get profile_delete_account_error => '계정 삭제 중 오류가 발생했습니다.';

  @override
  String get profile_delete_account_apple_revoke_failed =>
      'Apple 계정 연동 해제에 실패했지만 계정 삭제는 진행됩니다.';

  @override
  String get profile_delete_account_apple_revoke_success =>
      'Apple 계정 연동이 해제되었습니다.';

  @override
  String get profile_delete_account_apple_manual_revoke_guide =>
      '완전한 Apple 계정 연동 해제를 원하실 경우:\n\n1️⃣ 웹: appleid.apple.com → 로그인 및 보안 → 앱용 Apple ID → 해당 앱 삭제\n\n2️⃣ iPhone: 설정 → Apple ID → 암호 및 보안 → Apple ID 로그인 → 해당 앱 삭제\n\n이렇게 하면 다음 로그인 시 이메일 공개 여부를 다시 선택할 수 있습니다.';

  @override
  String get weather_current_weather => '현재 날씨';

  @override
  String get weather_humidity => '습도';

  @override
  String get weather_wind => '바람';

  @override
  String get weather_pressure => '기압';

  @override
  String get location_journal_location => '일기 작성 위치';

  @override
  String get location_tap_to_open => '탭하여 열기';

  @override
  String get location_map_load_error => '지도를 불러올 수 없습니다';

  @override
  String get location_address => '주소';

  @override
  String get location_no_address => '주소 정보 없음';

  @override
  String get location_coordinates => '좌표';

  @override
  String get location_open_in_google_maps => '구글 맵에서 열기';

  @override
  String get profile_guest_mode => '게스트 모드 입니다.';

  @override
  String get profile_guest_login_button => '소셜 로그인으로 전환';

  @override
  String get profile_guest_login_description =>
      'Google 또는 Apple 계정으로 로그인하고 데이터를 동기화하세요.';

  @override
  String get lockScreenTitle => '인증이 필요합니다';

  @override
  String get lockScreenReason => '앱을 잠금 해제하려면 인증하세요.';

  @override
  String get lockScreenRetry => '재시도';

  @override
  String get proFeatureDialogTitle => 'Pro 기능 안내';

  @override
  String get proFeatureDialogContent =>
      '앱 잠금은 Pro 플랜 사용자 전용 기능입니다. 업그레이드하고 모든 프리미엄 기능을 이용해보세요!';

  @override
  String get proFeatureDialogUpgradeButton => '업그레이드';

  @override
  String home_selection_count(int count) {
    return '$count개 선택됨';
  }

  @override
  String home_delete_journals_confirm_message(int count) {
    return '$count개의 일기를 삭제하시겠습니까?';
  }
}
