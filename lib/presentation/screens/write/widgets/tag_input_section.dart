import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/presentation/screens/write/write_view_model.dart';
import 'package:provider/provider.dart';

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
    final selectedTags = context.select((WriteViewModel vm) => vm.selectedTags);

    return Wrap(
      spacing: Spacing.xs,
      runSpacing: Spacing.xs,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      children: [
        ...selectedTags.map(
          (tag) => _TagChip(
            tag: tag,
            onDeleted: () => context.read<WriteViewModel>().removeTag(tag),
          ),
        ),
      ],
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
