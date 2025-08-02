import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/extensions/routing.dart';
import '../../widgets/fade_in.dart';
import '../viewmodel/write_viewmodel.dart';
import 'ai_enable_card.dart';
import 'content_input.dart';
import 'image_preview_section.dart';
import 'location_button.dart';
import 'location_card.dart';
import 'weather_card.dart';

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

  @override
  void initState() {
    super.initState();
    _contentFocusNode = FocusNode();
    widget.contentController.addListener(_onContentChanged);
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
            Consumer<WriteViewModel>(
              builder: (context, viewModel, _) {
                if (viewModel.isSubmitted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.goToJournalFromWrite(viewModel.submittedJournalId!);
                  });
                }

                return const SizedBox.shrink();
              },
            ),
            FadeIn(delay: DelayMs.quick, child: const ImagePreviewSection()),
            Column(
              children: [
                FadeIn(
                  delay: DelayMs.quick * 1.5,
                  child: Row(
                    children: [
                      const WeatherCard(),
                      const LocationButton(),
                      const LocationCard(),
                    ],
                  ),
                ),
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
            FadeIn(delay: DelayMs.quick * 3, child: AiEnableCard()),
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
