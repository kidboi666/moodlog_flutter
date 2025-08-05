import 'package:flutter/material.dart';

import 'image_picker_button.dart';
import 'tag_input_button.dart';
import 'timestamp_button.dart';

class EditorBottomPanel extends StatelessWidget {
  final TextEditingController contentController;

  const EditorBottomPanel({super.key, required this.contentController});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          boxShadow: keyboardHeight > 0
              ? [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ImagePickerButton(),
            TagInputButton(),
            TimestampButton(contentController: contentController),
          ],
        ),
      ),
    );
  }
}
