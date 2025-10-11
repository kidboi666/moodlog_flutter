import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/localization.dart';
import '../../../core/ui/widgets/tag_section.dart';
import '../../../domain/entities/journal/journal.dart';
import '../../../domain/use_cases/weather_use_case.dart';
import '../journal_view_model.dart';
import 'journal_cover_image.dart';
import 'location_card.dart';

class ContentBox extends StatefulWidget {
  final JournalViewModel viewModel;
  final SimpleTextAlign currentAlign;

  const ContentBox({
    super.key,
    required this.viewModel,
    required this.currentAlign,
  });

  @override
  State<ContentBox> createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> {
  bool get _hasWeatherData {
    final journal = widget.viewModel.journal;
    if (journal == null) return false;

    return journal.temperature != null &&
        journal.weatherIcon != null &&
        journal.weatherDescription != null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final journal = widget.viewModel.journal;

    if (journal == null) {
      return const SizedBox.shrink();
    }

    final isVisibleImage = journal.imageUri?.isNotEmpty ?? false;

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
                  mainAxisAlignment: widget.currentAlign.mainAxisAlignment,
                  children: [
                    Text(
                      journal.moodType.getDisplayName(context),
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(width: Spacing.sm),
                    Text(journal.moodType.emoji, style: textTheme.titleLarge),
                    if (_hasWeatherData) ...[
                      const SizedBox(width: Spacing.md),
                      _buildWeatherInfo(context, textTheme, journal),
                    ],
                  ],
                ),
                LocationCard(
                  viewModel: widget.viewModel,
                  currentAlign: widget.currentAlign,
                ),
              ],
            ),
          ),
          JournalCoverImage(
            viewModel: widget.viewModel,
            isVisibleImage: isVisibleImage,
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: Spacing.md),
              child: Column(
                crossAxisAlignment: widget.currentAlign.crossAxisAlignment,
                children: [
                  _buildContentDisplay(journal.content, textTheme),
                  if (journal.tags != null && journal.tags!.isNotEmpty) ...[
                    const SizedBox(height: Spacing.lg),
                    TagSection(
                      tags: journal.tags!,
                      textAlign: widget.currentAlign,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentDisplay(String? content, TextTheme textTheme) {
    if (content == null || content.isEmpty) {
      return const SizedBox.shrink();
    }

    // 마크다운 스타일을 적용하여 텍스트를 표시
    return SelectableText.rich(
      TextSpan(
        children: _parseMarkdownToTextSpans(content, textTheme),
      ),
      textAlign: widget.currentAlign.textAlign,
      style: textTheme.bodyMedium,
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



  Widget _buildWeatherInfo(
    BuildContext context,
    TextTheme textTheme,
    Journal journal,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final weatherUseCase = context.read<WeatherUseCase>();
    final condition = weatherUseCase.getWeatherCondition(journal.weatherIcon!);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(condition.icon, style: textTheme.titleMedium),
        const SizedBox(width: Spacing.xs),
        Text(
          '${journal.temperature!.round()}°C',
          style: textTheme.titleMedium?.copyWith(color: colorScheme.secondary),
        ),
      ],
    );
  }
}
