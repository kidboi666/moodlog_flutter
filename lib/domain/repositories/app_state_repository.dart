import 'package:flutter/foundation.dart';

import '../../core/constants/enum.dart';
import '../entities/app_state.dart';

abstract class AppStateRepository extends ChangeNotifier {
  AppState get appState;

  Future<void> load();

  Future<void> init({required AiPersonality aiPersonality});

  Future<void> updateThemeMode(ThemeMode themeMode);

  Future<void> updateLanguage(LanguageCode languageCode);

  Future<void> updateNotificationEnabled(bool enabled);

  Future<void> updateAutoSyncEnabled(bool enabled);

  Future<void> updateColorTheme(ColorTheme colorTheme);

  Future<void> updateFontFamily(FontFamily fontType);

  Future<void> clearSharedPreferences();
}
