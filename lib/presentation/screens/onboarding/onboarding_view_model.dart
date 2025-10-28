import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/mixins/step_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/app/settings.dart';
import 'package:moodlog/domain/use_cases/local_user_use_case.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:moodlog/presentation/providers/user_provider.dart';

class OnboardingViewModel extends ChangeNotifier
    with StepMixin, AsyncStateMixin {
  final AppStateProvider _appStateProvider;
  final LocalUserUseCase _localUserUseCase;
  final UserProvider _userProvider;

  OnboardingViewModel({
    required int totalSteps,
    required AppStateProvider appStateProvider,
    required LocalUserUseCase localUserUseCase,
    required UserProvider userProvider,
  }) : _appStateProvider = appStateProvider,
       _localUserUseCase = localUserUseCase,
       _userProvider = userProvider {
    initStep(totalSteps);
  }

  String _nickname = '';

  String get nickname => _nickname;

  Settings get appState => _appStateProvider.appState;

  bool validateNickname(String? value) =>
      value != null && value.isNotEmpty && value.length <= 10;

  void setNickname(String value) {
    _nickname = value;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    setLoading();

    final result = await _localUserUseCase.createUser(nickname: _nickname);
    switch (result) {
      case Ok():
        await _userProvider.refresh();

        final updatedSettings = appState.copyWith(
          isOnboardingComplete: true,
        );

        await _appStateProvider.update(updatedSettings);
        setSuccess();
      case Error():
        debugPrint('Failed to complete onboarding: ${result.error}');
        setError(result.error);
    }
  }
}
