import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/routing.dart';
import '../../../core/ui/widgets/fade_in.dart';
import '../write_viewmodel.dart';
import 'ai_enable_card.dart';
import 'bottom_sheet/mood_slider_selection_bottom_sheet.dart';
import 'content_input.dart';
import 'image_preview_section.dart';

class WritePageViewRest extends StatefulWidget {
  final TextEditingController contentController;

  const WritePageViewRest({super.key, required this.contentController});

  @override
  State<WritePageViewRest> createState() => _WritePageViewRestState();
}

class _WritePageViewRestState extends State<WritePageViewRest> {
  late FocusNode _contentFocusNode;

  void _onContentChanged() {
    context.read<WriteViewModel>().updateContent(widget.contentController.text);
  }

  void _dismissKeyboard() {
    _contentFocusNode.unfocus();
    FocusScope.of(context).unfocus();
  }

  Future<void> _showMoodSelectionBottomSheet() async {
    await showModalBottomSheet<MoodType>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => MoodSliderSelectionBottomSheet(),
    );
  }

  @override
  void initState() {
    super.initState();
    _contentFocusNode = FocusNode();
    widget.contentController.addListener(_onContentChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<WriteViewModel>();
      if (!viewModel.isEditMode) {
        Future.delayed(DelayMs.lazy, _showMoodSelectionBottomSheet);
      }

      if (viewModel.content != null && widget.contentController.text.isEmpty) {
        widget.contentController.text = viewModel.content!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _dismissKeyboard();
        }
      },
      child: Padding(
        padding: Spacing.containerHorizontalPadding,
        child: Column(
          children: [
            Builder(
              builder: (context) {
                final isSubmitted = context.select<WriteViewModel, bool>(
                  (vm) => vm.isSubmitted,
                );
                final submittedJournalId = context.select<WriteViewModel, int?>(
                  (vm) => vm.submittedJournalId,
                );
                if (isSubmitted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.goToJournalFromWrite(submittedJournalId!);
                  });
                }

                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: Spacing.md),
            FadeIn(
              delay: DelayMs.quick,
              child: ImagePreviewSection(onTap: () {}),
            ),
            Column(
              children: [
                const SizedBox(height: Spacing.md),
                FadeIn(
                  delay: DelayMs.quick * 2,
                  child: ContentInput(
                    contentController: widget.contentController,
                    focusNode: _contentFocusNode,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.xxl),
            FadeIn(delay: DelayMs.quick * 3, child: const AiEnableCard()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.contentController.removeListener(_onContentChanged);
    _contentFocusNode.dispose();
    super.dispose();
  }
}
