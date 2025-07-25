import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/enum.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../widgets/image_screen_with_button.dart';
import '../viewmodel/journal_viewmodel.dart';
import 'cover_image_button.dart';

class ContentBox extends StatelessWidget {
  final JournalViewModel viewModel;
  final SimpleTextAlign currentAlign;

  ContentBox({super.key, required this.viewModel, required this.currentAlign});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final isVisibleImage = viewModel.journal.imageUri?.isNotEmpty ?? false;
    return Expanded(
      child: Column(
        spacing: Spacing.xl,
        children: [
          SizedBox(
            width: double.infinity,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: viewModel.journal.moodType.getDisplayName(context),
                style: textTheme.titleLarge,
                children: [
                  TextSpan(text: ' '),
                  TextSpan(text: viewModel.journal.moodType.emoji),
                ],
              ),
            ),
          ),
          Offstage(
            offstage: !isVisibleImage,
            child: SizedBox(
              height: mediaQuery.size.width - (Spacing.lg * 2),
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: [
                  ...viewModel.journal.imageUri?.map(
                        (image) => ImageScreenWithButton(
                          image: image,
                          button: CoverImageButton(image: image),
                        ),
                      ) ??
                      [],
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: Spacing.md),
              child: Text(
                viewModel.journal.content ?? '',
                style: textTheme.bodyLarge,
                textAlign: currentAlign.textAlign,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
