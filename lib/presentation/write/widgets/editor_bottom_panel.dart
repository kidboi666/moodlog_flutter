import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../viewmodel/write_viewmodel.dart';
import 'image_picker_button.dart';
import 'timestamp_button.dart';

class EditorBottomPanel extends StatelessWidget {
  final TextEditingController contentController;

  const EditorBottomPanel({super.key, required this.contentController});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final colorScheme = Theme.of(context).colorScheme;
    return Selector<WriteViewModel, bool>(
      selector: (context, viewModel) => viewModel.isLastStep,
      builder: (context, isLastStep, child) {
        return AnimatedOpacity(
          duration: DurationMs.quick,
          opacity: isLastStep ? 1 : 0,
          child: SafeArea(
            child: Container(
              decoration: keyboardHeight > 0
                  ? BoxDecoration(
                      color: colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: Offset(0, -4),
                        ),
                      ],
                    )
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const ImagePickerButton(),
                  TimestampButton(contentController: contentController),
                  const SizedBox(width: Spacing.lg),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
