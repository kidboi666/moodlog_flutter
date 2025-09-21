import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';

class TestAsyncStateViewModel extends ChangeNotifier with AsyncStateMixin {
  int callCount = 0;

  Future<String> successOperation() async {
    callCount++;
    await Future.delayed(const Duration(milliseconds: 10));
    return 'success';
  }

  Future<String> failOperation() async {
    callCount++;
    await Future.delayed(const Duration(milliseconds: 10));
    throw Exception('Test error');
  }

  Future<String> intermittentOperation() async {
    callCount++;
    if (callCount <= 2) {
      throw Exception('Temporary error');
    }
    return 'success after retry';
  }
}

void main() {
  group('AsyncStateMixin', () {
    late TestAsyncStateViewModel viewModel;

    setUp(() {
      viewModel = TestAsyncStateViewModel();
    });

    tearDown(() {
      viewModel.dispose();
    });

    group('basic state management', () {
      test('should start with idle state', () {
        expect(viewModel.state, AsyncState.idle);
        expect(viewModel.isIdle, true);
        expect(viewModel.isLoading, false);
        expect(viewModel.hasError, false);
        expect(viewModel.error, null);
      });

      test('should update state correctly', () {
        viewModel.setLoading();
        expect(viewModel.state, AsyncState.loading);
        expect(viewModel.isLoading, true);

        viewModel.setSuccess();
        expect(viewModel.state, AsyncState.success);

        final error = Exception('test error');
        viewModel.setError(error);
        expect(viewModel.state, AsyncState.error);
        expect(viewModel.hasError, true);
        expect(viewModel.error, error);

        viewModel.clearState();
        expect(viewModel.state, AsyncState.idle);
        expect(viewModel.error, null);
      });
    });

    group('executeAsync', () {
      test('should execute successful operation correctly', () async {
        // Act
        final result = await viewModel.executeAsync(
          () => viewModel.successOperation(),
          context: 'test',
        );

        // Assert
        expect(result, 'success');
        expect(viewModel.state, AsyncState.success);
        expect(viewModel.callCount, 1);
      });

      test('should handle failed operation correctly', () async {
        // Act
        final result = await viewModel.executeAsync(
          () => viewModel.failOperation(),
          context: 'test',
        );

        // Assert
        expect(result, null);
        expect(viewModel.state, AsyncState.error);
        expect(viewModel.hasError, true);
        expect(viewModel.error, isA<Exception>());
        expect(viewModel.callCount, 1);
      });

      test('should call error callback when provided', () async {
        // Arrange
        bool errorCallbackCalled = false;
        void onError() => errorCallbackCalled = true;

        // Act
        await viewModel.executeAsync(
          () => viewModel.failOperation(),
          context: 'test',
          onError: onError,
        );

        // Assert
        expect(errorCallbackCalled, true);
      });

      test('should set loading state during execution', () async {
        // Arrange
        bool wasLoading = false;
        viewModel.addListener(() {
          if (viewModel.isLoading) {
            wasLoading = true;
          }
        });

        // Act
        await viewModel.executeAsync(
          () => viewModel.successOperation(),
          context: 'test',
        );

        // Assert
        expect(wasLoading, true);
      });
    });

    group('executeAsyncWithRetry', () {
      test('should retry failed operations', () async {
        // Act
        final result = await viewModel.executeAsyncWithRetry(
          () => viewModel.intermittentOperation(),
          maxRetries: 3,
          delay: const Duration(milliseconds: 1),
          context: 'test',
        );

        // Assert
        expect(result, 'success after retry');
        expect(viewModel.state, AsyncState.success);
        expect(viewModel.callCount, 3); // 실패 2번, 성공 1번
      });

      test('should fail after max retries', () async {
        // Act
        final result = await viewModel.executeAsyncWithRetry(
          () => viewModel.failOperation(),
          maxRetries: 2,
          delay: const Duration(milliseconds: 1),
          context: 'test',
        );

        // Assert
        expect(result, null);
        expect(viewModel.state, AsyncState.error);
        expect(viewModel.callCount, 2);
      });

      test('should succeed immediately if no error', () async {
        // Act
        final result = await viewModel.executeAsyncWithRetry(
          () => viewModel.successOperation(),
          maxRetries: 3,
          delay: const Duration(milliseconds: 1),
          context: 'test',
        );

        // Assert
        expect(result, 'success');
        expect(viewModel.state, AsyncState.success);
        expect(viewModel.callCount, 1); // 첫 번째 시도에서 성공
      });

      test('should respect delay between retries', () async {
        // Arrange
        final stopwatch = Stopwatch()..start();

        // Act
        await viewModel.executeAsyncWithRetry(
          () => viewModel.failOperation(),
          maxRetries: 2,
          delay: const Duration(milliseconds: 50),
          context: 'test',
        );

        stopwatch.stop();

        // Assert
        // 최소 50ms 정도의 지연이 있어야 함 (재시도 간격)
        expect(stopwatch.elapsedMilliseconds, greaterThan(40));
        expect(viewModel.callCount, 2);
      });
    });

    group('state transitions', () {
      test('should not change state if already in same state', () {
        // Arrange
        int notifyCount = 0;
        viewModel.addListener(() => notifyCount++);

        // Act
        viewModel.setLoading();
        viewModel.setLoading(); // 중복 호출

        // Assert
        expect(notifyCount, 1); // 한 번만 알림
      });

      test('should clear error when setting loading', () {
        // Arrange
        final error = Exception('test error');
        viewModel.setError(error);
        expect(viewModel.error, error);

        // Act
        viewModel.setLoading();

        // Assert
        expect(viewModel.error, null);
        expect(viewModel.isLoading, true);
      });

      test('should clear error when setting success', () {
        // Arrange
        final error = Exception('test error');
        viewModel.setError(error);
        expect(viewModel.error, error);

        // Act
        viewModel.setSuccess();

        // Assert
        expect(viewModel.error, null);
        expect(viewModel.state, AsyncState.success);
      });
    });
  });
}