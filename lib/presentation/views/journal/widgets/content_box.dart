import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/constants/enum.dart';
import '../../../view_models/journal/journal_viewmodel.dart';
import 'cover_image.dart';

class ContentBox extends StatelessWidget {
  final JournalViewModel viewModel;
  final SimpleTextAlign currentAlign;

  ContentBox({super.key, required this.viewModel, required this.currentAlign});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
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
                text: viewModel.journal.moodType.name,
                style: Theme.of(context).textTheme.titleLarge,
                children: [TextSpan(text: viewModel.journal.moodType.emoji)],
              ),
            ),
          ),
          Offstage(
            offstage: !isVisibleImage,
            child: SizedBox(
              height: MediaQuery.of(context).size.width - (Spacing.lg * 2),
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: [
                  ...viewModel.journal.imageUri?.map(
                        (image) => CoverImage(image: image),
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
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: currentAlign.textAlign,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
