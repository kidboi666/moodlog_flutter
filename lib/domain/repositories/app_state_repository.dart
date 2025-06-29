import 'package:flutter/material.dart' hide ThemeMode;

import '../../core/constants/enum.dart';
import '../entities/app_state.dart';

abstract class AppStateRepository extends ChangeNotifier {
  AppState get appState;

  bool get isLoading;

  Future<void> init({
    required String nickname,
    required AiPersonality aiPersonality,
  });

  Future<void> setFirstLaunchComplete();

  Future<void> updateThemeMode(ThemeMode themeMode);

  Future<void> updateLanguage(LanguageCode languageCode);

  Future<void> updateNickname(String nickname);

  Future<void> updateNotificationEnabled(bool enabled);

  Future<void> updateAutoSyncEnabled(bool enabled);
}
