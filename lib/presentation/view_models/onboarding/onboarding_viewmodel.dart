import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';

class OnboardingViewModel extends ChangeNotifier {
  final int totalSteps;
  int _currentStep = 0;
  bool _isLastStep;

  OnboardingViewModel({this.totalSteps = 0})
    : _currentStep = 0,
      _isLastStep = false;

  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  int get currentStep => _currentStep;

  bool get isLastStep => _isLastStep;

  void nextStep() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: DurationMs.medium),
      curve: Curves.easeInOut,
    );
  }

  void setStep(int step) {
    final safeStep = step.clamp(0, totalSteps - 1);

    _currentStep = safeStep;
    _isLastStep = safeStep == totalSteps - 1;
    notifyListeners();
  }
}
