import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/routing/routes.dart';

class ImageScreenWithButton extends StatelessWidget {
  final String? image;
  final Widget button;
  final int? journalId;

  const ImageScreenWithButton({
    super.key,
    this.image,
    required this.button,
    this.journalId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (image != null && journalId != null) {
          final heroTag = 'journal_image_${journalId}_${image.hashCode}';
          context.push(
            Routes.journalImageDetail(journalId!),
            extra: {'imageUrl': image!, 'heroTag': heroTag},
          );
        }
      },
      child: journalId != null && image != null
          ? Hero(
              tag: 'journal_image_${journalId}_${image.hashCode}',
              child: button,
            )
          : button,
    ).scale();
  }
}
