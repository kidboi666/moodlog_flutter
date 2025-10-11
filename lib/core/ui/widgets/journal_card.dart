import 'dart:io';

import 'package:flutter/material.dart';


import '../../constants/common.dart';
import '../../constants/enum.dart';
import '../../extensions/date_time.dart';
import '../../extensions/widget.dart';
import '../../l10n/app_localizations.dart';

class JournalCard extends StatelessWidget {
  final int id;
  final String content;
  final MoodType moodType;
  final String? coverImg;
  final DateTime createdAt;
  final void Function() onTap;
  final void Function() onDismissed;

  const JournalCard({
    super.key,
    required this.id,
    required this.content,
    required this.moodType,
    required this.createdAt,
    required this.onTap,
    required this.onDismissed,
    this.coverImg,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Roundness.card),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(Roundness.card),
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.xl,
                  vertical: Spacing.xl,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Mood color indicator
                    Container(
                      width: Spacing.sm,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Roundness.card),
                        color: Color(moodType.colorValue),
                      ),
                    ),
                    const SizedBox(width: Spacing.lg),

                    // Content section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            createdAt.formatted(t),
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.outline,
                            ),
                          ),
                          const SizedBox(height: Spacing.xs),
                          _buildContentPreview(content.trim(), textTheme),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (coverImg != null && coverImg!.isNotEmpty) ...[
              _buildCoverImage(context),
            ],
          ],
        ),
      ),
    ).scale();
  }

  Widget _buildCoverImage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Image.file(
      File(coverImg!),
      height: 120,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(Roundness.xs),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                color: colorScheme.outline,
                size: 32,
              ),
              const SizedBox(height: 4),
              Text(
                'Image not found',
                style: TextStyle(color: colorScheme.outline, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContentPreview(String content, TextTheme textTheme) {
    if (content.isEmpty) {
      return const SizedBox.shrink();
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 0,
        maxHeight: 100, // 카드에서는 높이 제한
      ),
      child: Text.rich(
        TextSpan(
          children: _parseMarkdownToTextSpans(content, textTheme),
        ),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium,
      ),
    );
  }

  List<TextSpan> _parseMarkdownToTextSpans(String text, TextTheme textTheme) {
    final List<TextSpan> spans = [];
    final RegExp exp = RegExp(
        r'(\*\*.*?\*\*)|(__.*?__)|(~~.*?~~)|(\*.*?\*)',
        caseSensitive: false);
    int currentPosition = 0;

    for (RegExpMatch match in exp.allMatches(text)) {
      if (match.start > currentPosition) {
        spans.add(TextSpan(text: text.substring(currentPosition, match.start)));
      }

      String matchedText = match.group(0)!;
      TextStyle? style = textTheme.bodyMedium;

      if (matchedText.startsWith('**') && matchedText.endsWith('**')) {
        style = style?.copyWith(fontWeight: FontWeight.bold);
        matchedText = matchedText.substring(2, matchedText.length - 2);
      } else if (matchedText.startsWith('__') && matchedText.endsWith('__')) {
        style = style?.copyWith(decoration: TextDecoration.underline);
        matchedText = matchedText.substring(2, matchedText.length - 2);
      } else if (matchedText.startsWith('~~') && matchedText.endsWith('~~')) {
        style = style?.copyWith(decoration: TextDecoration.lineThrough);
        matchedText = matchedText.substring(2, matchedText.length - 2);
      } else if (matchedText.startsWith('*') && matchedText.endsWith('*')) {
        style = style?.copyWith(fontStyle: FontStyle.italic);
        matchedText = matchedText.substring(1, matchedText.length - 1);
      }

      spans.add(TextSpan(text: matchedText, style: style));
      currentPosition = match.end;
    }

    if (currentPosition < text.length) {
      spans.add(TextSpan(text: text.substring(currentPosition)));
    }

    return spans;
  }


}
