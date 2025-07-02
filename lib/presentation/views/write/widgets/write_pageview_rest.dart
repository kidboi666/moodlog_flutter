import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';

import '../../../../core/constants/common.dart';
import '../../../../router/routes.dart';
import '../../../view_models/write/write_viewmodel.dart';
import 'ai_enable_card.dart';
import 'content_input.dart';
import 'image_picking_section.dart';

class WritePageViewRest extends StatefulWidget {
  final WriteViewModel viewModel;

  const WritePageViewRest({super.key, required this.viewModel});

  @override
  State<WritePageViewRest> createState() => _WritePageViewRestState();
}

class _WritePageViewRestState extends State<WritePageViewRest> {
  late TextEditingController _contentController;

  void _listener() {
    if (widget.viewModel.isSubmitted) {
      context.go(
        Routes.journal(widget.viewModel.submittedJournalId.toString()),
        extra: {'source': 'write'},
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
    _contentController.addListener(() {
      widget.viewModel.updateContent(_contentController.text);
    });
    widget.viewModel.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.containerHorizontalPadding,
      child: Column(
        spacing: 28,
        children: [
          FadeIn(
            delay: DelayMs.quick,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ImagePickingSection(viewModel: widget.viewModel),
                ),
                TextButton(
                  child: Row(
                    spacing: 8,
                    children: [
                      Text(
                        widget.viewModel.selectedDate
                            .formattedDotNationWithTime(),
                      ),
                      Icon(Icons.calendar_month),
                    ],
                  ),
                  onPressed: () => widget.viewModel.selectDate(context),
                ),
              ],
            ),
          ),
          FadeIn(
            delay: DelayMs.quick * 2,
            child: ContentInput(
              viewModel: widget.viewModel,
              contentController: _contentController,
            ),
          ),
          FadeIn(
            delay: DelayMs.quick * 3,
            child: AiEnableCard(viewModel: widget.viewModel),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    widget.viewModel.removeListener(_listener);
    super.dispose();
  }
}
