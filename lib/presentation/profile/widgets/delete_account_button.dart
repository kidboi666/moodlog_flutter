import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../profile_viewmodel.dart';
import 'dialog/delete_account_dialog.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: () => _showDeleteAccountDialog(context),
        style: TextButton.styleFrom(
          foregroundColor: theme.colorScheme.error,
          backgroundColor: theme.colorScheme.errorContainer.withValues(
            alpha: 0.1,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_forever_outlined,
              color: theme.colorScheme.error,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              t.profile_delete_account_button,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final viewModel = context.read<ProfileViewModel>();
    showDialog(
      context: context,
      builder: (context) => DeleteAccountDialog(viewModel: viewModel),
    );
  }
}
