import 'package:flutter/foundation.dart';

class AiGenerationProvider extends ChangeNotifier {
  bool _isGeneratingAiResponse = false;
  Object? _errorGeneratingAiResponse;

  bool get isGeneratingAiResponse => _isGeneratingAiResponse;
  Object? get errorGeneratingAiResponse => _errorGeneratingAiResponse;

  void setGeneratingAiResponse() {
    _isGeneratingAiResponse = true;
    notifyListeners();
  }

  void setSuccessGeneratingAiResponse() {
    _isGeneratingAiResponse = false;
    notifyListeners();
  }

  void setErrorGeneratingAiResponse(Object error) {
    _isGeneratingAiResponse = false;
    _errorGeneratingAiResponse = error;
    notifyListeners();
  }

  void clearErrorGeneratingAiResponse() {
    _errorGeneratingAiResponse = null;
    notifyListeners();
  }
}
