import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/mixins/step_mixin.dart';

import '../../../core/constants/enum.dart';
import '../../../domain/entities/app_state.dart';
import '../../../domain/repositories/app_state_repository.dart';

class OnboardingViewModel extends ChangeNotifier with StepMixin {
  final AppStateRepository _appStateRepository;

  OnboardingViewModel({
    required int totalSteps,
    required AppStateRepository appStateRepository,
  }) : _appStateRepository = appStateRepository {
    initStep(totalSteps);
  }

  final Logger _log = Logger('OnboardingViewModel');
  AiPersonality _selectedPersonality = AiPersonality.balanced;
  String _nickname = '';

  String get nickname => _nickname;

  AppState get appState => _appStateRepository.appState;

  AiPersonality get selectedPersonality => _selectedPersonality;

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
