import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import '../../../core/constants/common.dart';

enum AiPersonalities { rational, balanced, compassionate }

class OnboardingViewModel extends ChangeNotifier {
  final int totalSteps;

  OnboardingViewModel({this.totalSteps = 0});

  int _currentStep = 0;
  bool _isLastStep = false;
  AiPersonalities? _selectedPersonality;
  String _nickname = '';

  String get nickname => _nickname;

  AiPersonalities? get selectedPersonality => _selectedPersonality;

  int get currentStep => _currentStep;

  bool get isLastStep => _isLastStep;

  void setStep(int step) {
    final safeStep = step.clamp(0, totalSteps - 1);

    _currentStep = safeStep;
    _isLastStep = safeStep == totalSteps - 1;
    notifyListeners();
  }

  void onPersonalityChanged(AiPersonalities personality) {
    _selectedPersonality = personality;
    notifyListeners();
  }

  void onNicknameChanged(String value) {
    _nickname = value;
    notifyListeners();
  }

  String? validateNickname(AppLocalizations t, String? value) {
    if (value == null || value.isEmpty) {
      return t.onboarding_nickname_input_error;
    }
    return null;
  }

  Future<void> onPageChange(PageController controller) async {
    controller.nextPage(
      duration: const Duration(milliseconds: DurationMs.medium),
      curve: Curves.easeInOut,
    );
  }
}
