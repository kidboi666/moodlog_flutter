import 'package:flutter/foundation.dart';

mixin StepMixin on ChangeNotifier {
  late int totalSteps;
  int _currentStep = 0;
  bool _isLastStep = false;

  int get currentStep => _currentStep;

  bool get isLastStep => _isLastStep;

  void initStep(int steps) {
    totalSteps = steps;
    _updateLastStep();
  }

  void setStep(int step) {
    final safeStep = step.clamp(0, totalSteps - 1);

    _currentStep = safeStep;
    _updateLastStep();
    notifyListeners();
  }

  void _updateLastStep() {
    _isLastStep = _currentStep == totalSteps - 1;
  }

  void onStepChange(int prevStep, int currStep) {}
}
