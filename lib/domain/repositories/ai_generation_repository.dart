import 'package:flutter/foundation.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';

class AiGenerationRepository extends ChangeNotifier with AsyncStateMixin {
  bool get isGeneratingAiResponse => isLoading;

  void setGeneratingAiResponse() {
    setLoading();
  }

  void setSuccessGeneratingAiResponse() {
    setSuccess();
  }

  void setErrorGeneratingAiResponse(Object error) {
    setError(error);
  }

  void clearErrorGeneratingAiResponse() {
    clearError();
  }
}
