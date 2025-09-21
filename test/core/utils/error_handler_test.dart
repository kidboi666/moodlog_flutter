import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/utils/error_handler.dart';

void main() {
  group('ErrorHandler', () {
    group('handleError', () {
      test('should handle SocketException correctly', () {
        // Arrange
        final error = const SocketException('No internet connection');

        // Act
        final result = ErrorHandler.handleError(error);

        // Assert
        expect(result.title, '연결 오류');
        expect(result.message, '인터넷 연결을 확인해주세요.');
      });

      test('should handle FirebaseAuthException with known error code', () {
        // Arrange
        final error = FirebaseAuthException(code: 'user-not-found');

        // Act
        final result = ErrorHandler.handleError(error);

        // Assert
        expect(result.title, '오류');
        expect(result.message, '등록된 사용자를 찾을 수 없습니다.');
        expect(result.showDetails, true);
      });

      test('should handle FormatException correctly', () {
        // Arrange
        final error = const FormatException('Invalid format');

        // Act
        final result = ErrorHandler.handleError(error);

        // Assert
        expect(result.title, '오류');
        expect(result.message, '잘못된 데이터 형식입니다.');
        expect(result.showDetails, true);
      });

      test('should handle TimeoutException correctly', () {
        // Arrange
        final error = const TimeoutException('Request timeout');

        // Act
        final result = ErrorHandler.handleError(error);

        // Assert
        expect(result.title, '연결 오류');
        expect(result.message, '요청 시간이 초과되었습니다.');
      });

      test('should handle unknown error with custom message', () {
        // Arrange
        final error = Exception('Unknown error');
        const customMessage = 'Custom error message';

        // Act
        final result = ErrorHandler.handleError(error, customMessage: customMessage);

        // Assert
        expect(result.title, '오류');
        expect(result.message, customMessage);
        expect(result.showDetails, true);
      });

      test('should handle unknown error without custom message', () {
        // Arrange
        final error = Exception('Unknown error');

        // Act
        final result = ErrorHandler.handleError(error);

        // Assert
        expect(result.title, '오류');
        expect(result.message, '예상치 못한 오류가 발생했습니다.');
        expect(result.showDetails, true);
      });
    });

    group('ErrorDialogFactory', () {
      test('should create network error dialog', () {
        // Act
        final result = ErrorDialogFactory.network();

        // Assert
        expect(result.title, '연결 오류');
        expect(result.message, '네트워크 연결을 확인해주세요.');
        expect(result.actionText, null);
      });

      test('should create network error dialog with retry action', () {
        // Arrange
        bool retryCallbackCalled = false;
        void onRetry() => retryCallbackCalled = true;

        // Act
        final result = ErrorDialogFactory.network(onRetry: onRetry);

        // Assert
        expect(result.title, '연결 오류');
        expect(result.actionText, '다시 시도');
        expect(result.onActionPressed, isNotNull);
      });

      test('should create server error dialog', () {
        // Act
        final result = ErrorDialogFactory.server();

        // Assert
        expect(result.title, '서버 오류');
        expect(result.message, '서버에서 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
        expect(result.showDetails, false);
      });

      test('should create general error dialog', () {
        // Arrange
        const message = 'General error message';

        // Act
        final result = ErrorDialogFactory.general(message: message);

        // Assert
        expect(result.title, '오류');
        expect(result.message, message);
      });

      test('should create permission error dialog', () {
        // Arrange
        const permissionName = '카메라';

        // Act
        final result = ErrorDialogFactory.permission(permissionName: permissionName);

        // Assert
        expect(result.title, '권한 필요');
        expect(result.message, '$permissionName 권한이 필요합니다. 설정에서 권한을 허용해주세요.');
      });
    });
  });
}