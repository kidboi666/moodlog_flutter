import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/write_viewmodel.dart';

class TagInputDialog extends StatefulWidget {
  const TagInputDialog({super.key});

  @override
  State<TagInputDialog> createState() => _TagInputDialogState();
}

class _TagInputDialogState extends State<TagInputDialog> {
  final TextEditingController _tagController = TextEditingController();
  final FocusNode _tagFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    
    return Consumer<WriteViewModel>(
      builder: (context, viewModel, child) {
        return AlertDialog(
          title: Text(t.tags_add_new),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Selected tags
                if (viewModel.selectedTags.isNotEmpty) ...[
                  Text(
                    'Selected Tags',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: Spacing.sm),
                  Wrap(
                    spacing: Spacing.xs,
                    runSpacing: Spacing.xs,
                    children: viewModel.selectedTags.map((tag) => Chip(
                      label: Text(tag.name),
                      onDeleted: () => viewModel.removeTag(tag),
                      backgroundColor: tag.color != null
                          ? Color(int.parse(tag.color!, radix: 16))
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                      deleteIcon: const Icon(Icons.close, size: 16),
                    )).toList(),
                  ),
                  const SizedBox(height: Spacing.md),
                ],
                
                // Add new tag
                TextField(
                  controller: _tagController,
                  focusNode: _tagFocusNode,
                  decoration: InputDecoration(
                    labelText: t.tags_input_hint,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: _addNewTag,
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  onSubmitted: (_) => _addNewTag(),
                ),
                
                // Available tags
                if (viewModel.availableTags.isNotEmpty) ...[
                  const SizedBox(height: Spacing.md),
                  Text(
                    t.tags_suggested_title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: Spacing.sm),
                  SizedBox(
                    height: 120,
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: Spacing.xs,
                        runSpacing: Spacing.xs,
                        children: viewModel.availableTags
                            .where((tag) => !viewModel.selectedTags.contains(tag))
                            .map((tag) => ActionChip(
                                  label: Text(tag.name),
                                  onPressed: () => viewModel.addExistingTag(tag),
                                  backgroundColor: tag.color != null
                                      ? Color(int.parse(tag.color!, radix: 16))
                                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.common_confirm_ok),
            ),
          ],
        );
      },
    );
  }

  void _addNewTag() {
    final tagName = _tagController.text.trim();
    if (tagName.isNotEmpty) {
      context.read<WriteViewModel>().addNewTag(tagName);
      _tagController.clear();
    }
  }

  @override
  void dispose() {
    _tagController.dispose();
    _tagFocusNode.dispose();
    super.dispose();
  }
}