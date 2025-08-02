import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/extensions/routing.dart';
import '../../widgets/fade_in.dart';
import '../viewmodel/write_viewmodel.dart';
import 'ai_enable_card.dart';
import 'content_input.dart';
import 'date_button.dart';
import 'image_picking_section.dart';
import 'location_button.dart';
import 'location_card.dart';
import 'timestamp_button.dart';
import 'weather_card.dart';

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
          FadeIn(delay: DelayMs.quick, child: const ImagePickingSection()),

          Column(
            children: [
              FadeIn(
                delay: DelayMs.quick * 1.5,
                child: Row(
                  children: [
                    const LocationCard(),
                    const SizedBox(width: 8),
                    const LocationButton(),
                    TimestampButton(contentController: _contentController),
                    const DateButton(),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(delay: DelayMs.quick * 1, child: const WeatherCard()),
              FadeIn(
                delay: DelayMs.quick * 2,
                child: ContentInput(contentController: _contentController),
              ),
            ],
          ),
          const SizedBox(height: Spacing.xxl),
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
