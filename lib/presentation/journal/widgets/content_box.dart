import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/enum.dart';
import '../../../core/ui/widgets/tag_section.dart';
import '../../../domain/entities/journal/journal.dart';
import '../../../domain/repositories/weather_repository.dart';
import '../journal_viewmodel.dart';
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
                  Text(
                    journal.content ?? '',
                    style: textTheme.bodyLarge,
                    textAlign: widget.currentAlign.textAlign,
                  ),
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

  Widget _buildWeatherInfo(
    BuildContext context,
    TextTheme textTheme,
    Journal journal,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final weatherRepository = context.read<WeatherRepository>();
    final condition = weatherRepository.getWeatherCondition(
      journal.weatherIcon!,
    );

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
