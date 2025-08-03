import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/constants/enum.dart';
import '../../../common/extensions/enum.dart';
import '../../../domain/repositories/weather_repository.dart';
import '../viewmodel/journal_viewmodel.dart';
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
    return journal.temperature != null &&
        journal.weatherIcon != null &&
        journal.weatherDescription != null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isVisibleImage =
        widget.viewModel.journal.imageUri?.isNotEmpty ?? false;

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
                      widget.viewModel.journal.moodType.getDisplayName(context),
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(width: Spacing.sm),
                    Text(
                      widget.viewModel.journal.moodType.emoji,
                      style: textTheme.titleLarge,
                    ),
                    if (_hasWeatherData) ...[
                      const SizedBox(width: Spacing.md),
                      _buildWeatherInfo(context, textTheme),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.viewModel.journal.content ?? '',
                    style: textTheme.bodyLarge,
                    textAlign: widget.currentAlign.textAlign,
                  ),
                  if (widget.viewModel.journal.tags != null &&
                      widget.viewModel.journal.tags!.isNotEmpty) ...[
                    const SizedBox(height: Spacing.lg),
                    _buildTagsSection(context, textTheme),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(BuildContext context, TextTheme textTheme) {
    final colorScheme = Theme.of(context).colorScheme;
    final journal = widget.viewModel.journal;
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

  Widget _buildTagsSection(BuildContext context, TextTheme textTheme) {
    final colorScheme = Theme.of(context).colorScheme;
    final tags = widget.viewModel.journal.tags!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags',
          style: textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: Spacing.sm),
        Wrap(
          spacing: Spacing.sm,
          runSpacing: Spacing.sm,
          children: tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.sm,
                vertical: Spacing.xs,
              ),
              decoration: BoxDecoration(
                color: tag.color != null
                    ? Color(int.parse(tag.color!.replaceFirst('#', '0x')))
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                tag.name,
                style: textTheme.bodySmall?.copyWith(
                  color: tag.color != null
                      ? Colors.white
                      : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
