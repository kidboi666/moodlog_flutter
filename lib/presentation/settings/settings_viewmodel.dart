import 'package:flutter/material.dart' hide ThemeMode;

import '../../core/constants/enum.dart';
import '../../core/utils/result.dart';
import '../../data/repositories/analytics_repository_impl.dart';
import '../../domain/entities/app/settings.dart';
import '../../domain/entities/journal/tag.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/use_cases/tag_use_case.dart';
import '../../presentation/providers/app_state_provider.dart';
import '../providers/user_provider.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppStateProvider _appStateProvider;
  final SettingsRepository _settingsRepository;
  final UserProvider _userProvider;
  final TagUseCase _tagUseCase;

  SettingsViewModel({
    required AppStateProvider appStateProvider,
    required SettingsRepository settingsRepository,
    required UserProvider userProvider,
    required TagUseCase tagUseCase,
  }) : _appStateProvider = appStateProvider,
       _settingsRepository = settingsRepository,
       _userProvider = userProvider,
       _tagUseCase = tagUseCase {
    getAllTags();
  }

  String _appVersion = '';
  String _appBuild = '';
  bool _isLoading = false;
  List<Tag> _tags = [];

  List<Tag> get tags => _tags;

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

  void getAllTags() async {
    setLoading(true);
    final result = await _tagUseCase.getAllTags();

    switch (result) {
      case Ok<List<Tag>>():
        _tags = result.value;
        setLoading(false);
        break;
      case Error<List<Tag>>():
        setLoading(false);
        break;
    }
  }

  void deleteTag(int id) async {
    setLoading(true);
    final result = await _tagUseCase.deleteTag(id);
    switch (result) {
      case Ok<void>():
        getAllTags();
        setLoading(false);
        break;
      case Error<void>():
        setLoading(false);
        break;
    }
  }

  void setLanguage(LanguageCode? language) {
    final updatedState = _appStateProvider.appState.copyWith(
      languageCode: language!,
    );
    _updateSettings(updatedState, 'language', language.name);
  }

  void setNotificationEnabled(bool enabled) {
    final updatedState = _appStateProvider.appState.copyWith(
      hasNotificationEnabled: enabled,
    );
    _updateSettings(updatedState, 'notification', enabled.toString());
  }

  void setAutoSyncEnabled(bool enabled) {
    final updatedState = _appStateProvider.appState.copyWith(
      hasAutoSyncEnabled: enabled,
    );
    _updateSettings(updatedState, 'auto_sync', enabled.toString());
  }

  void setTheme(ThemeMode? theme) {
    final updatedState = _appStateProvider.appState.copyWith(themeMode: theme!);
    _updateSettings(updatedState, 'theme', theme.name);
  }

  void setColorTheme(ColorTheme? colorTheme) {
    final updatedState = _appStateProvider.appState.copyWith(
      colorTheme: colorTheme!,
    );
    _updateSettings(updatedState, 'color_theme', colorTheme.name);
  }

  void setFontFamily(FontFamily? fontType) {
    final updatedState = _appStateProvider.appState.copyWith(
      fontFamily: fontType!,
    );
    _updateSettings(updatedState, 'font_family', fontType.name);
  }

  void setAiPersonality(AiPersonality personality) {
    final updatedState = _appStateProvider.appState.copyWith(
      aiPersonality: personality,
    );
    _updateSettings(updatedState, 'ai_personality', personality.name);
  }

  void _updateSettings(Settings newSettings, String settingType, String value) {
    _settingsRepository.updateSettings(newSettings);
    AnalyticsRepositoryImpl().logSettingsChange(
      settingType: settingType,
      value: value,
    );
  }

  void performBackup() {
    // TODO: 백업 기능
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
