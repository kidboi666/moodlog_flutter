import 'dart:io';

import 'package:flutter/material.dart';

import '../ui/widgets/error_dialog.dart';

/// 에러 처리를 위한 유틸리티 클래스
class ErrorHandler {
  /// 에러를 분석하고 적절한 에러 다이얼로그를 반환
  static ErrorDialog handleError(Object error, {String? customMessage}) {
    if (error is SocketException) {
      return ErrorDialogFactory.network(
        customMessage: customMessage ?? '인터넷 연결을 확인해주세요.',
      );
    }

    if (error is FormatException) {
      return ErrorDialogFactory.general(
        message: customMessage ?? '잘못된 데이터 형식입니다.',
        errorDetails: error.toString(),
      );
    }

    if (error is TimeoutException) {
      return ErrorDialogFactory.network(
        customMessage: customMessage ?? '요청 시간이 초과되었습니다.',
      );
    }

    // 일반적인 에러
    return ErrorDialogFactory.general(
      message: customMessage ?? '예상치 못한 오류가 발생했습니다.',
      errorDetails: error.toString(),
    );
  }

  /// 에러를 로깅하는 메서드
  static void logError(Object error, StackTrace? stackTrace, {
    String? context,
    Map<String, dynamic>? additionalData,
  }) {
    debugPrint('=== Error Log ===');
    if (context != null) {
      debugPrint('Context: $context');
    }
    debugPrint('Error: $error');
    if (stackTrace != null) {
      debugPrint('StackTrace: $stackTrace');
    }
    if (additionalData != null) {
      debugPrint('Additional Data: $additionalData');
    }
    debugPrint('================');
  }

  /// 에러를 처리하고 다이얼로그를 표시하는 통합 메서드
  static Future<void> handleAndShowError(
    BuildContext context,
    Object error, {
    StackTrace? stackTrace,
    String? customMessage,
    String? logContext,
    VoidCallback? onRetry,
  }) async {
    // 에러 로깅
    logError(error, stackTrace, context: logContext);

    // 에러 다이얼로그 생성
    final dialog = handleError(error, customMessage: customMessage);

    // 재시도 기능이 있으면 추가
    final dialogWithRetry = onRetry != null
        ? ErrorDialog(
            title: dialog.title,
            message: dialog.message,
            actionText: '다시 시도',
            onActionPressed: onRetry,
            showDetails: dialog.showDetails,
            errorDetails: dialog.errorDetails,
          )
        : dialog;

    // 다이얼로그 표시
    if (context.mounted) {
      await context.showErrorDialog(dialogWithRetry);
    }
  }
}

/// 타임아웃 예외
class TimeoutException implements Exception {
  final String message;

  const TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}