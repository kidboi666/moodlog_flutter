import 'package:flutter/material.dart';
import 'package:moodlog/presentation/settings/settings_viewmodel.dart';

import '../../../../domain/entities/tag.dart';

class TagManagementDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const TagManagementDialog({super.key, required this.viewModel});

  void _showDeleteConfirmation(BuildContext context, Tag tag) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Tag'),
        content: Text(
          'Are you sure you want to delete "${tag.name}"? This will remove the tag from all journals.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              viewModel.deleteTag(tag.id);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Manage Tags'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : viewModel.tags.isEmpty
            ? const Center(child: Text('No tags found'))
            : ListView.builder(
                itemCount: viewModel.tags.length,
                itemBuilder: (context, index) {
                  final tag = viewModel.tags[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: tag.color != null
                          ? Color(int.parse(tag.color!, radix: 16))
                          : Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                      radius: 12,
                    ),
                    title: Text(tag.name),
                    subtitle: Text(
                      'Created: ${tag.createdAt.day}/${tag.createdAt.month}/${tag.createdAt.year}',
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () => _showDeleteConfirmation(context, tag),
                    ),
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
