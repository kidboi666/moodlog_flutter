import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/presentation/screens/journal/journal_view_model.dart';
import 'package:moodlog/presentation/screens/journal/widgets/cover_image_button.dart';
import 'package:moodlog/presentation/widgets/image_screen_with_button.dart';

class JournalCoverImage extends StatelessWidget {
  final JournalViewModel viewModel;
  final bool isVisibleImage;

  JournalCoverImage({
    super.key,
    required this.viewModel,
    required this.isVisibleImage,
  });

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final journal = viewModel.journal;

    if (journal == null) {
      return const SizedBox.shrink();
    }

    return Offstage(
      offstage: !isVisibleImage,
      child: SizedBox(
        height: mediaQuery.size.width - (Spacing.lg * 2),
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          children: [
            ...journal.imageUri?.map(
                  (image) => ImageScreenWithButton(
                    image: image,
                    button: CoverImageButton(image: image),
                    journalId: journal.id,
                  ),
                ) ??
                [],
          ],
        ),
      ),
    );
  }
}
