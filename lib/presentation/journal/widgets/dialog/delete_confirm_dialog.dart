import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../journal_view_model.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final int id;
  final JournalViewModel viewModel;

  const DeleteConfirmDialog({
    super.key,
    required this.id,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(t.journal_delete_confirm_title),
      content: Text(t.journal_delete_confirm_description),
      actions: [
        TextButton(
          style: TextButton.styleFrom(foregroundColor: colorScheme.onSurface),
          onPressed: () => context.pop(),
          child: Text(t.common_confirm_cancel),
        ),
        FilledButton(
          onPressed: () async {
            await viewModel.delete();
            if (context.mounted) {
              context.pop(true);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text(t.common_confirm_delete),
        ),
      ],
    );
  }
}
