import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class AiGenerationRepository extends ChangeNotifier {
  bool _isGeneratingAiResponse = false;
  final Logger _log = Logger('AiGenerationRepository');

  bool get isGeneratingAiResponse => _isGeneratingAiResponse;

  void setGeneratingState(bool isGenerating) {
    if (_isGeneratingAiResponse == isGenerating) return;
    _log.info('Setting generating state to $isGenerating');
    _isGeneratingAiResponse = isGenerating;
    notifyListeners();
  }
}
