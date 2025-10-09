import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/enum.dart';
import '../utils/error_handler.dart';

mixin AsyncStateMixin on ChangeNotifier {
  AsyncState _state = AsyncState.idle;
  Object? _error;

  AsyncState get state => _state;

  bool get isIdle => _state == AsyncState.idle;

  bool get isLoading => _state == AsyncState.loading;

  Object? get error => _error;

  bool get hasError => _state == AsyncState.error;

  void setAsyncState([AsyncState newState = AsyncState.idle, Object? error]) {
    _state = newState;
    _error = error;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setLoading() {
    if (_state == AsyncState.loading) return;
    _state = AsyncState.loading;
    _error = null;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setSuccess() {
    if (_state == AsyncState.success && _error == null) return;
    _state = AsyncState.success;
    _error = null;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setError(Object error) {
    if (_state == AsyncState.error && _error == error) return;
    _state = AsyncState.error;
    _error = error;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void clearState() {
    if (_state == AsyncState.idle && _error == null) return;
    _error = null;
    _state = AsyncState.idle;
    if (hasListeners) {
      notifyListeners();
    }
  }

  /// 비동기 작업을 안전하게 실행하는 헬퍼 메서드
  Future<T?> executeAsync<T>(
    Future<T> Function() operation, {
    String? context,
    bool showErrorDialog = false,
    BuildContext? dialogContext,
    VoidCallback? onError,
  }) async {
    try {
      setLoading();
      final result = await operation();
      setSuccess();
      return result;
    } catch (error, stackTrace) {
      setError(error);

      // 에러 로깅
      ErrorHandler.logError(
        error,
        stackTrace,
        context: context ?? runtimeType.toString(),
      );

      // 에러 다이얼로그 표시 (선택적)
      if (showErrorDialog && dialogContext != null && dialogContext.mounted) {
        await ErrorHandler.handleAndShowError(
          dialogContext,
          error,
          stackTrace: stackTrace,
          logContext: context,
        );
      }

      // 커스텀 에러 핸들러 실행
      onError?.call();

      return null;
    }
  }

  /// 재시도 가능한 비동기 작업 실행
  Future<T?> executeAsyncWithRetry<T>(
    Future<T> Function() operation, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
    String? context,
    bool showErrorDialog = false,
    BuildContext? dialogContext,
  }) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      final result = await executeAsync(
        operation,
        context: '$context (attempt $attempt/$maxRetries)',
        showErrorDialog: showErrorDialog && attempt == maxRetries,
        dialogContext: dialogContext,
      );

      if (result != null || !hasError) {
        return result;
      }

      if (attempt < maxRetries) {
        await Future.delayed(delay);
        clearState(); // 다음 시도를 위해 에러 상태 초기화
      }
    }

    return null;
  }
}
