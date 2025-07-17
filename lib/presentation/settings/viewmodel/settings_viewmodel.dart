import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../domain/entities/settings.dart';
import '../../../domain/repositories/app_state_repository.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/journal_repository.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppStateProvider _appStateProvider;
  final SettingsRepository _settingsRepository;
  final JournalRepository _journalRepository;
  final AuthRepository _authRepository;

  SettingsViewModel({
    required AppStateProvider appStateProvider,
    required SettingsRepository settingsRepository,
    required JournalRepository journalRepository,
    required AuthRepository authRepository,
  }) : _appStateProvider = appStateProvider,
       _settingsRepository = settingsRepository,
       _journalRepository = journalRepository,
       _authRepository = authRepository;

  final Logger _log = Logger('SettingsViewModel');

  bool _isLoading = false;

  String? get profileImage => _authRepository.user?.photoURL;

  bool get isLoading => _isLoading;

  Settings get appState => _appStateProvider.appState;

  User? get currentUser => _authRepository.user;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setLanguage(LanguageCode? language) {
    _log.info('Setting language to $language');
    _appStateProvider.updateLanguage(language!);
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
    _appStateProvider.updateNotificationEnabled(enabled);
    notifyListeners();
  }

  void setAutoSyncEnabled(bool enabled) {
    _log.info('Setting auto sync enabled to $enabled');
    _appStateProvider.updateAutoSyncEnabled(enabled);
    notifyListeners();
  }

  void setTheme(ThemeMode? theme) {
    _log.info('Setting theme to $theme');
    _appStateProvider.updateThemeMode(theme!);
    notifyListeners();
  }

  void setColorTheme(ColorTheme? colorTheme) {
    _log.info('Setting color theme to $colorTheme');
    _appStateProvider.updateColorTheme(colorTheme!);
    notifyListeners();
  }

  void setFontFamily(FontFamily? fontType) {
    _log.info('Setting font type to $fontType');
    _appStateProvider.updateFontFamily(fontType!);
    notifyListeners();
  }

  void performBackup(BuildContext context) {
    // TODO 백업 로직 구현
    context.pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('백업이 완료되었습니다.')));
  }

  void signOut(BuildContext context) {
    _authRepository.signOut();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('로그아웃 되었습니다.')));
  }

  void clearCache(BuildContext context) {
    _journalRepository.clearCache();
    context.pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('캐시가 삭제되었습니다.')));
  }

  void clearSharedPreferences() {
    _settingsRepository.clearSharedPreferences();
    notifyListeners();
  }
}
