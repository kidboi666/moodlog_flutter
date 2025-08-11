import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide ThemeMode;

import '../../core/constants/enum.dart';
import '../../core/providers/app_state_provider.dart';
import '../../core/providers/user_provider.dart';
import '../../data/repositories/analytics_repository_impl.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/app_state_repository.dart';
import '../../domain/repositories/journal_repository.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppStateProvider _appStateProvider;
  final SettingsRepository _settingsRepository;
  final JournalRepository _journalRepository;
  final UserProvider _userProvider;

  SettingsViewModel({
    required AppStateProvider appStateProvider,
    required SettingsRepository settingsRepository,
    required JournalRepository journalRepository,
    required UserProvider userProvider,
  }) : _appStateProvider = appStateProvider,
       _settingsRepository = settingsRepository,
       _journalRepository = journalRepository,
       _userProvider = userProvider;

  String _appVersion = '';
  String _appBuild = '';
  bool _isLoading = false;

  String get appVersion => _appVersion;
  String get appBuild => _appBuild;
  String? get profileImage => _userProvider.user?.photoURL;
  bool get isLoading => _isLoading;
  Settings get appState => _appStateProvider.appState;
  User? get currentUser => _userProvider.user;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setLanguage(LanguageCode? language) {
    _appStateProvider.updateLanguage(language!);
    AnalyticsRepositoryImpl().logSettingsChange(
      settingType: 'language',
      value: language.value,
    );
  }

  void setNotificationEnabled(bool enabled) {
    _appStateProvider.updateNotificationEnabled(enabled);
  }

  void setAutoSyncEnabled(bool enabled) {
    _appStateProvider.updateAutoSyncEnabled(enabled);
  }

  void setTheme(ThemeMode? theme) {
    _appStateProvider.updateThemeMode(theme!);
    AnalyticsRepositoryImpl().logSettingsChange(
      settingType: 'theme',
      value: theme.name,
    );
  }

  void setColorTheme(ColorTheme? colorTheme) {
    _appStateProvider.updateColorTheme(colorTheme!);
    AnalyticsRepositoryImpl().logSettingsChange(
      settingType: 'color_theme',
      value: colorTheme.name,
    );
  }

  void setFontFamily(FontFamily? fontType) {
    _appStateProvider.updateFontFamily(fontType!);
  }

  void setAiPersonality(AiPersonality personality) {
    _appStateProvider.updateAiPersonality(personality);
  }

  void performBackup() {
    // TODO: 백업 기능
  }

  void clearCache() {
    _journalRepository.clearCache();
  }

  void clearSharedPreferences() {
    _settingsRepository.clearSharedPreferences();
    notifyListeners();
  }

  Future<void> loadAppInfo() async {
    final appInfo = await _settingsRepository.getAppInfo();
    _appVersion = appInfo.version;
    _appBuild = appInfo.buildNumber;
    notifyListeners();
  }
}
