import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../domain/entities/settings.dart';
import '../../domain/repositories/app_state_repository.dart';
import '../constants/enum.dart';
import '../mixins/async_state_mixin.dart';

class AppStateProvider extends ChangeNotifier with AsyncStateMixin {
  final SettingsRepository _settingsRepository;

  AppStateProvider({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository {
    loadSettings();
  }

  final Logger _log = Logger('AppStateProvider');
  Settings? _appState;

  Settings get appState {
    if (isLoading && _appState != null) {
      return _appState!;
    }
    return _appState ?? Settings();
  }

  Future<void> loadSettings() async {
    _log.info('Starting to load settings from SharedPreferences');
    setLoading();
    try {
      _log.info('Fetching individual settings...');
      final results = await Future.wait([
        _settingsRepository.getThemeMode(),
        _settingsRepository.getLanguageCode(),
        _settingsRepository.getAiPersonality(),
        _settingsRepository.getHasNotificationEnabled(),
        _settingsRepository.getHasAutoSyncEnabled(),
        _settingsRepository.getColorTheme(),
        _settingsRepository.getFontFamily(),
        _settingsRepository.getOnboardedLoginTypes(),
      ]);
      print('results: ${results[5]}');

      _appState = Settings(
        themeMode: results[0] as ThemeMode,
        languageCode: results[1] as LanguageCode,
        aiPersonality: results[2] as AiPersonality,
        hasNotificationEnabled: results[3] as bool,
        hasAutoSyncEnabled: results[4] as bool,
        colorTheme: results[5] as ColorTheme,
        fontFamily: results[6] as FontFamily,
        onboardedLoginTypes: results[7] as List<String>?,
      );
      _log.info(
        'Successfully loaded settings from SharedPreferences: $_appState',
      );
      print(_appState?.colorTheme);
      setSuccess();
    } catch (e) {
      _log.severe('Failed to load settings: $e');
      setError(e);
      if (_appState == null) {
        _appState = Settings();
        _log.warning('Using default settings due to error (no previous state)');
      } else {
        _log.warning('Keeping previous settings due to error');
      }
    } finally {}
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _settingsRepository.updateThemeMode(themeMode);
    _appState = _appState?.copyWith(themeMode: themeMode);
    notifyListeners();
  }

  Future<void> updateLanguage(LanguageCode languageCode) async {
    await _settingsRepository.updateLanguage(languageCode);
    _appState = _appState?.copyWith(languageCode: languageCode);
    notifyListeners();
  }

  Future<void> updateAiPersonality(AiPersonality aiPersonality) async {
    await _settingsRepository.updateAiPersonality(aiPersonality);
    _appState = _appState?.copyWith(aiPersonality: aiPersonality);
    notifyListeners();
  }

  Future<void> updateNotificationEnabled(bool hasNotificationEnabled) async {
    await _settingsRepository.updateNotificationEnabled(hasNotificationEnabled);
    _appState = _appState?.copyWith(
      hasNotificationEnabled: hasNotificationEnabled,
    );
    notifyListeners();
  }

  Future<void> updateAutoSyncEnabled(bool hasAutoSyncEnabled) async {
    await _settingsRepository.updateAutoSyncEnabled(hasAutoSyncEnabled);
    _appState = _appState?.copyWith(hasAutoSyncEnabled: hasAutoSyncEnabled);
    notifyListeners();
  }

  Future<void> updateColorTheme(ColorTheme colorTheme) async {
    await _settingsRepository.updateColorTheme(colorTheme);
    _appState = _appState?.copyWith(colorTheme: colorTheme);
    notifyListeners();
  }

  Future<void> updateFontFamily(FontFamily fontFamily) async {
    await _settingsRepository.updateFontFamily(fontFamily);
    _appState = _appState?.copyWith(fontFamily: fontFamily);
    notifyListeners();
  }

  Future<void> updateOnboardedLoginTypes(LoginType loginType) async {
    await _settingsRepository.updateOnboardedLoginTypes(loginType);
    List<String>? onboardingCompletedList = _appState?.onboardedLoginTypes;
    if (onboardingCompletedList == null) {
      _appState = _appState?.copyWith(onboardedLoginTypes: [loginType.value]);
    } else {
      onboardingCompletedList.add(loginType.value);
      _appState = _appState?.copyWith(
        onboardedLoginTypes: onboardingCompletedList,
      );
    }
    notifyListeners();
  }
}
