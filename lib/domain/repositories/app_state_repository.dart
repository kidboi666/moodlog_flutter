import 'package:flutter/foundation.dart';

import '../../core/constants/enum.dart';

abstract class SettingsRepository extends ChangeNotifier {
  Future<ThemeMode> getThemeMode();

  Future<LanguageCode> getLanguageCode();

  Future<AiPersonality> getAiPersonality();

  Future<bool> getHasNotificationEnabled();

  Future<bool> getHasAutoSyncEnabled();

  Future<ColorTheme> getColorTheme();

  Future<FontFamily> getFontFamily();

  Future<void> updateAiPersonality(AiPersonality aiPersonality);

  Future<void> updateThemeMode(ThemeMode themeMode);

  Future<void> updateLanguage(LanguageCode languageCode);

  Future<void> updateNotificationEnabled(bool enabled);

  Future<void> updateAutoSyncEnabled(bool enabled);

  Future<void> updateColorTheme(ColorTheme colorTheme);

  Future<void> updateFontFamily(FontFamily fontType);

  Future<void> clearSharedPreferences();
}
