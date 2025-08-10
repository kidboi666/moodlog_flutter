import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/enum.dart';
import '../../../core/extensions/widget_scale.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../statistics/statistics_viewmodel.dart';

class RepresentativeMoodCard extends StatelessWidget {
  const RepresentativeMoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<StatisticsViewModel>();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    final representativeMood = context.select<StatisticsViewModel, MoodType?>(
      (vm) => vm.representativeMood,
    );

    if (representativeMood == null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Roundness.card),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.3)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surfaceContainer,
              colorScheme.surfaceContainer.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Roundness.card),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.surfaceContainer.withValues(alpha: 0.2),
                        colorScheme.surfaceContainer.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.surfaceContainer.withValues(alpha: 0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.surfaceContainer.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Spacing.sm),
                          decoration: BoxDecoration(
                            color: colorScheme.surface.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(
                              Roundness.button,
                            ),
                            border: Border.all(
                              color: colorScheme.outline.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Icon(
                            Icons.sentiment_neutral,
                            size: 20,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: Spacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.home_representative_mood_title,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: Spacing.xs),
                              Text(
                                t.home_representative_mood_empty,
                                style: textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: viewModel.refreshRepresentativeMood,
                          child: Container(
                            padding: const EdgeInsets.all(Spacing.sm),
                            decoration: BoxDecoration(
                              color: colorScheme.surface.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(
                                Roundness.button,
                              ),
                              border: Border.all(
                                color: colorScheme.outline.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            child: Icon(
                              Icons.refresh,
                              size: 20,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ).scale(),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.md,
                        vertical: Spacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit_note,
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: Spacing.xs),
                          Text(
                            t.home_representative_mood_empty_description,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    final moodColor = Color(representativeMood.colorValue);
    final isLightColor = viewModel.isLightColor(moodColor);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Roundness.card),
        border: BoxBorder.all(color: moodColor.withValues(alpha: 0.6)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            moodColor.withValues(alpha: 0.3),
            moodColor.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Roundness.card),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        moodColor.withValues(alpha: 0.2),
                        moodColor.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: moodColor.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: moodColor.withValues(alpha: 0.08),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(Spacing.sm),
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(Roundness.button),
                          border: Border.all(
                            color: moodColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          representativeMood.emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: Spacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.home_representative_mood_title,
                              style: textTheme.bodyMedium?.copyWith(
                                color: isLightColor
                                    ? colorScheme.onSurface.withValues(
                                        alpha: 0.7,
                                      )
                                    : colorScheme.onSurface.withValues(
                                        alpha: 0.8,
                                      ),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: Spacing.xs),
                            Text(
                              representativeMood.getDisplayName(context),
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isLightColor
                                    ? colorScheme.onSurface
                                    : colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => viewModel.refreshRepresentativeMood(),
                        child: Container(
                          padding: const EdgeInsets.all(Spacing.sm),
                          decoration: BoxDecoration(
                            color: colorScheme.surface.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(
                              Roundness.button,
                            ),
                            border: Border.all(
                              color: moodColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Icon(Icons.refresh, size: 20),
                        ),
                      ).scale(),
                    ],
                  ),
                  const SizedBox(height: Spacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.md,
                      vertical: Spacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(Roundness.xl),
                      border: Border.all(
                        color: moodColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome, size: 16, color: moodColor),
                        const SizedBox(width: Spacing.xs),
                        Text(
                          t.home_representative_mood_description,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
