import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../write_view_model.dart';

class TagInputBottomSheet extends StatefulWidget {
  final WriteViewModel viewModel;

  const TagInputBottomSheet({super.key, required this.viewModel});

  @override
  State<TagInputBottomSheet> createState() => _TagInputBottomSheetState();
}

class _TagInputBottomSheetState extends State<TagInputBottomSheet> {
  final TextEditingController _tagController = TextEditingController();
  final FocusNode _tagFocusNode = FocusNode();

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

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
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
              if (widget.viewModel.selectedTags.isNotEmpty) ...[
                Text(t.tags_selected_title, style: textTheme.titleSmall),
                const SizedBox(height: Spacing.sm),
                Wrap(
                  spacing: Spacing.xs,
                  runSpacing: Spacing.xs,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: widget.viewModel.selectedTags
                      .map(
                        (tag) => Chip(
                          label: Text(tag.name),
                          onDeleted: () {
                            widget.viewModel.removeTag(tag);
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
                    onPressed: () =>
                        _addNewTag(widget.viewModel.addNewTag),
                    icon: const Icon(Icons.add),
                  ),
                ),
                onSubmitted: (_) =>
                    _addNewTag(widget.viewModel.addNewTag),
              ),

              // Available tags
              if (widget.viewModel.availableTags.isNotEmpty) ...[
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
                      children: widget.viewModel.availableTags
                          .where(
                            (tag) =>
                                !widget.viewModel.selectedTags.contains(tag),
                          )
                          .map(
                            (tag) => ActionChip(
                              label: Text(tag.name),
                              onPressed: () {
                                widget.viewModel.addExistingTag(
                                  tag,
                                );
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
                child: FilledButton(
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
}
