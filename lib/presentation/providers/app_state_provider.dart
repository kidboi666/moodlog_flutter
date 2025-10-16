import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/domain/entities/app/settings.dart';
import 'package:moodlog/domain/repositories/settings_repository.dart';
import 'package:moodlog/domain/use_cases/gemini_use_case.dart';

class AppStateProvider extends ChangeNotifier with AsyncStateMixin {
  final SettingsRepository _settingsRepository;
  final GeminiUseCase _geminiUseCase;

  AppStateProvider({
    required SettingsRepository settingsRepository,
    required GeminiUseCase geminiUseCase,
  }) : _settingsRepository = settingsRepository,
       _geminiUseCase = geminiUseCase;

  Settings _appState = const Settings();
  bool _isAuthenticated = false;

  Settings get appState => _appState;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> loadSettings() async {
    setLoading();
    try {
      _appState = await _settingsRepository.loadSettings();
      await _geminiUseCase.initialize(_appState.aiPersonality);
      setSuccess();
    } catch (e) {
      setError(Exception('Failed to load settings'));
    }
  }

  Future<void> update(Settings settings) async {
    setLoading();
    try {
      final oldPersonality = _appState.aiPersonality;
      _appState = await _settingsRepository.updateSettings(settings);
      if (oldPersonality != _appState.aiPersonality) {
        await _geminiUseCase.initialize(_appState.aiPersonality);
      }
      setSuccess();
    } catch (e) {
      setError(Exception('Failed to update settings'));
    }
  }

  void setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}
