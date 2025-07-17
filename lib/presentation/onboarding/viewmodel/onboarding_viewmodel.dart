import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/providers/app_state_provider.dart';

import '../../../core/constants/enum.dart';
import '../../../core/mixins/async_state_mixin.dart';
import '../../../core/mixins/step_mixin.dart';
import '../../../domain/entities/settings.dart';
import '../../../domain/repositories/auth_repository.dart';

class OnboardingViewModel extends ChangeNotifier
    with StepMixin, AsyncStateMixin {
  final AppStateProvider _appStateProvider;
  final AuthRepository _authRepository;

  OnboardingViewModel({
    required int totalSteps,
    required AppStateProvider appStateProvider,
    required AuthRepository authRepository,
  }) : _appStateProvider = appStateProvider,
       _authRepository = authRepository {
    initStep(totalSteps);
  }

  final Logger _log = Logger('OnboardingViewModel');
  AiPersonality _selectedPersonality = AiPersonality.balanced;
  String _nickname = '';

  String get nickname => _nickname;

  Settings get appState => _appStateProvider.appState;

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

  bool validateNickname(String? value) =>
      value != null && value.isNotEmpty && value.length <= 10;

  Future<void> signInAnonymously() async {
    setLoading();
    try {
      await _appStateProvider.updateAiPersonality(_selectedPersonality);
      await _authRepository.signInAnonymously();
      await _authRepository.updateDisplayName(_nickname);
      setSuccess();
    } on FirebaseAuthException catch (e) {
      _log.warning('Failed to sign in anonymously', e);
      setError(e);
    }
  }

  Future<void> signInGoogle() async {
    setLoading();
    try {
      await _appStateProvider.updateAiPersonality(_selectedPersonality);
      await _authRepository.signInWithGoogle();
      await _authRepository.updateDisplayName(_nickname);
      setSuccess();
    } on FirebaseAuthException catch (e) {
      _log.warning('Failed to sign in with Google', e);
      setError(e);
    }
  }
}
