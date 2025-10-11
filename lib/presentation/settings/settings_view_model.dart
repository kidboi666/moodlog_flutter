import 'package:flutter/material.dart' hide ThemeMode;

import '../../core/constants/enum.dart';
import '../../core/mixins/async_state_mixin.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/app/settings.dart';
import '../../domain/entities/journal/tag.dart';
import '../../domain/entities/user/local_user.dart';
import '../../domain/repositories/analytics_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/use_cases/tag_use_case.dart';
import '../../presentation/providers/app_state_provider.dart';
import '../providers/user_provider.dart';

class SettingsViewModel extends ChangeNotifier with AsyncStateMixin {
  final AppStateProvider _appStateProvider;
  final SettingsRepository _settingsRepository;
  final UserProvider _userProvider;
  final TagUseCase _tagUseCase;
  final AnalyticsRepository _analyticsRepository;

  SettingsViewModel({
    required AppStateProvider appStateProvider,
    required SettingsRepository settingsRepository,
    required UserProvider userProvider,
    required TagUseCase tagUseCase,
    required AnalyticsRepository analyticsRepository,
  }) : _appStateProvider = appStateProvider,
       _settingsRepository = settingsRepository,
       _userProvider = userProvider,
       _tagUseCase = tagUseCase,
       _analyticsRepository = analyticsRepository {
    getAllTags();
  }

  String _appVersion = '';
  String _appBuild = '';
  List<Tag> _tags = [];

  List<Tag> get tags => _tags;

  String get appVersion => _appVersion;

  String get appBuild => _appBuild;

  String? get profileImage => _userProvider.user?.profileImagePath;

  Settings get appState => _appStateProvider.appState;

  LocalUser? get currentUser => _userProvider.user;

  void getAllTags() async {
    final result = await executeAsync(() async {
      final result = await _tagUseCase.getAllTags();
      switch (result) {
        case Ok<List<Tag>>():
          return result.value;
        case Error<List<Tag>>():
          throw result.error;
      }
    }, context: 'getAllTags');

    if (result != null) {
      _tags = result;
    }
  }

  Future<void> deleteTag(int id) async {
    await executeAsync(() async {
      final result = await _tagUseCase.deleteTag(id);
      switch (result) {
        case Ok<void>():
          getAllTags(); // 태그 목록 새로고침
          return;
        case Error<void>():
          throw result.error;
      }
    }, context: 'deleteTag');
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

  Future<void> _updateSettings(
    Settings newSettings,
    String settingType,
    String value,
  ) async {
    await executeAsync(() async {
      await _appStateProvider.update(newSettings);
      _analyticsRepository.logSettingsChange(
        settingType: settingType,
        value: value,
      );
    }, context: 'updateSettings');
  }

  void performBackup() {
    // TODO: 백업 기능
  }

  void clearSharedPreferences() {
    _settingsRepository.clearSharedPreferences();
    notifyListeners();
  }

  Future<void> loadAppInfo() async {
    final result = await executeAsync(() async {
      final appInfo = await _settingsRepository.getAppInfo();
      return appInfo;
    }, context: 'loadAppInfo');

    if (result != null) {
      _appVersion = result.version;
      _appBuild = result.buildNumber;
    }
  }
}
