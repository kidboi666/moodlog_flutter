import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/settings/settings_viewmodel.dart';

import '../../../../domain/entities/tag.dart';

class TagManagementDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const TagManagementDialog({super.key, required this.viewModel});

  void _showDeleteConfirmation(BuildContext context, Tag tag) {
    showDialog(
      context: context,
      builder: (context) {
        final t = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(t.tags_dialog_delete_title),
          content: Text(t.tags_dialog_delete_message(tag.name)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.common_confirm_cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                viewModel.deleteTag(tag.id);
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: Text(t.common_confirm_delete),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(t.tags_dialog_title),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : viewModel.tags.isEmpty
            ? Center(child: Text(t.tags_dialog_empty))
            : ListView.builder(
                itemCount: viewModel.tags.length,
                itemBuilder: (context, index) {
                  final tag = viewModel.tags[index];
                  return Dismissible(
                    key: Key(tag.id.toString()),
                    onDismissed: (direction) => viewModel.deleteTag(tag.id),
                    child: ListTile(
                      onTap: () {},
                      title: Text(tag.name),
                      subtitle: Text(
                        t.tags_dialog_created(
                          '${tag.createdAt.day}/${tag.createdAt.month}/${tag.createdAt.year}',
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.tags_dialog_close),
        ),
      ],
    );
  }
}
