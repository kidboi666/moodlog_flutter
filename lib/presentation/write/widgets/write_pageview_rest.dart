import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/routing.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../widgets/fade_in.dart';
import '../viewmodel/write_viewmodel.dart';
import 'ai_enable_card.dart';
import 'content_input.dart';
import 'image_picking_section.dart';

class WritePageViewRest extends StatefulWidget {
  const WritePageViewRest({super.key});

  @override
  State<WritePageViewRest> createState() => _WritePageViewRestState();
}

class _WritePageViewRestState extends State<WritePageViewRest> {
  late TextEditingController _contentController;

  void _onContentChanged() {
    context.read<WriteViewModel>().updateContent(_contentController.text);
  }

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
    _contentController.addListener(_onContentChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.containerHorizontalPadding,
      child: Column(
        spacing: Spacing.xxl,
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
          FadeIn(
            delay: DelayMs.quick,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: ImagePickingSection()),
                Selector<WriteViewModel, DateTime>(
                  selector: (context, viewModel) => viewModel.selectedDate,
                  builder: (context, selectedDate, child) {
                    return TextButton(
                      child: Row(
                        spacing: Spacing.md,
                        children: [
                          Text(selectedDate.formattedDotNationWithTime()),
                          Icon(Icons.calendar_month),
                        ],
                      ),
                      onPressed: () =>
                          context.read<WriteViewModel>().selectDate(context),
                    );
                  },
                ),
              ],
            ),
          ),
          FadeIn(
            delay: DelayMs.quick * 2,
            child: ContentInput(contentController: _contentController),
          ),
          FadeIn(delay: DelayMs.quick * 3, child: AiEnableCard()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _contentController.removeListener(_onContentChanged);
    _contentController.dispose();
    super.dispose();
  }
}
