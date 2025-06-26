import '../entities/app_state.dart';

abstract class AppStateRepository {
  Future<AppState> getAppState();

  Future<void> setFirstLaunchComplete();

  Future<void> updateThemeMode(String themeMode);

  Future<void> updateLanguage(String languageCode);
}
