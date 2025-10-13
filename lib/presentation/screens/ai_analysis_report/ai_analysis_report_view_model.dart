import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';

class AiAnalysisReportViewModel extends ChangeNotifier with AsyncStateMixin {
  // TODO: Add dependencies like UseCase
  AiAnalysisReportViewModel() {
    fetchReport();
  }

  Future<void> fetchReport() async {
    // For now, just simulate a network call
    setLoading();
    await Future.delayed(const Duration(seconds: 2));
    setSuccess();
    // TODO: Implement actual report fetching logic using a UseCase
  }
}
