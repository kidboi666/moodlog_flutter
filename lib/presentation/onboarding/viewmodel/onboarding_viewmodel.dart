import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../core/mixins/step_mixin.dart';
import '../../../domain/entities/app_state.dart';
import '../../../domain/repositories/app_state_repository.dart';
import '../../../domain/repositories/auth_repository.dart';

class OnboardingViewModel extends ChangeNotifier with StepMixin {
  final AppStateRepository _appStateRepository;
  final AuthRepository _authRepository;

  OnboardingViewModel({
    required int totalSteps,
    required AppStateRepository appStateRepository,
    required AuthRepository authRepository,
  }) : _appStateRepository = appStateRepository,
       _authRepository = authRepository {
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

  Future<void> init() async {
    try {
      _log.info('Signing in anonymously...');
      final userCredential = await _authRepository.signInAnonymously();
      _log.info('Signed in with temporary user: ${userCredential.user}');

      _log.info(
        'Initializing $_nickname with personality $_selectedPersonality',
      );
      await _appStateRepository.init(
        nickname: _nickname,
        aiPersonality: _selectedPersonality,
      );

      // Onboarding is complete, set isFirstLaunch to false.
      await _appStateRepository.setFirstLaunchComplete();
    } on FirebaseAuthException catch (e) {
      _log.severe('Failed to sign in anonymously', e);
      // TODO: Handle error appropriately, e.g., show a snackbar
    }
  }
}
