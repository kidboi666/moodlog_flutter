import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/widget_scale.dart';
import '../../../core/l10n/app_localizations.dart';
import '../write_viewmodel.dart';
import 'bottom_sheet/tag_input_bottom_sheet.dart';

class TagInputButton extends StatelessWidget {
  const TagInputButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<WriteViewModel>(
      builder: (context, viewModel, _) {
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
            isLabelVisible: viewModel.selectedTags.isNotEmpty,
            label: Text('${viewModel.selectedTags.length}'),
            child: const Icon(Icons.label_outline),
          ),
          tooltip: t.tags_add_new,
        ).scale();
      },
    );
  }
}
