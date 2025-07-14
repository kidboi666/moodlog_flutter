import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/domain/repositories/auth_repository.dart';

import '../../../core/constants/enum.dart';
import '../../../domain/entities/app_state.dart';
import '../../../domain/repositories/app_state_repository.dart';
import '../../../domain/repositories/journal_repository.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppStateRepository _appStateRepository;
  final JournalRepository _journalRepository;
  final AuthRepository _authRepository;

  SettingsViewModel({
    required AppStateRepository appStateRepository,
    required JournalRepository journalRepository,
    required AuthRepository authRepository,
  }) : _appStateRepository = appStateRepository,
       _journalRepository = journalRepository,
       _authRepository = authRepository;

  final Logger _log = Logger('SettingsViewModel');

  AppState get appState => _appStateRepository.appState;

  User? get currentUser => _authRepository.currentUser;

  void setLanguage(LanguageCode? language) {
    _log.info('Setting language to $language');
    _appStateRepository.updateLanguage(language!);
    notifyListeners();
  }

  Future<void> showDialogWithWidget(BuildContext context, Widget child) async {
    return showDialog(context: context, builder: (context) => child);
  }

  void setNotificationEnabled(bool enabled) {
    if (enabled == appState.hasNotificationEnabled) {
      return;
    }
    _log.info('Setting notification enabled to $enabled');
    _appStateRepository.updateNotificationEnabled(enabled);
    notifyListeners();
  }

  void setAutoSyncEnabled(bool enabled) {
    _log.info('Setting auto sync enabled to $enabled');
    _appStateRepository.updateAutoSyncEnabled(enabled);
    notifyListeners();
  }

  void setTheme(ThemeMode? theme) {
    _log.info('Setting theme to $theme');
    _appStateRepository.updateThemeMode(theme!);
    notifyListeners();
  }

  void setColorTheme(ColorTheme? colorTheme) {
    _log.info('Setting color theme to $colorTheme');
    _appStateRepository.updateColorTheme(colorTheme!);
    notifyListeners();
  }

  void setFontFamily(FontFamily? fontType) {
    _log.info('Setting font type to $fontType');
    _appStateRepository.updateFontFamily(fontType!);
    notifyListeners();
  }

  void performBackup(BuildContext context) {
    // TODO 백업 로직 구현
    context.pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('백업이 완료되었습니다.')));
  }

  void clearCache(BuildContext context) {
    _journalRepository.clearCache();
    context.pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('캐시가 삭제되었습니다.')));
  }

  void clearSharedPreferences() {
    _appStateRepository.clearSharedPreferences();
    notifyListeners();
  }

  void clearDatabase() {
    _appStateRepository.clearDatabase();
    notifyListeners();
  }
}
