import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../domain/entities/app_state.dart';
import '../../../domain/repositories/app_state_repository.dart';

class OnboardingViewModel extends ChangeNotifier {
  final int totalSteps;
  final AppStateRepository _appStateRepository;

  OnboardingViewModel({
    required this.totalSteps,
    required AppStateRepository appStateRepository,
  }) : _appStateRepository = appStateRepository;

  final Logger _log = Logger('OnboardingViewModel');
  int _currentStep = 0;
  bool _isLastStep = false;
  AiPersonality _selectedPersonality = AiPersonality.balanced;
  String _nickname = '';

  String get nickname => _nickname;

  AppState get appState => _appStateRepository.appState;

  AiPersonality get selectedPersonality => _selectedPersonality;

  int get currentStep => _currentStep;

  bool get isLastStep => _isLastStep;

  void setStep(int step) {
    final safeStep = step.clamp(0, totalSteps - 1);

    _currentStep = safeStep;
    _isLastStep = safeStep == totalSteps - 1;
    _log.info('Setting step to $safeStep');
    notifyListeners();
  }

  void setPersonality(AiPersonality personality) {
    _selectedPersonality = personality;
    _log.info('Setting personality to $personality');
    notifyListeners();
  }

  void setNickname(String value) {
    _nickname = value;
    _log.info('Setting nickname to $value');
    notifyListeners();
  }

  bool validateNickname(String? value) => value != null && value.isNotEmpty;

  void init() {
    _log.info('Initializing $_nickname with personality $_selectedPersonality');
    _appStateRepository.init(
      nickname: _nickname,
      aiPersonality: _selectedPersonality,
    );
  }
}
