import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../core/constants/enum.dart';
import '../../core/mixins/async_state_mixin.dart';
import '../../core/mixins/step_mixin.dart';
import '../../domain/entities/app/settings.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/providers/app_state_provider.dart';

class OnboardingViewModel extends ChangeNotifier
    with StepMixin, AsyncStateMixin {
  final AppStateProvider _appStateProvider;
  final AuthRepository _authRepository;
  final LoginType _loginType;

  OnboardingViewModel({
    required int totalSteps,
    required AppStateProvider appStateProvider,
    required AuthRepository authRepository,
    required LoginType loginType,
  }) : _appStateProvider = appStateProvider,
       _authRepository = authRepository,
       _loginType = loginType {
    initStep(totalSteps);
  }

  final Logger _log = Logger('OnboardingViewModel');
  AiPersonality _selectedPersonality = AiPersonality.balanced;
  String _nickname = '';

  String get nickname => _nickname;

  Settings get appState => _appStateProvider.appState;

  AiPersonality get selectedPersonality => _selectedPersonality;

  bool validateNickname(String? value) =>
      value != null && value.isNotEmpty && value.length <= 10;

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

  Future<void> setOnboardingCompleted() async {
    setLoading();
    try {
      await _appStateProvider.updateOnboardedLoginTypes(_loginType);
      await _appStateProvider.updateAiPersonality(_selectedPersonality);
      await _authRepository.updateDisplayName(_nickname);
      setSuccess();
    } catch (e) {
      _log.warning('Failed to update base user info', e);
      setError(e);
    }
  }
}
