import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../../domain/entities/tag.dart';
import '../viewmodel/write_viewmodel.dart';

class TagInputSection extends StatefulWidget {
  const TagInputSection({super.key});

  @override
  State<TagInputSection> createState() => _TagInputSectionState();
}

class _TagInputSectionState extends State<TagInputSection> {
  final TextEditingController _tagController = TextEditingController();
  final FocusNode _tagFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Consumer<WriteViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: Spacing.xs,
              runSpacing: Spacing.xs,
              children: [
                ...viewModel.selectedTags.map((tag) => _TagChip(
                      tag: tag,
                      onDeleted: () => viewModel.removeTag(tag),
                    )),
                _AddTagChip(
                  controller: _tagController,
                  focusNode: _tagFocusNode,
                  onTagAdded: (tagName) {
                    viewModel.addNewTag(tagName);
                    _tagController.clear();
                  },
                ),
              ],
            ),
            if (viewModel.availableTags.isNotEmpty) ...[
              const SizedBox(height: Spacing.sm),
              Text(
                t.tags_suggested_title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: Spacing.xs),
              Wrap(
                spacing: Spacing.xs,
                runSpacing: Spacing.xs,
                children: viewModel.availableTags
                    .where((tag) => !viewModel.selectedTags.contains(tag))
                    .map((tag) => _SuggestedTagChip(
                          tag: tag,
                          onTap: () => viewModel.addExistingTag(tag),
                        ))
                    .toList(),
              ),
            ],
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _tagController.dispose();
    _tagFocusNode.dispose();
    super.dispose();
  }
}

class _TagChip extends StatelessWidget {
  final Tag tag;
  final VoidCallback onDeleted;

  const _TagChip({
    required this.tag,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(tag.name),
      onDeleted: onDeleted,
      backgroundColor: tag.color != null
          ? Color(int.parse(tag.color!, radix: 16))
          : Theme.of(context).colorScheme.surfaceContainerHighest,
      deleteIcon: const Icon(Icons.close, size: 16),
    );
  }
}

class _SuggestedTagChip extends StatelessWidget {
  final Tag tag;
  final VoidCallback onTap;

  const _SuggestedTagChip({
    required this.tag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(tag.name),
      onPressed: onTap,
      backgroundColor: tag.color != null
          ? Color(int.parse(tag.color!, radix: 16))
          : Theme.of(context).colorScheme.surfaceContainerHighest,
    );
  }
}

class _AddTagChip extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onTagAdded;

  const _AddTagChip({
    required this.controller,
    required this.focusNode,
    required this.onTagAdded,
  });

  @override
  State<_AddTagChip> createState() => _AddTagChipState();
}

class _AddTagChipState extends State<_AddTagChip> {
  bool _isEditing = false;

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
    widget.focusNode.requestFocus();
  }

  void _stopEditing() {
    setState(() {
      _isEditing = false;
    });
    widget.focusNode.unfocus();
  }

  void _submitTag() {
    final tagName = widget.controller.text.trim();
    if (tagName.isNotEmpty) {
      widget.onTagAdded(tagName);
    }
    _stopEditing();
  }

  String get _hintText {
    final t = AppLocalizations.of(context)!;
    return t.tags_input_hint;
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return Container(
        constraints: const BoxConstraints(minWidth: 80, maxWidth: 200),
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            hintText: _hintText,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            isDense: true,
          ),
          style: Theme.of(context).textTheme.bodySmall,
          onSubmitted: (_) => _submitTag(),
          onTapOutside: (_) => _stopEditing(),
        ),
      );
    }

    return ActionChip(
      label: const Icon(Icons.add, size: 16),
      onPressed: _startEditing,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}