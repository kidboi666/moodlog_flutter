import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../viewmodel/journal_viewmodel.dart';

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
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.journal_delete_confirm_title),
      content: Text(
        AppLocalizations.of(context)!.journal_delete_confirm_description,
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(AppLocalizations.of(context)!.common_confirm_cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            await viewModel.delete();
            if (context.mounted) {
              context.replace(Routes.home);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text(AppLocalizations.of(context)!.common_confirm_delete),
        ),
      ],
    );
  }
}
