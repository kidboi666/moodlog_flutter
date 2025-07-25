import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:go_router/go_router.dart';

import '../../../core/constants/enum.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../domain/entities/settings.dart';
import '../../../domain/repositories/app_state_repository.dart';
import '../../../domain/repositories/journal_repository.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppStateProvider _appStateProvider;
  final SettingsRepository _settingsRepository;
  final JournalRepository _journalRepository;
  final UserProvider _userProvider;

  SettingsViewModel({
    required AppStateProvider appStateProvider,
    required SettingsRepository settingsRepository,
    required JournalRepository journalRepository,
    required UserProvider userProvider,
  }) : _appStateProvider = appStateProvider,
       _settingsRepository = settingsRepository,
       _journalRepository = journalRepository,
       _userProvider = userProvider;

  bool _isLoading = false;

  String? get profileImage => _userProvider.user?.photoURL;

  bool get isLoading => _isLoading;

  Settings get appState => _appStateProvider.appState;

  User? get currentUser => _userProvider.user;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setLanguage(LanguageCode? language) {
    _appStateProvider.updateLanguage(language!);
  }

  Future<void> showDialogWithWidget(BuildContext context, Widget child) async {
    return showDialog(context: context, builder: (context) => child);
  }

  void setNotificationEnabled(bool enabled) {
    _appStateProvider.updateNotificationEnabled(enabled);
  }

  void setAutoSyncEnabled(bool enabled) {
    _appStateProvider.updateAutoSyncEnabled(enabled);
  }

  void setTheme(ThemeMode? theme) {
    _appStateProvider.updateThemeMode(theme!);
  }

  void setColorTheme(ColorTheme? colorTheme) {
    _appStateProvider.updateColorTheme(colorTheme!);
  }

  void setFontFamily(FontFamily? fontType) {
    _appStateProvider.updateFontFamily(fontType!);
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
    _settingsRepository.clearSharedPreferences();
    notifyListeners();
  }
}
