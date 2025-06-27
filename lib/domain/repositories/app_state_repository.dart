import 'package:flutter/foundation.dart';

import '../../core/constants/enum.dart';
import '../entities/app_state.dart';

abstract class AppStateRepository extends ChangeNotifier {
  AppState get appState;

  Future<void> init({
    required String nickname,
    required AiPersonality aiPersonality,
  });

  Future<void> setFirstLaunchComplete();

  Future<void> updateThemeMode(String themeMode);

  Future<void> updateLanguage(String languageCode);

  Future<void> updateNickname(String nickname);
}
