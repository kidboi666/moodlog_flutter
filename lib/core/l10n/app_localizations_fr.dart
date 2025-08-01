// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get common_date_today => 'Aujourd\'hui';

  @override
  String get common_date_tomorrow => 'Demain';

  @override
  String get common_date_yesterday => 'Hier';

  @override
  String get common_date_full => 'dd MMMM yyyy';

  @override
  String get common_confirm_cancel => 'Annuler';

  @override
  String get common_confirm_ok => 'Confirmer';

  @override
  String get common_confirm_delete => 'Supprimer';

  @override
  String get common_confirm_save => 'Enregistrer';

  @override
  String get common_email => 'Email';

  @override
  String get common_phone => 'Téléphone';

  @override
  String get common_mood_verygood => 'Très bien';

  @override
  String get common_mood_good => 'Bien';

  @override
  String get common_mood_neutral => 'Neutre';

  @override
  String get common_mood_bad => 'Mauvais';

  @override
  String get common_mood_verybad => 'Très mauvais';

  @override
  String get common_month_jan => 'Janvier';

  @override
  String get common_month_feb => 'Février';

  @override
  String get common_month_mar => 'Mars';

  @override
  String get common_month_apr => 'Avril';

  @override
  String get common_month_may => 'Mai';

  @override
  String get common_month_jun => 'Juin';

  @override
  String get common_month_jul => 'Juillet';

  @override
  String get common_month_aug => 'Août';

  @override
  String get common_month_sep => 'Septembre';

  @override
  String get common_month_oct => 'Octobre';

  @override
  String get common_month_nov => 'Novembre';

  @override
  String get common_month_dec => 'Décembre';

  @override
  String get common_weekday_mon => 'Lundi';

  @override
  String get common_weekday_tue => 'Mardi';

  @override
  String get common_weekday_wed => 'Mercredi';

  @override
  String get common_weekday_thu => 'Jeudi';

  @override
  String get common_weekday_fri => 'Vendredi';

  @override
  String get common_weekday_sat => 'Samedi';

  @override
  String get common_weekday_sun => 'Dimanche';

  @override
  String get common_weekday_mon_short => 'Lun';

  @override
  String get common_weekday_tue_short => 'Mar';

  @override
  String get common_weekday_wed_short => 'Mer';

  @override
  String get common_weekday_thu_short => 'Jeu';

  @override
  String get common_weekday_fri_short => 'Ven';

  @override
  String get common_weekday_sat_short => 'Sam';

  @override
  String get common_weekday_sun_short => 'Dim';

  @override
  String get onboarding_welcome_title => 'Bienvenue dans MoodLog !';

  @override
  String get onboarding_welcome_description1 =>
      'MoodLog est une application où vous pouvez enregistrer vos émotions quotidiennes et recevoir des réponses de l\'IA.';

  @override
  String get onboarding_welcome_description2 =>
      'Enregistrez vos émotions chaque jour et lisez les réponses de l\'IA.';

  @override
  String get onboarding_welcome_next => 'Commençons à nous préparer ensemble ?';

  @override
  String get onboarding_nickname_title => 'Définir le surnom';

  @override
  String get onboarding_nickname_description =>
      'Veuillez entrer un surnom à utiliser dans MoodLog';

  @override
  String get onboarding_nickname_input_title => 'Surnom';

  @override
  String get onboarding_nickname_input_hint =>
      'Entrez le surnom (2-10 caractères)';

  @override
  String get onboarding_nickname_next =>
      'Vous pouvez changer votre surnom à tout moment dans le menu des paramètres.';

  @override
  String get onboarding_nickname_input_error => 'Veuillez entrer un surnom.';

  @override
  String get onboarding_personality_title => 'Choisir le style de réponse';

  @override
  String get onboarding_personality_description =>
      'Choisissez la personnalité de l\'IA qui répondra à votre journal.';

  @override
  String get onboarding_personality_rational_title => 'Analyste rationnel';

  @override
  String get onboarding_personality_rational_description =>
      'Fournit des conseils objectifs et pratiques';

  @override
  String get onboarding_personality_balanced_title => 'Conseiller équilibré';

  @override
  String get onboarding_personality_balanced_description =>
      'Équilibre empathie et conseils réalistes.';

  @override
  String get onboarding_personality_compassionate_title =>
      'Guérisseur compatissant';

  @override
  String get onboarding_personality_compassionate_description =>
      'Transmet réconfort chaleureux et empathie profonde.';

  @override
  String get onboarding_personality_hint =>
      'Vous pouvez changer le paramètre à tout moment.';

  @override
  String get onboarding_success_title => 'Vous êtes prêt à commencer !';

  @override
  String get onboarding_success_description => 'Commençons avec MoodLog ?';

  @override
  String get onboarding_success_next => 'Commencer';

  @override
  String get signin_title => 'Vous êtes prêt à commencer !';

  @override
  String get signin_growth => 'Enregistrez votre cœur qui grandit.';

  @override
  String get signin_login_title =>
      'Inscrivez-vous pour sauvegarder vos enregistrements.';

  @override
  String get signin_button_guest => 'Commencer en tant qu\'invité';

  @override
  String get signin_button_google => 'Commencer avec Google';

  @override
  String get signin_button_kakao => 'Commencer avec Kakao';

  @override
  String get home_hello => 'Bonjour !';

  @override
  String home_welcome(Object userName) {
    return '$userName.';
  }

  @override
  String get home_howareyou => 'Comment vous sentez-vous aujourd\'hui ?';

  @override
  String get home_empty_box => 'En attente de votre histoire.';

  @override
  String get entries_empty_box_title => 'Aucun journal créé.';

  @override
  String get entries_empty_box_description =>
      'Les journaux créés apparaîtront ici.';

  @override
  String get entries_empty_box_button => 'Aller écrire un journal';

  @override
  String get entries_calendar_legend_has_journal => 'A un journal';

  @override
  String get entries_calendar_legend_today => 'Aujourd\'hui';

  @override
  String get tab_home => 'Accueil';

  @override
  String get tab_entries => 'Entrées';

  @override
  String get tab_settings => 'Paramètres';

  @override
  String get tab_write => 'Écrire';

  @override
  String get tab_statistics => 'Statistiques';

  @override
  String get write_mood_title => 'Comment vous sentez-vous aujourd\'hui ?';

  @override
  String get write_input_title => 'Contenu';

  @override
  String get write_input_hint =>
      'Enregistrez vos émotions et expériences d\'aujourd\'hui.';

  @override
  String get write_ai_title => 'Message de réconfort IA';

  @override
  String get write_ai_description =>
      'Après avoir écrit votre journal, l\'IA vous enverra des messages de réconfort et d\'encouragement.';

  @override
  String get write_location_remove => 'Supprimer';

  @override
  String get journal_delete_confirm_title => 'Confirmer la suppression';

  @override
  String get journal_delete_confirm_description =>
      'Êtes-vous sûr de vouloir supprimer cet élément ?';

  @override
  String get journal_ai_generating_response_title => 'L\'IA écrit une réponse.';

  @override
  String get statistics_total_title => 'Statistiques totales';

  @override
  String get statistics_total_record_description => 'Enregistrements totaux';

  @override
  String statistics_total_record(Object count) {
    return '$count enregistrements';
  }

  @override
  String get statistics_total_streak_description => 'Série consécutive';

  @override
  String statistics_total_streak(Object count) {
    return '$count jours';
  }

  @override
  String get statistics_total_streak_max_description =>
      'Série maximale consécutive';

  @override
  String statistics_total_streak_max(Object count) {
    return '$count jours';
  }

  @override
  String get statistics_mood_calendar_title => 'Calendrier des émotions';

  @override
  String get statistics_mood_distribution_title => 'Distribution de l\'humeur';

  @override
  String statistics_mood_distribution_unit(Object count) {
    return '$count fois';
  }

  @override
  String get statistics_mood_trend_title => 'Tendance de l\'humeur';

  @override
  String get statistics_mood_trend_empty =>
      'Aucune donnée de tendance d\'humeur.';

  @override
  String get statistics_recent_title => 'Journaux récents';

  @override
  String get statistics_recent_empty => 'Aucun journal récent.';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get settings_common_title => 'Général';

  @override
  String get settings_common_notification_title => 'Notifications';

  @override
  String get settings_common_notification_subtitle =>
      'Recevoir des notifications push.';

  @override
  String get settings_common_theme_title => 'Thème';

  @override
  String get settings_common_theme_subtitle =>
      'Sélectionner le thème de luminosité.';

  @override
  String get settings_common_theme_light => 'Thème clair';

  @override
  String get settings_common_theme_dark => 'Thème sombre';

  @override
  String get settings_common_theme_system => 'Thème système';

  @override
  String get settings_common_color_theme_title => 'Thème de couleur';

  @override
  String get settings_common_color_theme_subtitle =>
      'Sélectionner le thème de couleur.';

  @override
  String get settings_common_language_title => 'Langue';

  @override
  String get settings_common_language_dialog_title => 'Sélectionner la langue';

  @override
  String get settings_common_font_family_title => 'Police';

  @override
  String get settings_common_font_family_pretendard => 'Pretendard';

  @override
  String get settings_common_font_family_leeSeoyun => 'LeeSeoyun';

  @override
  String get settings_common_font_family_orbitOfTheMoon => 'Orbite de la Lune';

  @override
  String get settings_common_font_family_restart => 'Redémarrer';

  @override
  String get settings_common_font_family_overcome => 'Surmonter';

  @override
  String get settings_common_font_family_system => 'Police système';

  @override
  String get settings_data_title => 'Données';

  @override
  String get settings_data_auto_sync_title => 'Synchronisation automatique';

  @override
  String get settings_data_auto_sync_subtitle =>
      'Synchroniser automatiquement les données.';

  @override
  String get settings_data_backup_title => 'Sauvegarde des données';

  @override
  String get settings_data_backup_subtitle => 'Sauvegarder les données.';

  @override
  String get settings_data_backup_confirm =>
      'Voulez-vous sauvegarder les données ?';

  @override
  String get settings_data_backup_confirm_ok => 'Sauvegarder';

  @override
  String get settings_data_cache_cleanup_title => 'Nettoyer le cache';

  @override
  String get settings_data_cache_cleanup_subtitle =>
      'Supprimer les fichiers temporaires.';

  @override
  String get settings_data_cache_cleanup_confirm =>
      'Voulez-vous supprimer le cache ?\nCette action ne peut pas être annulée.';

  @override
  String get settings_ai_personality_changed =>
      'La personnalité de l\'IA a été changée.';

  @override
  String get settings_information_title => 'Informations';

  @override
  String get settings_information_app_title => 'Informations de l\'application';

  @override
  String get settings_information_app_subtitle =>
      'Informations sur la version et la licence';

  @override
  String get settings_information_app_version => 'Version';

  @override
  String get settings_information_app_build => 'Licence';

  @override
  String get settings_information_app_developer => 'Développeur';

  @override
  String get settings_information_faq_title => 'Aide';

  @override
  String get settings_information_faq_subtitle => 'Utilisation et FAQ';

  @override
  String get settings_information_qna_title => 'Contact';

  @override
  String get settings_information_qna_subtitle => 'Contacter le développeur.';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_account_title => 'Informations d\'inscription';

  @override
  String get profile_nickname_title => 'Changer le surnom';

  @override
  String get profile_nickname_hint => 'Veuillez entrer un nouveau surnom.';

  @override
  String get profile_creation_time_title => 'Date d\'inscription';

  @override
  String get profile_uid_title => 'ID utilisateur';

  @override
  String get profile_button_login => 'Aller à la connexion';

  @override
  String get profile_button_logout => 'Déconnexion';

  @override
  String get write_ai_limit_reached =>
      'Les réponses IA sont limitées à une fois par jour. Réessayez demain !';

  @override
  String get write_timestamp_add => 'Ajouter l\'heure';

  @override
  String get write_location_add => 'Ajouter la localisation';

  @override
  String get common_language_korean => 'Coréen';

  @override
  String get common_language_english => 'English';

  @override
  String get common_language_japanese => 'Japonais';

  @override
  String get common_language_chinese => 'Chinois';

  @override
  String get common_language_spanish => 'Espagnol';

  @override
  String get common_language_italian => 'Italien';

  @override
  String get common_language_french => 'Français';

  @override
  String get common_language_vietnamese => 'Vietnamien';

  @override
  String get common_language_thai => 'Thaïlandais';

  @override
  String get common_developing => 'En développement';

  @override
  String get settings_user_info_title => 'Informations de connexion';

  @override
  String get settings_user_info_empty => 'Aucune information de connexion.';

  @override
  String get settings_user_info_status => 'Statut';

  @override
  String get settings_user_info_anonymous => 'Connexion anonyme';

  @override
  String get settings_user_info_logged_in => 'Connecté';

  @override
  String get dialog_storage_init_title => 'Initialisation du stockage';

  @override
  String get dialog_storage_init_content => 'Initialiser SharedPreferences.';

  @override
  String get dialog_database_init_title =>
      'Initialisation de la base de données';

  @override
  String get dialog_database_init_content =>
      'Initialiser la base de données SQLite.';

  @override
  String get dialog_init_button => 'Initialiser';

  @override
  String get settings_developer_options => 'Options développeur';

  @override
  String get settings_developer_mode_only => 'Mode développement uniquement';

  @override
  String get settings_ai_section_title => 'Paramètres IA';

  @override
  String get settings_ai_personality_title => 'Personnalité IA';

  @override
  String get snackbar_backup_completed => 'Sauvegarde terminée.';

  @override
  String get snackbar_cache_cleared => 'Cache supprimé.';
}
