// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get common_date_today => 'Hoy';

  @override
  String get common_date_tomorrow => 'Mañana';

  @override
  String get common_date_yesterday => 'Ayer';

  @override
  String get common_date_full => 'dd de MMMM de yyyy';

  @override
  String get common_confirm_cancel => 'Cancelar';

  @override
  String get common_confirm_ok => 'Confirmar';

  @override
  String get common_confirm_delete => 'Eliminar';

  @override
  String get common_confirm_save => 'Guardar';

  @override
  String get common_email => 'Correo';

  @override
  String get common_phone => 'Teléfono';

  @override
  String get common_mood_verygood => 'Muy bueno';

  @override
  String get common_mood_good => 'Bueno';

  @override
  String get common_mood_neutral => 'Normal';

  @override
  String get common_mood_bad => 'Malo';

  @override
  String get common_mood_verybad => 'Muy malo';

  @override
  String get common_month_jan => 'Enero';

  @override
  String get common_month_feb => 'Febrero';

  @override
  String get common_month_mar => 'Marzo';

  @override
  String get common_month_apr => 'Abril';

  @override
  String get common_month_may => 'Mayo';

  @override
  String get common_month_jun => 'Junio';

  @override
  String get common_month_jul => 'Julio';

  @override
  String get common_month_aug => 'Agosto';

  @override
  String get common_month_sep => 'Septiembre';

  @override
  String get common_month_oct => 'Octubre';

  @override
  String get common_month_nov => 'Noviembre';

  @override
  String get common_month_dec => 'Diciembre';

  @override
  String get common_weekday_mon => 'Lunes';

  @override
  String get common_weekday_tue => 'Martes';

  @override
  String get common_weekday_wed => 'Miércoles';

  @override
  String get common_weekday_thu => 'Jueves';

  @override
  String get common_weekday_fri => 'Viernes';

  @override
  String get common_weekday_sat => 'Sábado';

  @override
  String get common_weekday_sun => 'Domingo';

  @override
  String get common_weekday_mon_short => 'Lun';

  @override
  String get common_weekday_tue_short => 'Mar';

  @override
  String get common_weekday_wed_short => 'Mié';

  @override
  String get common_weekday_thu_short => 'Jue';

  @override
  String get common_weekday_fri_short => 'Vie';

  @override
  String get common_weekday_sat_short => 'Sáb';

  @override
  String get common_weekday_sun_short => 'Dom';

  @override
  String get onboarding_welcome_title => '¡Bienvenido a MoodLog!';

  @override
  String get onboarding_welcome_description1 =>
      'MoodLog es una aplicación donde puedes registrar tus emociones diarias y recibir respuestas de IA.';

  @override
  String get onboarding_welcome_description2 =>
      'Registra tus emociones todos los días y lee las respuestas de la IA.';

  @override
  String get onboarding_welcome_next => '¿Empezamos a prepararnos juntos?';

  @override
  String get onboarding_nickname_title => 'Configurar apodo';

  @override
  String get onboarding_nickname_description =>
      'Por favor ingresa un apodo para usar en MoodLog';

  @override
  String get onboarding_nickname_input_title => 'Apodo';

  @override
  String get onboarding_nickname_input_hint =>
      'Ingresa tu apodo (2-10 caracteres)';

  @override
  String get onboarding_nickname_next =>
      'Puedes cambiar tu apodo en cualquier momento desde el menú de configuración.';

  @override
  String get onboarding_nickname_input_error => 'Por favor ingresa un apodo.';

  @override
  String get onboarding_personality_title => 'Elegir estilo de respuesta';

  @override
  String get onboarding_personality_description =>
      'Elige la personalidad de la IA que responderá a tu diario.';

  @override
  String get onboarding_personality_rational_title => 'Analista racional';

  @override
  String get onboarding_personality_rational_description =>
      'Proporciona consejos objetivos y prácticos';

  @override
  String get onboarding_personality_balanced_title => 'Consejero equilibrado';

  @override
  String get onboarding_personality_balanced_description =>
      'Equilibra empatía y consejos realistas.';

  @override
  String get onboarding_personality_compassionate_title =>
      'Sanador comprensivo';

  @override
  String get onboarding_personality_compassionate_description =>
      'Transmite consuelo cálido y empatía profunda.';

  @override
  String get onboarding_personality_hint =>
      'Puedes cambiar la configuración en cualquier momento.';

  @override
  String get onboarding_success_title => '¡Estás listo para comenzar!';

  @override
  String get onboarding_success_description => '¿Empezamos con MoodLog?';

  @override
  String get onboarding_success_next => 'Comenzar';

  @override
  String get signin_title => '¡Estás listo para comenzar!';

  @override
  String get signin_growth => 'Registra tu corazón en crecimiento.';

  @override
  String get signin_login_title => 'Regístrate para guardar tus registros.';

  @override
  String get signin_button_guest => 'Comenzar como invitado';

  @override
  String get signin_button_google => 'Comenzar con Google';

  @override
  String get signin_button_kakao => 'Comenzar con Kakao';

  @override
  String get home_hello => '¡Hola!';

  @override
  String home_welcome(Object nickname) {
    return '$nickname.';
  }

  @override
  String get home_howareyou => '¿Cómo te sientes hoy?';

  @override
  String get home_empty_box => 'Esperando tu historia.';

  @override
  String get entries_empty_box_title => 'No hay diarios creados.';

  @override
  String get entries_empty_box_description =>
      'Los diarios creados aparecerán aquí.';

  @override
  String get entries_empty_box_button => 'Ir a escribir diario';

  @override
  String get entries_calendar_legend_has_journal => 'Tiene diario';

  @override
  String get entries_calendar_legend_today => 'Hoy';

  @override
  String get tab_home => 'Inicio';

  @override
  String get tab_entries => 'Registros';

  @override
  String get tab_settings => 'Configuración';

  @override
  String get tab_write => 'Escribir';

  @override
  String get tab_statistics => 'Estadísticas';

  @override
  String get write_mood_title => '¿Cómo te sientes hoy?';

  @override
  String get write_input_title => 'Contenido';

  @override
  String get write_input_hint =>
      'Registra tus emociones y experiencias de hoy.';

  @override
  String get write_ai_title => 'Mensaje de consuelo de IA';

  @override
  String get write_ai_description =>
      'Después de escribir tu diario, la IA te enviará mensajes de consuelo y aliento.';

  @override
  String get write_location_remove => 'Eliminar';

  @override
  String get journal_delete_confirm_title => 'Confirmar eliminación';

  @override
  String get journal_delete_confirm_description =>
      '¿Estás seguro de que quieres eliminar este elemento?';

  @override
  String get journal_ai_generating_response_title =>
      'La IA está escribiendo una respuesta.';

  @override
  String get statistics_total_title => 'Estadísticas totales';

  @override
  String get statistics_total_record_description => 'Registros totales';

  @override
  String statistics_total_record(Object count) {
    return '$count registros';
  }

  @override
  String get statistics_total_streak_description => 'Racha consecutiva';

  @override
  String statistics_total_streak(Object count) {
    return '$count días';
  }

  @override
  String get statistics_total_streak_max_description =>
      'Racha máxima consecutiva';

  @override
  String statistics_total_streak_max(Object count) {
    return '$count días';
  }

  @override
  String get statistics_mood_calendar_title => 'Calendario de emociones';

  @override
  String get statistics_mood_distribution_title =>
      'Distribución de estados de ánimo';

  @override
  String statistics_mood_distribution_unit(Object count) {
    return '$count veces';
  }

  @override
  String get statistics_mood_trend_title => 'Tendencia del estado de ánimo';

  @override
  String get statistics_mood_trend_empty =>
      'No hay datos de tendencia del estado de ánimo.';

  @override
  String get statistics_recent_title => 'Diarios recientes';

  @override
  String get statistics_recent_empty => 'No hay diarios recientes.';

  @override
  String get settings_title => 'Configuración';

  @override
  String get settings_common_title => 'General';

  @override
  String get settings_common_notification_title => 'Notificaciones';

  @override
  String get settings_common_notification_subtitle =>
      'Recibe notificaciones push.';

  @override
  String get settings_common_theme_title => 'Tema';

  @override
  String get settings_common_theme_subtitle => 'Selecciona el tema de brillo.';

  @override
  String get settings_common_theme_light => 'Tema claro';

  @override
  String get settings_common_theme_dark => 'Tema oscuro';

  @override
  String get settings_common_theme_system => 'Tema del sistema';

  @override
  String get settings_common_color_theme_title => 'Tema de color';

  @override
  String get settings_common_color_theme_subtitle =>
      'Selecciona el tema de color.';

  @override
  String get settings_common_language_title => 'Idioma';

  @override
  String get settings_common_language_dialog_title => 'Seleccionar idioma';

  @override
  String get settings_common_font_family_title => 'Fuente';

  @override
  String get settings_common_font_family_pretendard => 'Pretendard';

  @override
  String get settings_common_font_family_leeSeoyun => 'LeeSeoyun';

  @override
  String get settings_common_font_family_orbitOfTheMoon => 'Órbita de la Luna';

  @override
  String get settings_common_font_family_restart => 'Reiniciar';

  @override
  String get settings_common_font_family_overcome => 'Superar';

  @override
  String get settings_common_font_family_system => 'Fuente del sistema';

  @override
  String get settings_data_title => 'Datos';

  @override
  String get settings_data_auto_sync_title => 'Sincronización automática';

  @override
  String get settings_data_auto_sync_subtitle =>
      'Sincroniza datos automáticamente.';

  @override
  String get settings_data_backup_title => 'Copia de seguridad de datos';

  @override
  String get settings_data_backup_subtitle =>
      'Hacer copia de seguridad de datos.';

  @override
  String get settings_data_backup_confirm =>
      '¿Quieres hacer una copia de seguridad de los datos?';

  @override
  String get settings_data_backup_confirm_ok => 'Copia de seguridad';

  @override
  String get settings_data_cache_cleanup_title => 'Limpiar caché';

  @override
  String get settings_data_cache_cleanup_subtitle =>
      'Eliminar archivos temporales.';

  @override
  String get settings_data_cache_cleanup_confirm =>
      '¿Quieres eliminar el caché?\nEsta acción no se puede deshacer.';

  @override
  String get settings_ai_personality_changed =>
      'La personalidad de la IA ha sido cambiada.';

  @override
  String get settings_information_title => 'Información';

  @override
  String get settings_information_app_title => 'Información de la aplicación';

  @override
  String get settings_information_app_subtitle =>
      'Información de versión y licencia';

  @override
  String get settings_information_app_version => 'Versión';

  @override
  String get settings_information_app_build => 'Licencia';

  @override
  String get settings_information_app_developer => 'Desarrollador';

  @override
  String get settings_information_faq_title => 'Ayuda';

  @override
  String get settings_information_faq_subtitle => 'Uso y FAQ';

  @override
  String get settings_information_qna_title => 'Contacto';

  @override
  String get settings_information_qna_subtitle => 'Contactar al desarrollador.';

  @override
  String get profile_title => 'Perfil';

  @override
  String get profile_account_title => 'Información de registro';

  @override
  String get profile_nickname_title => 'Cambiar apodo';

  @override
  String get profile_nickname_hint => 'Por favor ingresa un nuevo apodo.';

  @override
  String get profile_creation_time_title => 'Fecha de registro';

  @override
  String get profile_uid_title => 'ID de usuario';

  @override
  String get profile_button_login => 'Ir a iniciar sesión';

  @override
  String get profile_button_logout => 'Cerrar sesión';

  @override
  String get write_ai_limit_reached =>
      'Las respuestas de IA están limitadas a una vez al día. ¡Inténtalo de nuevo mañana!';

  @override
  String get write_timestamp_add => 'Agregar hora';

  @override
  String get write_location_add => 'Agregar ubicación';

  @override
  String get common_language_korean => 'Coreano';

  @override
  String get common_language_english => 'English';

  @override
  String get common_language_japanese => 'Japonés';

  @override
  String get common_language_chinese => 'Chino';

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
  String get common_developing => 'En desarrollo';

  @override
  String get settings_user_info_title => 'Información de inicio de sesión';

  @override
  String get settings_user_info_empty =>
      'No hay información de inicio de sesión.';

  @override
  String get settings_user_info_status => 'Estado';

  @override
  String get settings_user_info_anonymous => 'Inicio de sesión anónimo';

  @override
  String get settings_user_info_logged_in => 'Sesión iniciada';

  @override
  String get dialog_storage_init_title => 'Inicialización de almacenamiento';

  @override
  String get dialog_storage_init_content => 'Inicializar SharedPreferences.';

  @override
  String get dialog_database_init_title => 'Inicialización de base de datos';

  @override
  String get dialog_database_init_content =>
      'Inicializar base de datos SQLite.';

  @override
  String get dialog_init_button => 'Inicializar';

  @override
  String get settings_developer_options => 'Opciones de desarrollador';

  @override
  String get settings_developer_mode_only =>
      'Operación solo modo de desarrollo';

  @override
  String get settings_ai_section_title => 'Configuración de IA';

  @override
  String get settings_ai_personality_title => 'Personalidad de IA';

  @override
  String get snackbar_backup_completed => 'Copia de seguridad completada.';

  @override
  String get snackbar_cache_cleared => 'Caché eliminado.';

  @override
  String get navigation_home => 'Inicio';

  @override
  String get navigation_entries => 'Registros';

  @override
  String get navigation_write => 'Escribir';

  @override
  String get navigation_statistics => 'Estadísticas';

  @override
  String get navigation_settings => 'Configuración';

  @override
  String auth_terms_message(String terms, String privacy) {
    return 'Al continuar, aceptas nuestros $terms y $privacy.';
  }

  @override
  String get auth_terms_of_service => 'Términos de Servicio';

  @override
  String get auth_privacy_policy => 'Política de Privacidad';

  @override
  String get app_info_copyright => '© 2024 Todos los derechos reservados';

  @override
  String get app_info_developer => 'Tu Nombre';

  @override
  String get profile_sign_out_title => 'Cerrar Sesión';

  @override
  String get profile_sign_out_message =>
      '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String journal_count(int count) {
    return '$count registros';
  }

  @override
  String get location_current => 'Ubicación actual';

  @override
  String get location_add_location => 'Agregar ubicación';

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
