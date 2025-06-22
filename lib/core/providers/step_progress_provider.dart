import 'package:flutter/cupertino.dart';

class StepProgressProvider extends ChangeNotifier {
  int _currentStep;
  final int totalSteps;
  bool _isLastStep;
  double _progress;

  StepProgressProvider({this.totalSteps = 0})
    : _currentStep = 0,
      _isLastStep = false,
      _progress = 0;

  int get currentStep => _currentStep;

  bool get isLastStep => _isLastStep;

  double get progress => _progress;

  void setStep(int step) {
    final safeStep = step.clamp(0, totalSteps - 1);
    _currentStep = safeStep;
    _isLastStep = safeStep == totalSteps - 1;
    _progress = totalSteps > 1 ? (safeStep / totalSteps) * 100 : 100;
    notifyListeners();
  }
}
