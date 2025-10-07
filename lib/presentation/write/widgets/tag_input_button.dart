import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/widget.dart';
import '../../../core/l10n/app_localizations.dart';
import '../write_view_model.dart';
import 'bottom_sheet/tag_input_bottom_sheet.dart';

class TagInputButton extends StatelessWidget {
  const TagInputButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = context.read<WriteViewModel>();
    final selectedTags = context.select(
      (WriteViewModel vm) => vm.selectedTags,
    );

    return IconButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (bottomSheetContext) => ChangeNotifierProvider.value(
          value: viewModel,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: const TagInputBottomSheet(),
          ),
        ),
      ),
      icon: Badge(
        isLabelVisible: selectedTags.isNotEmpty,
        label: Text('${selectedTags.length}'),
        child: const Icon(Icons.label_outline),
      ),
      tooltip: t.tags_add_new,
    ).scale();
  }
}
