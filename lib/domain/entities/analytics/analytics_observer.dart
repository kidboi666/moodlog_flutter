
import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_observer.freezed.dart';

@freezed
abstract class AnalyticsObserver with _$AnalyticsObserver {
  const factory AnalyticsObserver({
    required String name,
    required Map<String, dynamic> properties
  }) = _AnalyticsObserver;
}
