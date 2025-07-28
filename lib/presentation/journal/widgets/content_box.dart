import 'package:flutter/material.dart';
import 'package:moodlog/presentation/journal/widgets/location_card.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/enum.dart';
import '../viewmodel/journal_viewmodel.dart';
import 'journal_cover_image.dart';

class ContentBox extends StatelessWidget {
  final JournalViewModel viewModel;
  final SimpleTextAlign currentAlign;

  const ContentBox({
    super.key,
    required this.viewModel,
    required this.currentAlign,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isVisibleImage = viewModel.journal.imageUri?.isNotEmpty ?? false;

    return Expanded(
      child: Column(
        spacing: Spacing.xl,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: Spacing.md),
            child: Column(
              spacing: Spacing.sm,
              children: [
                Row(
                  mainAxisAlignment: currentAlign.mainAxisAlignment,
                  children: [
                    Text(
                      viewModel.journal.moodType.getDisplayName(context),
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(width: Spacing.sm),
                    Text(
                      viewModel.journal.moodType.emoji,
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
                LocationCard(viewModel: viewModel, currentAlign: currentAlign),
              ],
            ),
          ),
          JournalCoverImage(
            viewModel: viewModel,
            isVisibleImage: isVisibleImage,
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
