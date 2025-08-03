import 'package:flutter/material.dart';
import 'package:moodlog/common/extensions/widget_scale.dart';
import 'package:provider/provider.dart';

import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/write_viewmodel.dart';
import 'dialog/tag_input_dialog.dart';

class TagInputButton extends StatelessWidget {
  const TagInputButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Consumer<WriteViewModel>(
      builder: (context, viewModel, _) {
        return IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (dialogContext) => ChangeNotifierProvider.value(
              value: viewModel,
              child: TagInputDialog(),
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
