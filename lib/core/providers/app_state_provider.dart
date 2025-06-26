import 'package:flutter/material.dart';

import '../../domain/entities/app_state.dart';
import '../../domain/repositories/app_state_repository.dart';

class AppStateProvider extends ChangeNotifier {
  final AppStateRepository _appStateRepository;

  AppStateProvider({required AppStateRepository appStateRepository})
    : _appStateRepository = appStateRepository {
    _load();
  }

  AppState? _appState;
  bool _isOnboardingCompleted = false;

  AppState? get appState => _appState;

  bool get isOnboardingCompleted => _isOnboardingCompleted;

  void _load() async {
    final result = await _appStateRepository.getAppState();
    _appState = result;
    notifyListeners();
  }

  void completeOnboarding() {
    _isOnboardingCompleted = true;
    notifyListeners();
  }
}
