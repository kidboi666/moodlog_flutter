import 'package:flutter/material.dart';

import '../../../common/l10n/app_localizations.dart';

class ContentInput extends StatelessWidget {
  final TextEditingController contentController;

  const ContentInput({super.key, required this.contentController});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: contentController,
      minLines: 8,
      maxLines: 8,
      decoration: InputDecoration(
        fillColor: colorScheme.surfaceContainer,
        filled: true,
        border: const UnderlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        labelText: t.write_input_title,
        hintText: t.write_input_hint,
      ),
    );
  }
}
