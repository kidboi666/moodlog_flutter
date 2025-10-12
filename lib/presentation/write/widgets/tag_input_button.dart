import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/write/widgets/bottom_sheet/tag_input_bottom_sheet.dart';
import 'package:moodlog/presentation/write/write_view_model.dart';
import 'package:provider/provider.dart';

class TagInputButton extends StatelessWidget {
  const TagInputButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final selectedTagsCount = context.select(
      (WriteViewModel vm) => vm.selectedTags.length,
    );

    return IconButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (bottomSheetContext) {
          return TagInputBottomSheet(viewModel: context.read<WriteViewModel>());
        },
      ),
      icon: Badge(
        isLabelVisible: selectedTagsCount > 0,
        label: Text('$selectedTagsCount'),
        child: const Icon(Icons.label_outline),
      ),
      tooltip: t.tags_add_new,
    ).scale();
  }
}
