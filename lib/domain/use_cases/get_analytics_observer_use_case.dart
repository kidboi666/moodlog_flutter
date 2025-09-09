import 'package:flutter/cupertino.dart';

import '../repositories/analytics_repository.dart';

class GetAnalyticsObserverUseCase {
  final AnalyticsRepository _repository;

  GetAnalyticsObserverUseCase({required AnalyticsRepository repository})
      : _repository = repository;

  NavigatorObserver call() {
    return (_repository as dynamic).observer as NavigatorObserver;
  }
}