import 'package:dotted_border/dotted_border.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
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

                Visibility(
                  visible:
                      viewModel.journal.latitude != null &&
                      viewModel.journal.longitude != null,
                  child: Row(
                    mainAxisAlignment: currentAlign.mainAxisAlignment,
                    children: [
                      DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          radius: Radius.circular(12),
                          dashPattern: [10, 5],
                          strokeWidth: 2,
                          color: colorScheme.outlineVariant,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spacing.md,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 18,
                                color: colorScheme.outlineVariant,
                              ),
                              Text(
                                viewModel.journal.address ??
                                    '${viewModel.journal.latitude?.toStringAsFixed(2) ?? '0.00'}, ${viewModel.journal.longitude?.toStringAsFixed(2) ?? '0.00'}',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.outline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
