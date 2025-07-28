import '../../core/constants/enum.dart';

abstract class SettingsRepository {
  Future<ThemeMode> getThemeMode();

  Future<LanguageCode> getLanguageCode();

  Future<AiPersonality> getAiPersonality();

  Future<bool> getHasNotificationEnabled();

  Future<bool> getHasAutoSyncEnabled();

  Future<ColorTheme> getColorTheme();

  Future<FontFamily> getFontFamily();

  Future<SimpleTextAlign> getTextAlign();

  Future<List<String>?> getOnboardedLoginTypes();

  Future<void> updateAiPersonality(AiPersonality aiPersonality);

  Future<void> updateThemeMode(ThemeMode themeMode);

  Future<void> updateLanguage(LanguageCode languageCode);

  Future<void> updateNotificationEnabled(bool enabled);

  Future<void> updateAutoSyncEnabled(bool enabled);

  Future<void> updateColorTheme(ColorTheme colorTheme);

  Future<void> updateFontFamily(FontFamily fontType);

  Future<void> updateTextAlign(SimpleTextAlign textAlign);

  Future<void> updateOnboardedLoginTypes(LoginType loginType);

  Future<DateTime?> getLastAiUsageDate();

  Future<void> updateLastAiUsageDate(DateTime date);

  Future<void> clearSharedPreferences();
}
