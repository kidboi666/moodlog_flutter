import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/mixins/step_mixin.dart';
import 'package:moodlog/domain/entities/app/settings.dart';
import 'package:moodlog/domain/repositories/local_user_repository.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:moodlog/presentation/providers/user_provider.dart';

class OnboardingViewModel extends ChangeNotifier
    with StepMixin, AsyncStateMixin {
  final AppStateProvider _appStateProvider;
  final LocalUserRepository _localUserRepository;
  final UserProvider _userProvider;

  OnboardingViewModel({
    required int totalSteps,
    required AppStateProvider appStateProvider,
    required LocalUserRepository localUserRepository,
    required UserProvider userProvider,
  }) : _appStateProvider = appStateProvider,
       _localUserRepository = localUserRepository,
       _userProvider = userProvider,
       _selectedPersonality = AiPersonality.balanced {
    initStep(totalSteps);
  }

  AiPersonality? _selectedPersonality;

  String _nickname = '';

  String get nickname => _nickname;

  Settings get appState => _appStateProvider.appState;

  AiPersonality get selectedPersonality =>
      _selectedPersonality ?? AiPersonality.balanced;

  bool validateNickname(String? value) =>
      value != null && value.isNotEmpty && value.length <= 10;

  void setPersonality(AiPersonality? personality) {
    _selectedPersonality = personality ?? AiPersonality.balanced;
    notifyListeners();
  }

  void setNickname(String value) {
    _nickname = value;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    setLoading();
    try {
      // 로컬 사용자 생성
      await _localUserRepository.createUser(nickname: _nickname);

      // UserProvider 갱신
      await _userProvider.refresh();

      // 온보딩 완료 플래그 저장
      final updatedSettings = appState.copyWith(
        isOnboardingComplete: true,
        aiPersonality: selectedPersonality,
      );

      await _appStateProvider.update(updatedSettings);
      setSuccess();
    } catch (e) {
      debugPrint('Failed to complete onboarding $e');
      setError(e);
    }
  }
}
