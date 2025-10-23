import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/use_cases/settings_use_case.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';

class LockViewModel extends ChangeNotifier {
  final SettingsUseCase _settingsUseCase;
  final AppStateProvider _appStateProvider;

  LockViewModel({
    required SettingsUseCase settingsUseCase,
    required AppStateProvider appStateProvider,
  })  : _settingsUseCase = settingsUseCase,
        _appStateProvider = appStateProvider;

  LockType get lockType => _appStateProvider.appState.lockType;

  Future<bool> hasPin() async {
    return await _settingsUseCase.hasPin();
  }

  Future<void> savePin(String pin) async {
    await _settingsUseCase.savePin(pin);
    _appStateProvider.setAuthenticated(true);
  }

  Future<bool> verifyPin(String pin) async {
    final isValid = await _settingsUseCase.verifyPin(pin);
    if (isValid) {
      _appStateProvider.setAuthenticated(true);
    }
    return isValid;
  }

  void setAuthenticated() {
    _appStateProvider.setAuthenticated(true);
  }
}
