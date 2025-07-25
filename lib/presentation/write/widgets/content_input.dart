import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/l10n/app_localizations.dart';

class ContentInput extends StatelessWidget {
  final TextEditingController contentController;

  const ContentInput({super.key, required this.contentController});

  void _insertTimestamp() {
    final now = DateTime.now();
    final timestamp = DateFormat('HH:mm').format(now);
    final text = contentController.text;
    final selection = contentController.selection;

    final newText = text.replaceRange(
      selection.start,
      selection.end,
      '[$timestamp] ',
    );

    contentController.text = newText;
    contentController.selection = TextSelection.collapsed(
      offset: selection.start + timestamp.length + 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: _insertTimestamp,
              icon: Icon(Icons.access_time, size: 16),
              label: Text(t.write_timestamp_add),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        TextFormField(
          controller: contentController,
          minLines: 10,
          maxLines: 10,
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
        ),
      ],
    );
  }
}
