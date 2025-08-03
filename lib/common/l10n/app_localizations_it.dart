// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get common_date_today => 'Oggi';

  @override
  String get common_date_tomorrow => 'Domani';

  @override
  String get common_date_yesterday => 'Ieri';

  @override
  String get common_date_full => 'dd MMMM yyyy';

  @override
  String get common_confirm_cancel => 'Annulla';

  @override
  String get common_confirm_ok => 'Conferma';

  @override
  String get common_confirm_delete => 'Elimina';

  @override
  String get common_confirm_save => 'Salva';

  @override
  String get common_email => 'Email';

  @override
  String get common_phone => 'Telefono';

  @override
  String get common_mood_verygood => 'Molto buono';

  @override
  String get common_mood_good => 'Buono';

  @override
  String get common_mood_neutral => 'Neutrale';

  @override
  String get common_mood_bad => 'Cattivo';

  @override
  String get common_mood_verybad => 'Molto cattivo';

  @override
  String get common_month_jan => 'Gennaio';

  @override
  String get common_month_feb => 'Febbraio';

  @override
  String get common_month_mar => 'Marzo';

  @override
  String get common_month_apr => 'Aprile';

  @override
  String get common_month_may => 'Maggio';

  @override
  String get common_month_jun => 'Giugno';

  @override
  String get common_month_jul => 'Luglio';

  @override
  String get common_month_aug => 'Agosto';

  @override
  String get common_month_sep => 'Settembre';

  @override
  String get common_month_oct => 'Ottobre';

  @override
  String get common_month_nov => 'Novembre';

  @override
  String get common_month_dec => 'Dicembre';

  @override
  String get common_weekday_mon => 'Lunedì';

  @override
  String get common_weekday_tue => 'Martedì';

  @override
  String get common_weekday_wed => 'Mercoledì';

  @override
  String get common_weekday_thu => 'Giovedì';

  @override
  String get common_weekday_fri => 'Venerdì';

  @override
  String get common_weekday_sat => 'Sabato';

  @override
  String get common_weekday_sun => 'Domenica';

  @override
  String get common_weekday_mon_short => 'Lun';

  @override
  String get common_weekday_tue_short => 'Mar';

  @override
  String get common_weekday_wed_short => 'Mer';

  @override
  String get common_weekday_thu_short => 'Gio';

  @override
  String get common_weekday_fri_short => 'Ven';

  @override
  String get common_weekday_sat_short => 'Sab';

  @override
  String get common_weekday_sun_short => 'Dom';

  @override
  String get onboarding_welcome_title => 'Benvenuto in MoodLog!';

  @override
  String get onboarding_welcome_description1 =>
      'MoodLog è un\'app dove puoi registrare le tue emozioni quotidiane e ricevere risposte dall\'IA.';

  @override
  String get onboarding_welcome_description2 =>
      'Registra le tue emozioni ogni giorno e leggi le risposte dell\'IA.';

  @override
  String get onboarding_welcome_next => 'Iniziamo a prepararci insieme?';

  @override
  String get onboarding_nickname_title => 'Imposta soprannome';

  @override
  String get onboarding_nickname_description =>
      'Inserisci un soprannome da usare in MoodLog';

  @override
  String get onboarding_nickname_input_title => 'Soprannome';

  @override
  String get onboarding_nickname_input_hint =>
      'Inserisci soprannome (2-10 caratteri)';

  @override
  String get onboarding_nickname_next =>
      'Puoi cambiare il soprannome in qualsiasi momento dal menu impostazioni.';

  @override
  String get onboarding_nickname_input_error => 'Inserisci un soprannome.';

  @override
  String get onboarding_personality_title => 'Scegli stile di risposta';

  @override
  String get onboarding_personality_description =>
      'Scegli la personalità dell\'IA che risponderà al tuo diario.';

  @override
  String get onboarding_personality_rational_title => 'Analista razionale';

  @override
  String get onboarding_personality_rational_description =>
      'Fornisce consigli obiettivi e pratici';

  @override
  String get onboarding_personality_balanced_title => 'Consulente equilibrato';

  @override
  String get onboarding_personality_balanced_description =>
      'Bilancia empatia e consigli realistici.';

  @override
  String get onboarding_personality_compassionate_title =>
      'Guaritore compassionevole';

  @override
  String get onboarding_personality_compassionate_description =>
      'Trasmette conforto caloroso ed empatia profonda.';

  @override
  String get onboarding_personality_hint =>
      'Puoi cambiare l\'impostazione in qualsiasi momento.';

  @override
  String get onboarding_success_title => 'Sei pronto per iniziare!';

  @override
  String get onboarding_success_description => 'Iniziamo con MoodLog?';

  @override
  String get onboarding_success_next => 'Inizia';

  @override
  String get signin_title => 'Sei pronto per iniziare!';

  @override
  String get signin_growth => 'Registra il tuo cuore in crescita.';

  @override
  String get signin_login_title => 'Registrati per salvare i tuoi record.';

  @override
  String get signin_button_guest => 'Inizia come ospite';

  @override
  String get signin_button_google => 'Inizia con Google';

  @override
  String get signin_button_kakao => 'Inizia con Kakao';

  @override
  String get home_hello => 'Ciao!';

  @override
  String home_welcome(Object nickname) {
    return '$nickname.';
  }

  @override
  String get home_howareyou => 'Come ti senti oggi?';

  @override
  String get home_empty_box => 'Aspettando la tua storia.';

  @override
  String get entries_empty_box_title => 'Nessun diario creato.';

  @override
  String get entries_empty_box_description => 'I diari creati appariranno qui.';

  @override
  String get entries_empty_box_button => 'Vai a scrivere diario';

  @override
  String get entries_calendar_legend_has_journal => 'Ha diario';

  @override
  String get entries_calendar_legend_today => 'Oggi';

  @override
  String get tab_home => 'Home';

  @override
  String get tab_entries => 'Registrazioni';

  @override
  String get tab_settings => 'Impostazioni';

  @override
  String get tab_write => 'Scrivi';

  @override
  String get tab_statistics => 'Statistiche';

  @override
  String get write_mood_title => 'Come ti senti oggi?';

  @override
  String get write_input_title => 'Contenuto';

  @override
  String get write_input_hint =>
      'Registra le tue emozioni ed esperienze di oggi.';

  @override
  String get write_ai_title => 'Messaggio di conforto IA';

  @override
  String get write_ai_description =>
      'Dopo aver scritto il tuo diario, l\'IA ti invierà messaggi di conforto e incoraggiamento.';

  @override
  String get write_location_remove => 'Rimuovi';

  @override
  String get journal_delete_confirm_title => 'Conferma eliminazione';

  @override
  String get journal_delete_confirm_description =>
      'Sei sicuro di voler eliminare questo elemento?';

  @override
  String get journal_ai_generating_response_title =>
      'L\'IA sta scrivendo una risposta.';

  @override
  String get statistics_total_title => 'Statistiche totali';

  @override
  String get statistics_total_record_description => 'Registrazioni totali';

  @override
  String statistics_total_record(Object count) {
    return '$count registrazioni';
  }

  @override
  String get statistics_total_streak_description => 'Serie consecutiva';

  @override
  String statistics_total_streak(Object count) {
    return '$count giorni';
  }

  @override
  String get statistics_total_streak_max_description =>
      'Serie massima consecutiva';

  @override
  String statistics_total_streak_max(Object count) {
    return '$count giorni';
  }

  @override
  String get statistics_mood_calendar_title => 'Calendario delle emozioni';

  @override
  String get statistics_mood_distribution_title => 'Distribuzione dell\'umore';

  @override
  String statistics_mood_distribution_unit(Object count) {
    return '$count volte';
  }

  @override
  String get statistics_mood_trend_title => 'Tendenza dell\'umore';

  @override
  String get statistics_mood_trend_empty =>
      'Nessun dato sulla tendenza dell\'umore.';

  @override
  String get statistics_recent_title => 'Diari recenti';

  @override
  String get statistics_recent_empty => 'Nessun diario recente.';

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
  String get statistics_streak_today => '오늘';

  @override
  String get statistics_streak_yesterday => '어제';

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
  String get statistics_weekday_monday => '월요일';

  @override
  String get statistics_weekday_tuesday => '화요일';

  @override
  String get statistics_weekday_wednesday => '수요일';

  @override
  String get statistics_weekday_thursday => '목요일';

  @override
  String get statistics_weekday_friday => '금요일';

  @override
  String get statistics_weekday_saturday => '토요일';

  @override
  String get statistics_weekday_sunday => '일요일';

  @override
  String get statistics_writing_frequency_good_habit => '꾸준히 기록하고 계시는군요! 훌륭해요!';

  @override
  String get statistics_writing_frequency_encouragement =>
      '조금 더 자주 기록해보세요. 작은 순간들도 소중해요!';

  @override
  String get settings_title => 'Impostazioni';

  @override
  String get settings_common_title => 'Generale';

  @override
  String get settings_common_notification_title => 'Notifiche';

  @override
  String get settings_common_notification_subtitle => 'Ricevi notifiche push.';

  @override
  String get settings_common_theme_title => 'Tema';

  @override
  String get settings_common_theme_subtitle => 'Seleziona tema luminosità.';

  @override
  String get settings_common_theme_light => 'Tema chiaro';

  @override
  String get settings_common_theme_dark => 'Tema scuro';

  @override
  String get settings_common_theme_system => 'Tema sistema';

  @override
  String get settings_common_color_theme_title => 'Tema colore';

  @override
  String get settings_common_color_theme_subtitle => 'Seleziona tema colore.';

  @override
  String get settings_common_language_title => 'Lingua';

  @override
  String get settings_common_language_dialog_title => 'Seleziona lingua';

  @override
  String get settings_common_font_family_title => 'Font';

  @override
  String get settings_common_font_family_pretendard => 'Pretendard';

  @override
  String get settings_common_font_family_leeSeoyun => 'LeeSeoyun';

  @override
  String get settings_common_font_family_orbitOfTheMoon => 'Orbita della Luna';

  @override
  String get settings_common_font_family_restart => 'Ricomincia';

  @override
  String get settings_common_font_family_overcome => 'Supera';

  @override
  String get settings_common_font_family_system => 'Font sistema';

  @override
  String get settings_data_title => 'Dati';

  @override
  String get settings_data_auto_sync_title => 'Sincronizzazione automatica';

  @override
  String get settings_data_auto_sync_subtitle =>
      'Sincronizza automaticamente i dati.';

  @override
  String get settings_data_backup_title => 'Backup dati';

  @override
  String get settings_data_backup_subtitle => 'Esegui backup dei dati.';

  @override
  String get settings_data_backup_confirm =>
      'Vuoi eseguire il backup dei dati?';

  @override
  String get settings_data_backup_confirm_ok => 'Backup';

  @override
  String get settings_data_cache_cleanup_title => 'Pulisci cache';

  @override
  String get settings_data_cache_cleanup_subtitle => 'Elimina file temporanei.';

  @override
  String get settings_data_cache_cleanup_confirm =>
      'Vuoi eliminare la cache?\nQuesta azione non può essere annullata.';

  @override
  String get settings_ai_personality_changed =>
      'La personalità dell\'IA è stata cambiata.';

  @override
  String get settings_information_title => 'Informazioni';

  @override
  String get settings_information_app_title => 'Informazioni app';

  @override
  String get settings_information_app_subtitle =>
      'Informazioni su versione e licenza';

  @override
  String get settings_information_app_version => 'Versione';

  @override
  String get settings_information_app_build => 'Licenza';

  @override
  String get settings_information_app_developer => 'Sviluppatore';

  @override
  String get settings_information_faq_title => 'Aiuto';

  @override
  String get settings_information_faq_subtitle => 'Uso e FAQ';

  @override
  String get settings_information_qna_title => 'Contatto';

  @override
  String get settings_information_qna_subtitle => 'Contatta lo sviluppatore.';

  @override
  String get profile_title => 'Profilo';

  @override
  String get profile_account_title => 'Informazioni registrazione';

  @override
  String get profile_nickname_title => 'Cambia soprannome';

  @override
  String get profile_nickname_hint => 'Inserisci un nuovo soprannome.';

  @override
  String get profile_creation_time_title => 'Data registrazione';

  @override
  String get profile_uid_title => 'ID utente';

  @override
  String get profile_button_login => 'Vai al login';

  @override
  String get profile_button_logout => 'Disconnetti';

  @override
  String get write_ai_limit_reached =>
      'Le risposte IA sono limitate a una volta al giorno. Riprova domani!';

  @override
  String get write_timestamp_add => 'Aggiungi ora';

  @override
  String get write_location_add => 'Aggiungi posizione';

  @override
  String get common_language_korean => 'Coreano';

  @override
  String get common_language_english => 'English';

  @override
  String get common_language_japanese => 'Giapponese';

  @override
  String get common_language_chinese => 'Cinese';

  @override
  String get common_language_spanish => 'Spagnolo';

  @override
  String get common_language_italian => 'Italiano';

  @override
  String get common_language_french => 'Francese';

  @override
  String get common_language_vietnamese => 'Vietnamita';

  @override
  String get common_language_thai => 'Tailandese';

  @override
  String get common_developing => 'In sviluppo';

  @override
  String get settings_user_info_title => 'Informazioni login';

  @override
  String get settings_user_info_empty => 'Nessuna informazione di login.';

  @override
  String get settings_user_info_status => 'Stato';

  @override
  String get settings_user_info_anonymous => 'Login anonimo';

  @override
  String get settings_user_info_logged_in => 'Connesso';

  @override
  String get dialog_storage_init_title => 'Inizializzazione archiviazione';

  @override
  String get dialog_storage_init_content => 'Inizializza SharedPreferences.';

  @override
  String get dialog_database_init_title => 'Inizializzazione database';

  @override
  String get dialog_database_init_content => 'Inizializza database SQLite.';

  @override
  String get dialog_init_button => 'Inizializza';

  @override
  String get settings_developer_options => 'Opzioni sviluppatore';

  @override
  String get settings_developer_mode_only => 'Solo modalità sviluppo';

  @override
  String get settings_ai_section_title => 'Impostazioni IA';

  @override
  String get settings_ai_personality_title => 'Personalità IA';

  @override
  String get snackbar_backup_completed => 'Backup completato.';

  @override
  String get snackbar_cache_cleared => 'Cache eliminata.';

  @override
  String get navigation_home => 'Home';

  @override
  String get navigation_entries => 'Registrazioni';

  @override
  String get navigation_write => 'Scrivi';

  @override
  String get navigation_statistics => 'Statistiche';

  @override
  String get navigation_settings => 'Impostazioni';

  @override
  String auth_terms_message(String terms, String privacy) {
    return 'Continuando, accetti i nostri $terms e $privacy.';
  }

  @override
  String get auth_terms_of_service => 'Termini di Servizio';

  @override
  String get auth_privacy_policy => 'Politica sulla Privacy';

  @override
  String get app_info_copyright => '© 2024 Tutti i diritti riservati';

  @override
  String get app_info_developer => 'Il Tuo Nome';

  @override
  String get profile_sign_out_title => 'Disconnetti';

  @override
  String get profile_sign_out_message => 'Sei sicuro di voler disconnetterti?';

  @override
  String journal_count(int count) {
    return '$count registrazioni';
  }

  @override
  String get location_current => 'Posizione attuale';

  @override
  String get location_add_location => 'Aggiungi posizione';

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
}
