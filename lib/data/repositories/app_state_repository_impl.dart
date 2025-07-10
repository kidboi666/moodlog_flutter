import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../core/extensions/enum.dart';
import '../../domain/entities/app_state.dart';
import '../../domain/repositories/app_state_repository.dart';
import '../data_source/database.dart';

class AppStateRepositoryImpl extends AppStateRepository {
  final MoodLogDatabase _db;

  AppStateRepositoryImpl({required MoodLogDatabase? db}) : _db = db! {
    _initLoad();
  }

  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();
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
        await _asyncPrefs.getBool(PreferenceKeys.isFirstLaunch) ?? true;
    final themeModeString = await _asyncPrefs.getString(
      PreferenceKeys.themeMode,
    );
    final themeMode = ThemeModeExtension.fromString(themeModeString);
    final languageCodeString = await _asyncPrefs.getString(
      PreferenceKeys.languageCode,
    );
    final languageCode = LanguageCodeExtension.fromString(languageCodeString);
    final lastActiveDateString = await _asyncPrefs.getString(
      PreferenceKeys.lastActiveDate,
    );
    final lastActiveDate = DateTime.tryParse(lastActiveDateString ?? '');
    final firstLaunchedDateString = await _asyncPrefs.getString(
      PreferenceKeys.firstLaunchedDate,
    );
    final firstLaunchedDate = DateTime.tryParse(firstLaunchedDateString ?? '');
    final nickname = await _asyncPrefs.getString(PreferenceKeys.nickname) ?? '';
    final aiPersonalityString = await _asyncPrefs.getString(
      PreferenceKeys.aiPersonality,
    );
    final aiPersonality = AiPersonalityExtension.fromString(
      aiPersonalityString,
    );
    final hasNotificationEnabled =
        await _asyncPrefs.getBool(PreferenceKeys.hasNotificationEnabled) ??
        false;
    final hasAutoSyncEnabled =
        await _asyncPrefs.getBool(PreferenceKeys.hasAutoSyncEnabled) ?? false;
    final colorThemeString = await _asyncPrefs.getString(
      PreferenceKeys.colorTheme,
    );
    final colorTheme = ColorTheme.fromString(colorThemeString);

    _appState = AppState(
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
    await _asyncPrefs.setString(
      PreferenceKeys.aiPersonality,
      aiPersonality.name,
    );
    await _asyncPrefs.setString(PreferenceKeys.nickname, nickname);
    _initLoad();
  }

  void _updateState(AppState newState) {
    _appState = newState;
    notifyListeners();
  }

  @override
  Future<void> setFirstLaunchComplete() async {
    await _asyncPrefs.setBool(PreferenceKeys.isFirstLaunch, false);
    _updateState(_appState.copyWith(isFirstLaunch: false));
  }

  @override
  Future<void> updateLanguage(LanguageCode languageCode) async {
    await _asyncPrefs.setString(
      PreferenceKeys.languageCode,
      languageCode.toString(),
    );
    _updateState(_appState.copyWith(languageCode: languageCode));
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _asyncPrefs.setString(PreferenceKeys.themeMode, themeMode.toString());
    _updateState(_appState.copyWith(themeMode: themeMode));
  }

  @override
  Future<void> updateFontFamily(FontFamily fontFamily) async {
    await _asyncPrefs.setString(
      PreferenceKeys.fontFamily,
      fontFamily.toString(),
    );
    _updateState(_appState.copyWith(fontFamily: fontFamily));
  }

  @override
  Future<void> updateColorTheme(ColorTheme colorTheme) async {
    await _asyncPrefs.setString(
      PreferenceKeys.colorTheme,
      colorTheme.toString(),
    );
    _updateState(_appState.copyWith(colorTheme: colorTheme));
  }

  @override
  Future<void> updateNickname(String nickname) async {
    await _asyncPrefs.setString(PreferenceKeys.nickname, nickname);
    _updateState(_appState.copyWith(nickname: nickname));
  }

  @override
  Future<void> updateNotificationEnabled(bool hasNotificationEnabled) async {
    await _asyncPrefs.setBool(
      PreferenceKeys.hasNotificationEnabled,
      hasNotificationEnabled,
    );
    _updateState(
      _appState.copyWith(hasNotificationEnabled: hasNotificationEnabled),
    );
  }

  @override
  Future<void> updateAutoSyncEnabled(bool hasAutoSyncEnabled) async {
    await _asyncPrefs.setBool(
      PreferenceKeys.hasAutoSyncEnabled,
      hasAutoSyncEnabled,
    );
    _updateState(_appState.copyWith(hasAutoSyncEnabled: hasAutoSyncEnabled));
  }

  /// kDebugMode
  @override
  Future<void> clearSharedPreferences() async {
    if (kDebugMode) {
      await _asyncPrefs.clear();
      _initLoad();
    }
  }

  /// kDebugMode
  @override
  Future<void> clearDatabase() async {
    if (kDebugMode) {
      await _db.transaction(() async {
        for (final table in _db.allTables) {
          await _db.delete(table).go();
        }
      });
    }
  }
}
