import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/entries_viewmodel.dart';

class TagFilterSection extends StatelessWidget {
  const TagFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Consumer<EntriesViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.availableTags.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
