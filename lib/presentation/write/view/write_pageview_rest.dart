import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../../core/router/routes.dart';
import '../../widgets/fade_in.dart';
import '../viewmodel/write_viewmodel.dart';
import 'ai_enable_card.dart';
import 'content_input.dart';
import 'image_picking_section.dart';

typedef SubmissionData = ({bool isSubmitted, String journalId});

class WritePageViewRest extends StatefulWidget {
  const WritePageViewRest({super.key});

  @override
  State<WritePageViewRest> createState() => _WritePageViewRestState();
}

class _WritePageViewRestState extends State<WritePageViewRest> {
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
    _contentController.addListener(() {
      context.read<WriteViewModel>().updateContent(_contentController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.containerHorizontalPadding,
      child: Column(
        spacing: Spacing.xxl,
        children: [
          Selector<WriteViewModel, SubmissionData>(
            selector: (context, viewModel) => (
              isSubmitted: viewModel.isSubmitted,
              journalId: viewModel.submittedJournalId.toString(),
            ),
            builder: (context, submissionData, child) {
              if (submissionData.isSubmitted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go(
                    Routes.journal(submissionData.journalId),
                    extra: {'source': 'write'},
                  );
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
                Expanded(child: const ImagePickingSection()),
                Selector<WriteViewModel, DateTime>(
                  selector: (context, viewModel) => viewModel.selectedDate,
                  builder: (context, selectedDate, child) {
                    return TextButton(
                      child: Row(
                        spacing: 8,
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
    _contentController.dispose();
    super.dispose();
  }
}
