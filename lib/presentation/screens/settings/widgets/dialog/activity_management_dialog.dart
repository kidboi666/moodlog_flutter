import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/settings/settings_view_model.dart';

class TagManagementDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const TagManagementDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(t.activities_dialog_title),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : viewModel.activities.isEmpty
            ? Center(child: Text(t.activities_dialog_empty))
            : ListView.builder(
                itemCount: viewModel.activities.length,
                itemBuilder: (context, index) {
                  final tag = viewModel.activities[index];
                  return Dismissible(
                    key: Key(tag.id.toString()),
                    onDismissed: (direction) => viewModel.deleteActivity(tag.id),
                    child: ListTile(
                      onTap: () {},
                      title: Text(tag.name),
                      subtitle: Text(
                        t.activities_dialog_created(
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
          child: Text(t.activities_dialog_close),
        ),
      ],
    );
  }
}
