import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

/// 에러를 표시하는 공통 다이얼로그
class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final bool showDetails;
  final String? errorDetails;

  const ErrorDialog({
    super.key,
    required this.title,
    required this.message,
    this.actionText,
    this.onActionPressed,
    this.showDetails = false,
    this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      icon: Icon(Icons.error_outline, color: colorScheme.error, size: 32),
      title: Text(
        title,
        style: textTheme.titleLarge?.copyWith(color: colorScheme.error),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: textTheme.bodyMedium),
          if (showDetails && errorDetails != null) ...[
            const SizedBox(height: 16),
            ExpansionTile(
              title: Text(
                '기술적 세부사항',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    errorDetails!,
                    style: textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(t.common_confirm_cancel),
        ),
        if (actionText != null && onActionPressed != null)
          FilledButton(
            onPressed: () {
              context.pop();
              onActionPressed!();
            },
            child: Text(actionText!),
          ),
      ],
    );
  }
}

/// 에러 유형별 팩토리 메서드
extension ErrorDialogFactory on ErrorDialog {
  /// 네트워크 에러 다이얼로그
  static ErrorDialog network({String? customMessage, VoidCallback? onRetry}) {
    return ErrorDialog(
      title: '연결 오류',
      message: customMessage ?? '네트워크 연결을 확인해주세요.',
      actionText: onRetry != null ? '다시 시도' : null,
      onActionPressed: onRetry,
    );
  }

  /// 서버 에러 다이얼로그
  static ErrorDialog server({
    String? customMessage,
    String? errorDetails,
    VoidCallback? onRetry,
  }) {
    return ErrorDialog(
      title: '서버 오류',
      message: customMessage ?? '서버에서 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
      actionText: onRetry != null ? '다시 시도' : null,
      onActionPressed: onRetry,
      showDetails: errorDetails != null,
      errorDetails: errorDetails,
    );
  }

  /// 일반적인 에러 다이얼로그
  static ErrorDialog general({
    required String message,
    String? errorDetails,
    VoidCallback? onAction,
    String? actionText,
  }) {
    return ErrorDialog(
      title: '오류',
      message: message,
      actionText: actionText,
      onActionPressed: onAction,
      showDetails: errorDetails != null,
      errorDetails: errorDetails,
    );
  }

  /// 권한 에러 다이얼로그
  static ErrorDialog permission({
    required String permissionName,
    VoidCallback? onOpenSettings,
  }) {
    return ErrorDialog(
      title: '권한 필요',
      message: '$permissionName 권한이 필요합니다. 설정에서 권한을 허용해주세요.',
      actionText: onOpenSettings != null ? '설정 열기' : null,
      onActionPressed: onOpenSettings,
    );
  }
}

/// 에러 다이얼로그를 표시하는 확장 메서드
extension ErrorDialogExtension on BuildContext {
  /// 에러 다이얼로그 표시
  Future<void> showErrorDialog(ErrorDialog dialog) {
    return showDialog<void>(
      context: this,
      barrierDismissible: false,
      builder: (_) => dialog,
    );
  }
}
