import 'package:flutter/foundation.dart';

import '../../core/mixins/async_state_mixin.dart';
import '../../domain/entities/app/settings.dart';
import '../../domain/repositories/settings_repository.dart';

class AppStateProvider extends ChangeNotifier with AsyncStateMixin {
  final SettingsRepository _settingsRepository;

  AppStateProvider({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository {
    load();
  }

  Settings? _appState;

  Settings get appState {
    if (isLoading && _appState != null) {
      return _appState!;
    }
    return _appState ?? Settings();
  }

  Future<void> load() async {
    setLoading();
    try {
      final settings = await _settingsRepository.loadSettings();
      _appState = settings;
      setSuccess();
    } catch (e) {
      setError(e);
      _appState = Settings();
    }
  }

  Future<void> update(Settings settings) async {
    setLoading();
    try {
      await _settingsRepository.updateSettings(settings);
      _appState = settings;
      setSuccess();
    } catch (e) {
      setError(e);
    }
  }
}
