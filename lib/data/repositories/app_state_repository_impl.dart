import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../core/extensions/enum.dart';
import '../../domain/entities/app_state.dart';
import '../../domain/repositories/app_state_repository.dart';

class AppStateRepositoryImpl extends AppStateRepository {
  final SharedPreferencesAsync _prefs;

  AppStateRepositoryImpl({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  AppState _appState = const AppState();
  bool _isLoading = true;

  @override
  bool get isLoading => _isLoading;

  @override
  AppState get appState => _appState;

  Future<void> _initLoad() async {
    _isLoading = true;
    notifyListeners();

    final isFirstLaunch =
        await _prefs.getBool(PreferenceKeys.isFirstLaunch) ?? true;
    final themeModeString = await _prefs.getString(PreferenceKeys.themeMode);
    final themeMode = ThemeModeExtension.fromString(themeModeString);
    final languageCodeString = await _prefs.getString(
      PreferenceKeys.languageCode,
    );
    final languageCode = LanguageCodeExtension.fromString(languageCodeString);
    final lastActiveDateString = await _prefs.getString(
      PreferenceKeys.lastActiveDate,
    );
    final lastActiveDate = DateTime.tryParse(lastActiveDateString ?? '');
    final firstLaunchedDateString = await _prefs.getString(
      PreferenceKeys.firstLaunchedDate,
    );
    final firstLaunchedDate = DateTime.tryParse(firstLaunchedDateString ?? '');
    final nickname = await _prefs.getString(PreferenceKeys.nickname) ?? '';
    final aiPersonalityString = await _prefs.getString(
      PreferenceKeys.aiPersonality,
    );
    final aiPersonality = AiPersonalityExtension.fromString(
      aiPersonalityString,
    );
    final hasNotificationEnabled =
        await _prefs.getBool(PreferenceKeys.hasNotificationEnabled) ?? false;
    final hasAutoSyncEnabled =
        await _prefs.getBool(PreferenceKeys.hasAutoSyncEnabled) ?? false;
    final colorThemeString = await _prefs.getString(PreferenceKeys.colorTheme);
    final colorTheme = ColorTheme.fromString(colorThemeString);

    _appState = AppState(
      isFirstLaunch: isFirstLaunch,
      themeMode: themeMode,
      languageCode: languageCode,
      lastActiveDate: lastActiveDate,
      firstLaunchedDate: firstLaunchedDate,
      aiPersonality: aiPersonality,
      nickname: nickname,
      hasNotificationEnabled: hasNotificationEnabled,
      hasAutoSyncEnabled: hasAutoSyncEnabled,
      colorTheme: colorTheme,
    );
    _isLoading = false;
    notifyListeners();
  }

  @override
  Future<void> init({
    required String nickname,
    required AiPersonality aiPersonality,
  }) async {
    await _prefs.setString(PreferenceKeys.aiPersonality, aiPersonality.name);
    await _prefs.setString(PreferenceKeys.nickname, nickname);
    _initLoad();
  }

  void _updateState(AppState newState) {
    _appState = newState;
    notifyListeners();
  }

  @override
  Future<void> setFirstLaunchComplete() async {
    await _prefs.setBool(PreferenceKeys.isFirstLaunch, false);
    _updateState(_appState.copyWith(isFirstLaunch: false));
  }

  @override
  Future<void> updateLanguage(LanguageCode languageCode) async {
    await _prefs.setString(
      PreferenceKeys.languageCode,
      languageCode.toString(),
    );
    _updateState(_appState.copyWith(languageCode: languageCode));
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(PreferenceKeys.themeMode, themeMode.toString());
    _updateState(_appState.copyWith(themeMode: themeMode));
  }

  @override
  Future<void> updateFontFamily(FontFamily fontFamily) async {
    await _prefs.setString(PreferenceKeys.fontFamily, fontFamily.toString());
    _updateState(_appState.copyWith(fontFamily: fontFamily));
  }

  @override
  Future<void> updateColorTheme(ColorTheme colorTheme) async {
    await _prefs.setString(PreferenceKeys.colorTheme, colorTheme.toString());
    _updateState(_appState.copyWith(colorTheme: colorTheme));
  }

  @override
  Future<void> updateNickname(String nickname) async {
    await _prefs.setString(PreferenceKeys.nickname, nickname);
    _updateState(_appState.copyWith(nickname: nickname));
  }

  @override
  Future<void> updateNotificationEnabled(bool hasNotificationEnabled) async {
    await _prefs.setBool(
      PreferenceKeys.hasNotificationEnabled,
      hasNotificationEnabled,
    );
    _updateState(
      _appState.copyWith(hasNotificationEnabled: hasNotificationEnabled),
    );
  }

  @override
  Future<void> updateAutoSyncEnabled(bool hasAutoSyncEnabled) async {
    await _prefs.setBool(PreferenceKeys.hasAutoSyncEnabled, hasAutoSyncEnabled);
    _updateState(_appState.copyWith(hasAutoSyncEnabled: hasAutoSyncEnabled));
  }

  /// kDebugMode
  @override
  Future<void> clearSharedPreferences() async {
    if (kDebugMode) {
      await _prefs.clear();
      _initLoad();
    }
  }
}
