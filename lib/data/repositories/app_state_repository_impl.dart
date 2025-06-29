import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../core/extensions/enum.dart';
import '../../domain/entities/app_state.dart';
import '../../domain/repositories/app_state_repository.dart';

class AppStateRepositoryImpl extends AppStateRepository {
  AppStateRepositoryImpl() {
    _load();
  }

  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();
  AppState? _appState = const AppState();
  bool _isLoading = true;

  @override
  bool get isLoading => _isLoading;

  @override
  AppState get appState {
    return _appState!;
  }

  Future<void> _load() async {
    _isLoading = true;
    notifyListeners();

    final isFirstLaunch =
        await _asyncPrefs.getBool(PreferenceKeys.isFirstLaunch) ?? true;
    final themeModeString = await _asyncPrefs.getString(
      PreferenceKeys.themeMode,
    );
    final themeMode = ThemeMode.fromString(themeModeString);
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
    );
    _isLoading = false;
    notifyListeners();
  }

  @override
  Future<void> init({
    required String nickname,
    required AiPersonality aiPersonality,
  }) async {
    await _asyncPrefs.setBool(PreferenceKeys.isFirstLaunch, false);
    await _asyncPrefs.setString(
      PreferenceKeys.aiPersonality,
      appState.aiPersonality.name,
    );
    await _asyncPrefs.setString(PreferenceKeys.nickname, appState.nickname);
    _load();
  }

  @override
  Future<void> setFirstLaunchComplete() async {
    await _asyncPrefs.setBool(PreferenceKeys.isFirstLaunch, false);
    _load();
  }

  @override
  Future<void> updateLanguage(LanguageCode languageCode) async {
    await _asyncPrefs.setString(
      PreferenceKeys.languageCode,
      languageCode.toString(),
    );
    _load();
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _asyncPrefs.setString(PreferenceKeys.themeMode, themeMode.toString());
    _load();
  }

  @override
  Future<void> updateNickname(String nickname) async {
    await _asyncPrefs.setString(PreferenceKeys.nickname, nickname);
    _load();
  }

  @override
  Future<void> updateNotificationEnabled(bool hasNotificationEnabled) async {
    await _asyncPrefs.setBool(
      PreferenceKeys.hasNotificationEnabled,
      hasNotificationEnabled,
    );
    _load();
  }

  @override
  Future<void> updateAutoSyncEnabled(bool hasAutoSyncEnabled) async {
    await _asyncPrefs.setBool(
      PreferenceKeys.hasAutoSyncEnabled,
      hasAutoSyncEnabled,
    );
    _load();
  }
}
