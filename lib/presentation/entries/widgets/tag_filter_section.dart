import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../entries_viewmodel.dart';

class TagFilterSection extends StatelessWidget {
  const TagFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Consumer<EntriesViewModel>(
      builder: (context, viewModel, child) {
        final bool hasFilters = viewModel.availableTags.isNotEmpty;

        if (!hasFilters) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 감정 필터 섹션
            Padding(
              padding: const EdgeInsets.only(left: Spacing.lg),
              child: Text(
                t.entries_mood_filter_title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: Spacing.sm),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: Spacing.lg),
                  _FilterChip(
                    label: t.tags_filter_all,
                    isSelected: viewModel.selectedMoodFilter == null,
                    onTap: () => viewModel.clearMoodFilter(),
                  ),
                  const SizedBox(width: Spacing.xs),
                  ...MoodType.values.map(
                    (mood) => Padding(
                      padding: const EdgeInsets.only(right: Spacing.xs),
                      child: _MoodFilterChip(
                        mood: mood,
                        isSelected: viewModel.selectedMoodFilter == mood,
                        onTap: () => viewModel.setMoodFilter(mood),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.md),

            // 태그 필터 섹션
            Padding(
              padding: const EdgeInsets.only(left: Spacing.lg),
              child: Text(
                t.tags_filter_title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: Spacing.sm),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: Spacing.lg),
                  _FilterChip(
                    label: t.tags_filter_all,
                    isSelected: viewModel.selectedTagFilter == null,
                    onTap: () => viewModel.clearTagFilter(),
                  ),
                  const SizedBox(width: Spacing.xs),
                  ...viewModel.availableTags.map(
                    (tag) => Padding(
                      padding: const EdgeInsets.only(right: Spacing.xs),
                      child: _FilterChip(
                        label: tag.name,
                        isSelected: viewModel.selectedTagFilter?.id == tag.id,
                        onTap: () => viewModel.setTagFilter(tag),
                        color: tag.color != null
                            ? Color(int.parse(tag.color!, radix: 16))
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? color;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: color ?? colorScheme.surfaceContainer,
      selectedColor: color ?? colorScheme.primaryContainer,
      checkmarkColor: isSelected
          ? colorScheme.onPrimaryContainer
          : colorScheme.onSurface,
    );
  }
}

class _MoodFilterChip extends StatelessWidget {
  final MoodType mood;
  final bool isSelected;
  final VoidCallback onTap;

  const _MoodFilterChip({
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(mood.emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text(mood.getDisplayName(context)),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: colorScheme.surfaceContainer,
      selectedColor: colorScheme.primaryContainer,
      checkmarkColor: isSelected
          ? colorScheme.onPrimaryContainer
          : colorScheme.onSurface,
    );
  }
}
