import 'dart:async';
import 'dart:ui';

/// Debounce 기능을 제공하는 믹스인
///
/// 사용법:
/// ```dart
/// class MyViewModel extends ChangeNotifier with DebounceMixin {
///   void onButtonPressed() {
///     debounce('my_key', Duration(milliseconds: 300), () {
///       // 실제 실행할 코드
///       performActualWork();
///     });
///   }
/// }
/// ```
mixin DebounceMixin {
  final Map<String, Timer> _timers = {};
  final Set<String> _firstRun = {};

  /// 지정된 키와 지연 시간으로 함수 실행을 debounce합니다.
  /// 첫 실행은 즉시 실행되고, 이후 호출은 debounce됩니다.
  ///
  /// [key] - debounce를 식별하는 키 (여러 debounce를 구분하기 위해)
  /// [delay] - 지연 시간
  /// [action] - 실행할 함수
  void debounce(String key, Duration delay, VoidCallback action) {
    // 첫 실행인 경우 즉시 실행
    if (!_firstRun.contains(key)) {
      _firstRun.add(key);
      action();
      return;
    }

    _timers[key]?.cancel();
    _timers[key] = Timer(delay, () {
      action();
      _timers.remove(key);
    });
  }

  /// 특정 키의 debounce를 취소합니다.
  void cancelDebounce(String key) {
    _timers[key]?.cancel();
    _timers.remove(key);
  }

  /// 모든 debounce를 취소합니다.
  void cancelAllDebounce() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    _firstRun.clear();
  }

  /// 특정 키의 debounce가 활성화되어 있는지 확인합니다.
  bool isDebounceActive(String key) {
    return _timers.containsKey(key) && _timers[key]!.isActive;
  }

  /// DebounceMixin을 사용하는 클래스에서 dispose 시 호출해야 합니다.
  void disposeDebounce() {
    cancelAllDebounce();
  }
}
