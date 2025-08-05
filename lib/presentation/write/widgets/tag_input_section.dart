import 'package:flutter/material.dart';
import 'package:moodlog/common/extensions/widget_scale.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
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
    return Consumer<WriteViewModel>(
      builder: (context, viewModel, child) {
        return Wrap(
          spacing: Spacing.xs,
          runSpacing: Spacing.xs,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            ...viewModel.selectedTags.map(
              (tag) =>
                  _TagChip(tag: tag, onDeleted: () => viewModel.removeTag(tag)),
            ),
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

  const _TagChip({required this.tag, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(tag.name),
      onDeleted: onDeleted,
      backgroundColor: tag.color != null
          ? Color(int.parse(tag.color!, radix: 16))
          : Theme.of(context).colorScheme.surface,
      deleteIcon: const Icon(Icons.close, size: 16),
    ).scale();
  }
}
