import 'package:flutter/material.dart' hide ThemeMode;
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../domain/entities/app_state.dart';
import '../../../domain/repositories/app_state_repository.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppStateRepository _appStateRepository;

  SettingsViewModel({required AppStateRepository appStateRepository})
    : _appStateRepository = appStateRepository;

  final Logger _log = Logger('SettingsViewModel');

  AppState get appState => _appStateRepository.appState;

  void setLanguage(LanguageCode? language) {
    _log.info('Setting language to $language');
    _appStateRepository.updateLanguage(language!);
    notifyListeners();
  }

  Future<void> showDialogWithWidget(BuildContext context, Widget child) async {
    return showDialog(context: context, builder: (context) => child);
  }

  void setNotificationEnabled(bool enabled) {
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

  void performBackup(BuildContext context) {
    // TODO 백업 로직 구현
    context.pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('백업이 완료되었습니다.')));
  }

  void clearCache(BuildContext context) {
    // TODO 캐시 삭제 로직 구현
    context.pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('캐시가 삭제되었습니다.')));
  }
}
