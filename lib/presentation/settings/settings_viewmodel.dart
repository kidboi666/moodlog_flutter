import 'package:flutter/material.dart' hide ThemeMode;
import 'package:moodlog/domain/entities/tag.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';

import '../../core/constants/enum.dart';
import '../../core/utils/result.dart';
import '../../data/repositories/analytics_repository_impl.dart';
import '../../domain/entities/settings.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/journal_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../presentation/providers/app_state_provider.dart';
import '../providers/user_provider.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppStateProvider _appStateProvider;
  final SettingsRepository _settingsRepository;
  final JournalRepository _journalRepository;
  final UserProvider _userProvider;
  final TagUseCase _tagUseCase;

  SettingsViewModel({
    required AppStateProvider appStateProvider,
    required SettingsRepository settingsRepository,
    required JournalRepository journalRepository,
    required UserProvider userProvider,
    required TagUseCase tagUseCase,
  }) : _appStateProvider = appStateProvider,
       _settingsRepository = settingsRepository,
       _journalRepository = journalRepository,
       _userProvider = userProvider,
       _tagUseCase = tagUseCase {
    getAllTags();
  }

  String _appVersion = '';
  String _appBuild = '';
  bool _isLoading = false;
  List<Tag> _tags = [];

  List<Tag> get tags => _tags;

  String get appVersion => _appVersion;

  String get appBuild => _appBuild;

  String? get profileImage => _userProvider.user?.photoURL;

  bool get isLoading => _isLoading;

  Settings get appState => _appStateProvider.appState;

  User? get currentUser => _userProvider.user;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void getAllTags() async {
    setLoading(true);
    final result = await _tagUseCase.getAllTags();

    switch (result) {
      case Ok<List<Tag>>():
        _tags = result.value;
        setLoading(false);
        break;
      case Failure<List<Tag>>():
        setLoading(false);
        break;
    }
  }

  void deleteTag(int id) async {
    setLoading(true);
    final result = await _tagUseCase.deleteTag(id);
    switch (result) {
      case Ok<void>():
        getAllTags();
        setLoading(false);
        break;
      case Failure<void>():
        setLoading(false);
        break;
    }
  }

  void setLanguage(LanguageCode? language) {
    _appStateProvider.updateLanguage(language!);
    AnalyticsRepositoryImpl().logSettingsChange(
      settingType: 'language',
      value: language.value,
    );
  }

  void setNotificationEnabled(bool enabled) {
    _appStateProvider.updateNotificationEnabled(enabled);
  }

  void setAutoSyncEnabled(bool enabled) {
    _appStateProvider.updateAutoSyncEnabled(enabled);
  }

  void setTheme(ThemeMode? theme) {
    _appStateProvider.updateThemeMode(theme!);
    AnalyticsRepositoryImpl().logSettingsChange(
      settingType: 'theme',
      value: theme.name,
    );
  }

  void setColorTheme(ColorTheme? colorTheme) {
    _appStateProvider.updateColorTheme(colorTheme!);
    AnalyticsRepositoryImpl().logSettingsChange(
      settingType: 'color_theme',
      value: colorTheme.name,
    );
  }

  void setFontFamily(FontFamily? fontType) {
    _appStateProvider.updateFontFamily(fontType!);
  }

  void setAiPersonality(AiPersonality personality) {
    _appStateProvider.updateAiPersonality(personality);
  }

  void performBackup() {
    // TODO: 백업 기능
  }

  void clearCache() {
    _journalRepository.clearCache();
  }

  void clearSharedPreferences() {
    _settingsRepository.clearSharedPreferences();
    notifyListeners();
  }

  Future<void> loadAppInfo() async {
    final appInfo = await _settingsRepository.getAppInfo();
    _appVersion = appInfo.version;
    _appBuild = appInfo.buildNumber;
    notifyListeners();
  }
}
