import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants/common.dart';
import '../../../../common/l10n/app_localizations.dart';
import '../../viewmodel/write_viewmodel.dart';

class TagInputBottomSheet extends StatefulWidget {
  const TagInputBottomSheet({super.key});

  @override
  State<TagInputBottomSheet> createState() => _TagInputBottomSheetState();
}

class _TagInputBottomSheetState extends State<TagInputBottomSheet> {
  final TextEditingController _tagController = TextEditingController();
  final FocusNode _tagFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Consumer<WriteViewModel>(
      builder: (context, viewModel, _) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(t.tags_add_new, style: textTheme.headlineSmall),
              const SizedBox(height: 20),

              // Selected tags
              if (viewModel.selectedTags.isNotEmpty) ...[
                Text('Selected Tags', style: textTheme.titleSmall),
                const SizedBox(height: Spacing.sm),
                Wrap(
                  spacing: Spacing.xs,
                  runSpacing: Spacing.xs,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: viewModel.selectedTags
                      .map(
                        (tag) => Chip(
                          label: Text(tag.name),
                          onDeleted: () {
                            viewModel.removeTag(tag);
                          },
                          backgroundColor: tag.color != null
                              ? Color(int.parse(tag.color!, radix: 16))
                              : colorScheme.surfaceContainerHighest,
                          deleteIcon: const Icon(Icons.close, size: 16),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: Spacing.md),
              ],

              // Add new tag
              TextField(
                controller: _tagController,
                focusNode: _tagFocusNode,
                decoration: InputDecoration(
                  labelText: t.tags_input_hint,
                  border: UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => _addNewTag(viewModel.addNewTag),
                    icon: const Icon(Icons.add),
                  ),
                ),
                onSubmitted: (_) => _addNewTag(viewModel.addNewTag),
              ),

              // Available tags
              if (viewModel.availableTags.isNotEmpty) ...[
                const SizedBox(height: Spacing.md),
                Text(t.tags_suggested_title, style: textTheme.titleSmall),
                const SizedBox(height: Spacing.sm),
                SizedBox(
                  height: 120,
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: Spacing.xs,
                      runSpacing: Spacing.xs,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      children: viewModel.availableTags
                          .where((tag) => !viewModel.selectedTags.contains(tag))
                          .map(
                            (tag) => ActionChip(
                              label: Text(tag.name),
                              onPressed: () {
                                viewModel.addExistingTag(tag);
                              },
                              backgroundColor: tag.color != null
                                  ? Color(int.parse(tag.color!, radix: 16))
                                  : colorScheme.surfaceContainerHighest,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 20),

              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  child: Text(t.common_confirm_ok),
                ),
              ),

              // Bottom padding for safe area
              SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
            ],
          ),
        );
      },
    );
  }

  void _addNewTag(Function(String) addNewTag) {
    final tagName = _tagController.text.trim();
    if (tagName.isNotEmpty) {
      addNewTag(tagName);
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
