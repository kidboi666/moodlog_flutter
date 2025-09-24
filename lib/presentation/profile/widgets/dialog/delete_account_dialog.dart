import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/utils/result.dart';
import '../../profile_viewmodel.dart';

class DeleteAccountDialog extends StatelessWidget {
  final ProfileViewModel viewModel;

  const DeleteAccountDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: theme.colorScheme.error,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            t.profile_delete_account_dialog_title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.profile_delete_account_dialog_content,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: theme.colorScheme.error,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      t.profile_delete_account_dialog_warning,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            t.common_confirm_cancel,
            style: theme.textTheme.labelLarge,
          ),
        ),
        ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return FilledButton(
              onPressed: viewModel.isLoading
                  ? null
                  : () => _handleDeleteAccount(context, viewModel),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
              child: viewModel.isLoading
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.onError,
                        ),
                      ),
                    )
                  : Text(
                      t.profile_delete_account_dialog_confirm,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onError,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _handleDeleteAccount(
    BuildContext context,
    ProfileViewModel viewModel,
  ) async {
    final result = await viewModel.deleteAccount();
    if (context.mounted) {
      context.pop();

      switch (result) {
        case Ok<void>():
          // 계정 삭제 성공 시 로그인 화면으로 이동
          context.go('/auth');
        case Error<void>():
          // 에러는 ProfileViewModel에서 처리됨
          break;
      }
    }
  }
}
