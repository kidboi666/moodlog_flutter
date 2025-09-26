import '../repositories/analytics_repository.dart';

class GetAnalyticsObserverUseCase {
  final AnalyticsRepository _repository;

  GetAnalyticsObserverUseCase({required AnalyticsRepository repository})
      : _repository = repository;

  dynamic call() {
    // Returns the observer object that can be cast to NavigatorObserver in the presentation layer
    return (_repository as dynamic).navigatorObserver;
  }
}