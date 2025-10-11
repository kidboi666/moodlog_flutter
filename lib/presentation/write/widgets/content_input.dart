import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';

class ContentInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final FocusNode? focusNode;

  const ContentInput({
    super.key,
    required this.textEditingController,
    this.focusNode,
  });

  @override
  State<ContentInput> createState() => _ContentInputState();
}

class _ContentInputState extends State<ContentInput> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.write_input_title,
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: widget.textEditingController,
                focusNode: widget.focusNode,
                expands: true,
                maxLines: null,
                minLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: t.write_input_hint,
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: textTheme.bodyMedium,
                cursorColor: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
