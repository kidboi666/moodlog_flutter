import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/enum.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../write_view_model.dart';

class MoodSliderSelectionBottomSheet extends StatelessWidget {
  final WriteViewModel viewModel;

  const MoodSliderSelectionBottomSheet({super.key, required this.viewModel});

  double _getCurrentValue(MoodType mood) => mood.sliderValue;

  void _changeMood(BuildContext context, double value) {
    final nextMood = MoodType.fromSlider(value);
    viewModel.updateMoodType(nextMood);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(t.write_mood_title, style: textTheme.headlineSmall),
              const SizedBox(height: 30),

              // 현재 선택된 감정 이모티콘 (크게 표시)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Color(
                    viewModel.selectedMood.colorValue,
                  ).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(
                      viewModel.selectedMood.colorValue,
                    ).withValues(alpha: 0.8),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(
                        viewModel.selectedMood.colorValue,
                      ).withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      viewModel.selectedMood.emoji,
                      key: ValueKey(viewModel.selectedMood),
                      style: TextStyle(
                        fontSize: 64,
                        shadows: [
                          Shadow(
                            color: Color(
                              viewModel.selectedMood.colorValue,
                            ).withValues(alpha: 0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 감정 이름
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  viewModel.selectedMood.getDisplayName(context),
                  key: ValueKey(viewModel.selectedMood),
                  style: textTheme.titleLarge?.copyWith(
                    color: Color(viewModel.selectedMood.colorValue),
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: Color(
                          viewModel.selectedMood.colorValue,
                        ).withValues(alpha: 0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // 슬라이더
              Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Color(
                        viewModel.selectedMood.colorValue,
                      ),
                      inactiveTrackColor: colorScheme.outline.withValues(
                        alpha: 0.3,
                      ),
                      thumbColor: Color(viewModel.selectedMood.colorValue),
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 16,
                      ),
                      overlayColor: Color(
                        viewModel.selectedMood.colorValue,
                      ).withValues(alpha: 0.2),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 28,
                      ),
                      trackHeight: 8,
                    ),
                    child: Slider(
                      value: _getCurrentValue(viewModel.selectedMood),
                      min: 0,
                      max: 4,
                      divisions: 4,
                      onChanged: (value) => _changeMood(context, value),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 감정 라벨들
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildEmotionLabel(context, MoodType.verySad, viewModel),
                      _buildEmotionLabel(context, MoodType.sad, viewModel),
                      _buildEmotionLabel(context, MoodType.neutral, viewModel),
                      _buildEmotionLabel(context, MoodType.happy, viewModel),
                      _buildEmotionLabel(
                        context,
                        MoodType.veryHappy,
                        viewModel,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 확인 버튼
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.pop(viewModel.selectedMood),
                  child: Text(
                    t.common_confirm_ok,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmotionLabel(
    BuildContext context,
    MoodType mood,
    WriteViewModel viewModel,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = viewModel.selectedMood == mood;

    return GestureDetector(
      onTap: () {
        viewModel.updateMoodType(mood);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(mood.colorValue).withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Color(mood.colorValue) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mood.emoji,
              style: TextStyle(
                fontSize: 24,
                shadows: isSelected
                    ? [
                        Shadow(
                          color: Color(mood.colorValue).withValues(alpha: 0.5),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              mood.getDisplayName(context),
              style: TextStyle(
                fontSize: 10,
                color: isSelected
                    ? Color(mood.colorValue)
                    : colorScheme.outline,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
