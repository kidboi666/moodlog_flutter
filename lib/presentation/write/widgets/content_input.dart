import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';

class ContentInput extends StatelessWidget {
  final TextEditingController contentController;
  final FocusNode? focusNode;

  const ContentInput({
    super.key,
    required this.contentController,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: contentController,
      focusNode: focusNode,
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
