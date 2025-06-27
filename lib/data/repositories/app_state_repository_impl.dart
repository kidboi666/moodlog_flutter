import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/common.dart';
import '../../domain/entities/app_state.dart';
import '../../domain/repositories/app_state_repository.dart';

class AppStateRepositoryImpl implements AppStateRepository {
  AppStateRepositoryImpl();

  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  @override
  Future<AppState> getAppState() async {
    final isFirstLaunch =
        await _asyncPrefs.getBool(PreferenceKeys.isFirstLaunch) ?? true;
    final themeMode =
        await _asyncPrefs.getString(PreferenceKeys.themeMode) ??
        ThemeMode.system;
    final languageCode =
        await _asyncPrefs.getString(PreferenceKeys.languageCode) ??
        LanguageCode.ko;
    final lastActiveDate =
        await _asyncPrefs.getString(PreferenceKeys.lastActiveDate) ??
        DateTime.now();
    final firstLaunchedDate =
        await _asyncPrefs.getString(PreferenceKeys.firstLaunchedDate) ??
        DateTime.now();
    final nickname = await _asyncPrefs.getString(PreferenceKeys.nickname) ?? '';

    return AppState(
      isFirstLaunch: isFirstLaunch,
      themeMode: themeMode as ThemeMode,
      languageCode: languageCode as LanguageCode,
      lastActiveDate: lastActiveDate as DateTime,
      firstLaunchedDate: firstLaunchedDate as DateTime,
      nickname: nickname,
    );
  }

  @override
  Future<void> setFirstLaunchComplete() async {
    await _asyncPrefs.setBool(PreferenceKeys.isFirstLaunch, false);
  }

  @override
  Future<void> updateLanguage(String languageCode) async {
    await _asyncPrefs.setString(PreferenceKeys.languageCode, languageCode);
  }

  @override
  Future<void> updateThemeMode(String themeMode) async {
    await _asyncPrefs.setString(PreferenceKeys.themeMode, themeMode);
  }

  @override
  Future<void> updateNickname(String nickname) async {
    await _asyncPrefs.setString(PreferenceKeys.nickname, nickname);
  }
}
