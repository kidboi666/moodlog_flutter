import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/result.dart';
import '../../../../domain/entities/tag.dart';
import '../../../../domain/use_cases/tag/delete_tag_use_case.dart';
import '../../../../domain/use_cases/tag/get_all_tags_use_case.dart';

class TagManagementDialog extends StatefulWidget {
  const TagManagementDialog({super.key});

  @override
  State<TagManagementDialog> createState() => _TagManagementDialogState();
}

class _TagManagementDialogState extends State<TagManagementDialog> {
  List<Tag> _tags = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  Future<void> _loadTags() async {
    setState(() => _isLoading = true);
    final useCase = context.read<GetAllTagsUseCase>();
    final result = await useCase.call();
    
    switch (result) {
      case Ok<List<Tag>>():
        setState(() {
          _tags = result.value;
          _isLoading = false;
        });
      case Failure<List<Tag>>():
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to load tags')),
          );
        }
    }
  }

  Future<void> _deleteTag(Tag tag) async {
    final deleteUseCase = context.read<DeleteTagUseCase>();
    final result = await deleteUseCase.call(tag.id);
    
    switch (result) {
      case Ok<void>():
        setState(() {
          _tags.removeWhere((t) => t.id == tag.id);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tag "${tag.name}" deleted')),
          );
        }
      case Failure<void>():
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete tag')),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Manage Tags'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _tags.isEmpty
                ? const Center(child: Text('No tags found'))
                : ListView.builder(
                    itemCount: _tags.length,
                    itemBuilder: (context, index) {
                      final tag = _tags[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: tag.color != null
                              ? Color(int.parse(tag.color!, radix: 16))
                              : Theme.of(context).colorScheme.surfaceContainerHighest,
                          radius: 12,
                        ),
                        title: Text(tag.name),
                        subtitle: Text('Created: ${tag.createdAt.day}/${tag.createdAt.month}/${tag.createdAt.year}'),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          onPressed: () => _showDeleteConfirmation(tag),
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

  void _showDeleteConfirmation(Tag tag) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Tag'),
        content: Text('Are you sure you want to delete "${tag.name}"? This will remove the tag from all journals.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteTag(tag);
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
}