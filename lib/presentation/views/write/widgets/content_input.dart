import 'package:flutter/material.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/write/write_viewmodel.dart';

class ContentInput extends StatelessWidget {
  final WriteViewModel viewModel;
  final TextEditingController contentController;

  const ContentInput({
    super.key,
    required this.viewModel,
    required this.contentController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: contentController,
      minLines: 8,
      maxLines: 8,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.surfaceContainer,
        filled: true,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        labelText: AppLocalizations.of(context)!.write_input_title,
        hintText: AppLocalizations.of(context)!.write_input_hint,
      ),
    );
  }
}
