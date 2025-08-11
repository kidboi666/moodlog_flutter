import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import '../../../core/ui/widgets/image_screen_with_button.dart';
import '../journal_viewmodel.dart';
import 'cover_image_button.dart';

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
    return Offstage(
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
    );
  }
}
