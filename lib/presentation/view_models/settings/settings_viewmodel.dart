import 'package:flutter/material.dart' hide ThemeMode;
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../domain/entities/app_state.dart';
import '../../../domain/repositories/app_state_repository.dart';
import '../../views/settings/widgets/language_dialog.dart';
import '../../views/settings/widgets/theme_dialog.dart';

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

  Future<void> showLanguageDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => LanguageDialog(viewModel: this),
    );
  }

  Future<void> showThemeDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => ThemeDialog(viewModel: this),
    );
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
}
