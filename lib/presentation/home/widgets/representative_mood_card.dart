import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/constants/enum.dart';
import '../../../common/extensions/enum.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/home_viewmodel.dart';

class RepresentativeMoodCard extends StatelessWidget {
  const RepresentativeMoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Selector<HomeViewModel, MoodType?>(
      selector: (_, viewModel) => viewModel.representativeMood,
      builder: (context, representativeMood, _) {
        if (representativeMood == null) {
          return const SizedBox.shrink();
        }

        final moodColor = Color(representativeMood.colorValue);
        final isLightColor = _isLightColor(moodColor);

        return Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // 블러 배경 효과
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

                // 장식용 원형 요소들
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

                // 메인 콘텐츠
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
                              borderRadius: BorderRadius.circular(12),
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
                            color: moodColor.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 16,
                              color: moodColor,
                            ),
                            const SizedBox(width: Spacing.xs),
                            Text(
                              t.home_representative_mood_description,
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
      },
    );
  }

  bool _isLightColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5;
  }
}
