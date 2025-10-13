import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/domain/entities/app/settings.dart';
import 'package:moodlog/domain/repositories/settings_repository.dart';

class AppStateProvider extends ChangeNotifier with AsyncStateMixin {
  final SettingsRepository _settingsRepository;

  AppStateProvider({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository;

  Settings _appState = const Settings();
  bool _isAuthenticated = false;

  Settings get appState => _appState;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> loadSettings() async {
    setLoading();
    try {
      _appState = await _settingsRepository.loadSettings();
      setSuccess();
    } catch (e) {
      setError(Exception('Failed to load settings'));
    }
  }

  Future<void> update(Settings settings) async {
    setLoading();
    try {
      _appState = await _settingsRepository.updateSettings(settings);
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
