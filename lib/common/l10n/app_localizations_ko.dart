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
  String get common_email => '이메일';

  @override
  String get common_phone => '전화';

  @override
  String get common_mood_verygood => '매우 좋음';

  @override
  String get common_mood_good => '좋음';

  @override
  String get common_mood_neutral => '보통';

  @override
  String get common_mood_bad => '안좋음';

  @override
  String get common_mood_verybad => '매우 안좋음';

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
  String get onboarding_welcome_title => '무드로그에 오신 것을 환영합니다!';

  @override
  String get onboarding_welcome_description1 =>
      '무드로그는 당신의 일상 감정을 기록하고 그에 대한 AI의 답장을 받을 수 있는 앱입니다.';

  @override
  String get onboarding_welcome_description2 => '매일 감정을 기록하고 AI가 해준 답장을 읽어보세요.';

  @override
  String get onboarding_welcome_next => '함께 준비해볼까요?';

  @override
  String get onboarding_nickname_title => '닉네임 설정';

  @override
  String get onboarding_nickname_description => '무드로그에서 사용할 닉네임을 입력해주세요';

  @override
  String get onboarding_nickname_input_title => '닉네임';

  @override
  String get onboarding_nickname_input_hint => '닉네임을 입력하세요 (2~10자)';

  @override
  String get onboarding_nickname_next => '닉네임은 언제든지 설정 메뉴에서 변경할 수 있어요.';

  @override
  String get onboarding_nickname_input_error => '닉네임을 입력해주세요.';

  @override
  String get onboarding_personality_title => '답장 스타일 정하기';

  @override
  String get onboarding_personality_description =>
      '당신의 일기에 답변해줄 AI의 성격을 선택하세요.';

  @override
  String get onboarding_personality_rational_title => '냉철한 분석가';

  @override
  String get onboarding_personality_rational_description =>
      '객관적이고 실용적인 조언을 제공합니다';

  @override
  String get onboarding_personality_balanced_title => '균형잡힌 조언자';

  @override
  String get onboarding_personality_balanced_description =>
      '공감과 현실적 조언의 균형을 맞춥니다.';

  @override
  String get onboarding_personality_compassionate_title => '다정한 치유자';

  @override
  String get onboarding_personality_compassionate_description =>
      '따뜻한 위로와 깊은 공감을 전합니다.';

  @override
  String get onboarding_personality_hint => '설정에서 언제든지 바꿀 수 있습니다.';

  @override
  String get onboarding_success_title => '시작할 준비가 되었어요!';

  @override
  String get onboarding_success_description => '무드로그를 시작해볼까요?';

  @override
  String get onboarding_success_next => '시작하기';

  @override
  String get signin_title => '시작할 준비가 되었어요!';

  @override
  String get signin_growth => '성장하는 마음을 기록하세요.';

  @override
  String get signin_login_title => '가입하여 기록을 저장하세요.';

  @override
  String get signin_button_guest => '게스트로 시작하기';

  @override
  String get signin_button_google => '구글 아이디로 시작하기';

  @override
  String get signin_button_kakao => '카카오 아이디로 시작하기';

  @override
  String get home_hello => '안녕하세요!';

  @override
  String home_welcome(Object nickname) {
    return '$nickname 님.';
  }

  @override
  String get home_howareyou => '오늘 기분은 어떠세요?';

  @override
  String get home_empty_box => '당신의 이야기를 기다리고 있어요.';

  @override
  String get entries_empty_box_title => '작성된 일기가 없습니다.';

  @override
  String get entries_empty_box_description => '작성한 일기가 이곳에 나타납니다.';

  @override
  String get entries_empty_box_button => '일기 작성하러 가기';

  @override
  String get entries_calendar_legend_has_journal => '일기 있음';

  @override
  String get entries_calendar_legend_today => '오늘';

  @override
  String get tab_home => '홈';

  @override
  String get tab_entries => '기록';

  @override
  String get tab_settings => '설정';

  @override
  String get tab_write => '글쓰기';

  @override
  String get tab_statistics => '통계';

  @override
  String get write_title => '일기 작성';

  @override
  String get write_edit_title => '일기 수정';

  @override
  String get write_mood_title => '오늘의 기분은 어떠신가요?';

  @override
  String get write_mood_subtitle => '기분을 선택해주세요';

  @override
  String get write_input_title => '내용';

  @override
  String get write_input_hint => '오늘의 감정과 경험을 기록해보세요.';

  @override
  String get write_ai_title => 'AI 위로 메시지';

  @override
  String get write_ai_description => '일기 작성 후 AI가 위로와 격려의 메시지를 보내드려요.';

  @override
  String get write_location_remove => '제거';

  @override
  String get journal_delete_confirm_title => '삭제 확인';

  @override
  String get journal_delete_confirm_description => '이 항목을 삭제하시겠습니까?';

  @override
  String get journal_ai_generating_response_title => 'AI가 답변을 작성 중입니다.';

  @override
  String get statistics_total_title => '전체 통계';

  @override
  String get statistics_total_record_description => '총 기록';

  @override
  String statistics_total_record(Object count) {
    return '$count개';
  }

  @override
  String get statistics_total_streak_description => '연속 기록';

  @override
  String statistics_total_streak(Object count) {
    return '$count일';
  }

  @override
  String get statistics_total_streak_max_description => '최대 연속 기록';

  @override
  String statistics_total_streak_max(Object count) {
    return '$count일';
  }

  @override
  String get statistics_mood_calendar_title => '감정 달력';

  @override
  String get statistics_mood_distribution_title => '기분 분포';

  @override
  String statistics_mood_distribution_unit(Object count) {
    return '$count회';
  }

  @override
  String get statistics_mood_trend_title => '기분 추이';

  @override
  String get statistics_mood_trend_empty => '기분 추이 데이터가 없습니다.';

  @override
  String get statistics_recent_title => '최근 일기';

  @override
  String get statistics_recent_empty => '최근 일기가 없습니다.';

  @override
  String get statistics_total_records_count_unit => '개의 기록';

  @override
  String get statistics_total_records_first_record => '첫 기록';

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
    return '$frequency회/주';
  }

  @override
  String get statistics_streak_status_active => '진행 중';

  @override
  String get statistics_streak_status_inactive => '중단됨';

  @override
  String get statistics_streak_last_record => '마지막 기록';

  @override
  String statistics_streak_days_ago(int days) {
    return '$days일 전';
  }

  @override
  String get statistics_streak_stopped => '연속 기록 중단';

  @override
  String statistics_streak_stopped_days(int days) {
    return '$days일 전';
  }

  @override
  String get statistics_streak_encouragement => '훌륭해요! 연속 기록을 이어가고 있어요';

  @override
  String get statistics_max_streak_new_record => '신기록!';

  @override
  String get statistics_max_streak_progress => '현재 진행률';

  @override
  String get statistics_max_streak_remaining => '최고 기록까지';

  @override
  String statistics_max_streak_remaining_days(int days) {
    return '$days일 남음';
  }

  @override
  String get statistics_max_streak_achievement_week => '일주일 연속 기록 달성! 잘하고 있어요!';

  @override
  String get statistics_max_streak_achievement_two_weeks =>
      '2주 연속 기록 달성! 훌륭해요!';

  @override
  String get statistics_max_streak_achievement_month =>
      '한 달 연속 기록 달성! 정말 대단해요!';

  @override
  String get statistics_average_mood_title => '평균 기분';

  @override
  String statistics_average_mood_score(String score) {
    return '평균 $score점';
  }

  @override
  String get statistics_average_mood_most_frequent => '가장 자주 느낀 기분';

  @override
  String get statistics_average_mood_recent_trend => '최근 7일 추이';

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
      '힘든 시간을 보내고 계시는군요. 스스로를 돌보는 시간을 가져보세요.';

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
  String get statistics_writing_frequency_most_active_time => '가장 자주 쓰는 시간';

  @override
  String get statistics_writing_frequency_most_active_day => '가장 자주 쓰는 요일';

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
  String get statistics_writing_frequency_good_habit => '꾸준히 기록하고 계시는군요! 훌륭해요!';

  @override
  String get statistics_writing_frequency_encouragement =>
      '조금 더 자주 기록해보세요. 작은 순간들도 소중해요!';

  @override
  String get settings_title => '설정';

  @override
  String get settings_common_title => '일반';

  @override
  String get settings_common_notification_title => '알림';

  @override
  String get settings_common_notification_subtitle => '푸시 알림을 받습니다.';

  @override
  String get settings_common_theme_title => '테마';

  @override
  String get settings_common_theme_subtitle => '밝기 테마를 선택합니다.';

  @override
  String get settings_common_theme_light => '밝은 테마';

  @override
  String get settings_common_theme_dark => '어두운 테마';

  @override
  String get settings_common_theme_system => '시스템 테마';

  @override
  String get settings_common_color_theme_title => '색상 테마';

  @override
  String get settings_common_color_theme_subtitle => '색상 테마를 선택합니다.';

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
  String get settings_common_font_family_orbitOfTheMoon => '나눔손글씨 달의궤도';

  @override
  String get settings_common_font_family_restart => '나눔손글씨 다시 시작해';

  @override
  String get settings_common_font_family_overcome => '나눔손글씨 나는 이겨낸다';

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
  String get settings_data_backup_confirm => '데이터 백업하시겠습니까?';

  @override
  String get settings_data_backup_confirm_ok => '백업';

  @override
  String get settings_data_cache_cleanup_title => '캐시 정리';

  @override
  String get settings_data_cache_cleanup_subtitle => '임시 파일을 삭제합니다.';

  @override
  String get settings_data_cache_cleanup_confirm =>
      '캐시를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.';

  @override
  String get settings_ai_personality_changed => 'AI 성격이 변경되었습니다.';

  @override
  String get settings_information_title => '정보';

  @override
  String get settings_information_app_title => '앱 정보';

  @override
  String get settings_information_app_subtitle => '버전 및 라이선스 정보';

  @override
  String get settings_information_app_version => '버전';

  @override
  String get settings_information_app_build => '라이선스';

  @override
  String get settings_information_app_developer => '개발자';

  @override
  String get settings_information_faq_title => '도움말';

  @override
  String get settings_information_faq_subtitle => '사용법 및 FAQ';

  @override
  String get settings_information_qna_title => '문의하기';

  @override
  String get settings_information_qna_subtitle => '개발자에게 문의합니다.';

  @override
  String get profile_title => '프로필';

  @override
  String get profile_account_title => '가입 정보';

  @override
  String get profile_nickname_title => '닉네임 변경';

  @override
  String get profile_nickname_hint => '새 닉네임을 입력하세요.';

  @override
  String get profile_creation_time_title => '가입일';

  @override
  String get profile_uid_title => '유저 ID';

  @override
  String get profile_button_login => '로그인 하러 가기';

  @override
  String get profile_button_logout => '로그아웃';

  @override
  String get write_ai_limit_reached => 'AI 답변은 하루에 한 번만 가능합니다. 내일 다시 시도해주세요!';

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
  String get common_developing => '개발중';

  @override
  String get settings_user_info_title => '로그인 정보';

  @override
  String get settings_user_info_empty => '로그인 정보가 없습니다.';

  @override
  String get settings_user_info_status => '상태';

  @override
  String get settings_user_info_anonymous => '익명 로그인';

  @override
  String get settings_user_info_logged_in => '로그인';

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
  String get settings_developer_options => '개발용 옵션';

  @override
  String get settings_developer_mode_only => '개발모드 전용 동작';

  @override
  String get settings_ai_section_title => 'AI 설정';

  @override
  String get settings_ai_personality_title => 'AI 성격';

  @override
  String get snackbar_backup_completed => '백업이 완료되었습니다.';

  @override
  String get snackbar_cache_cleared => '캐시가 삭제되었습니다.';

  @override
  String auth_terms_message(String terms, String privacy) {
    return '계속 함으로써 $terms과 $privacy에 동의합니다.';
  }

  @override
  String get auth_terms_of_service => '이용약관';

  @override
  String get auth_privacy_policy => '개인정보처리방침';

  @override
  String get app_info_copyright => '© 2024 All rights reserved';

  @override
  String get app_info_developer => 'Your Name';

  @override
  String get profile_sign_out_title => '로그아웃';

  @override
  String get profile_sign_out_message => '정말로 로그아웃하시겠습니까?';

  @override
  String journal_count(int count) {
    return '$count개';
  }

  @override
  String get location_current => '현재 위치';

  @override
  String get location_add_location => '위치 추가하기';

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
    return '\"$tagName\"을(를) 삭제하시겠습니까? 모든 일기에서 이 태그가 제거됩니다.';
  }

  @override
  String tags_delete_success(String tagName) {
    return '태그 \"$tagName\"이(가) 삭제되었습니다';
  }

  @override
  String get tags_no_tags => '태그가 없습니다';

  @override
  String get tags_load_failed => '태그를 불러오지 못했습니다';

  @override
  String get tags_delete_failed => '태그 삭제에 실패했습니다';

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
  String get entries_mood_filter_title => '감정으로 필터링';

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
