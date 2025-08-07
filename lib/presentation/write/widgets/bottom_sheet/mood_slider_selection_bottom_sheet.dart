import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/common/extensions/enum.dart';

import '../../../../common/constants/enum.dart';
import '../../../../common/l10n/app_localizations.dart';

class MoodSliderSelectionBottomSheet extends StatefulWidget {
  const MoodSliderSelectionBottomSheet({super.key});

  @override
  State<MoodSliderSelectionBottomSheet> createState() =>
      _MoodSliderSelectionBottomSheetState();
}

class _MoodSliderSelectionBottomSheetState
    extends State<MoodSliderSelectionBottomSheet> {
  double _currentValue = 2.0; // 기본값은 중립 (neutral)

  MoodType get _currentMood {
    switch (_currentValue.round()) {
      case 0:
        return MoodType.verySad;
      case 1:
        return MoodType.sad;
      case 2:
        return MoodType.neutral;
      case 3:
        return MoodType.happy;
      case 4:
        return MoodType.veryHappy;
      default:
        return MoodType.neutral;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
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
              color: Color(_currentMood.colorValue).withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(_currentMood.colorValue).withValues(alpha: 0.8),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(_currentMood.colorValue).withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  _currentMood.emoji,
                  key: ValueKey(_currentMood),
                  style: TextStyle(
                    fontSize: 64,
                    shadows: [
                      Shadow(
                        color: Color(_currentMood.colorValue).withValues(alpha: 0.5),
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
              _currentMood.getDisplayName(context),
              key: ValueKey(_currentMood),
              style: textTheme.titleLarge?.copyWith(
                color: Color(_currentMood.colorValue),
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    color: Color(_currentMood.colorValue).withValues(alpha: 0.3),
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
                  activeTrackColor: Color(_currentMood.colorValue),
                  inactiveTrackColor: colorScheme.outline.withValues(
                    alpha: 0.3,
                  ),
                  thumbColor: Color(_currentMood.colorValue),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 16,
                  ),
                  overlayColor: Color(_currentMood.colorValue).withValues(alpha: 0.2),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 28,
                  ),
                  trackHeight: 8,
                ),
                child: Slider(
                  value: _currentValue,
                  min: 0,
                  max: 4,
                  divisions: 4,
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),

              // 감정 라벨들
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildEmotionLabel(context, MoodType.verySad),
                  _buildEmotionLabel(context, MoodType.sad),
                  _buildEmotionLabel(context, MoodType.neutral),
                  _buildEmotionLabel(context, MoodType.happy),
                  _buildEmotionLabel(context, MoodType.veryHappy),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),

          // 확인 버튼
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context.pop(_currentMood),
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
  }

  Widget _buildEmotionLabel(BuildContext context, MoodType mood) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = _currentMood == mood;
    
    // 슬라이더 값에 맞는 인덱스로 변환
    final moodValue = switch (mood) {
      MoodType.verySad => 0.0,
      MoodType.sad => 1.0,
      MoodType.neutral => 2.0,
      MoodType.happy => 3.0,
      MoodType.veryHappy => 4.0,
    };

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentValue = moodValue;
        });
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
            color: isSelected 
                ? Color(mood.colorValue)
                : Colors.transparent,
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
                shadows: isSelected ? [
                  Shadow(
                    color: Color(mood.colorValue).withValues(alpha: 0.5),
                    blurRadius: 8,
                  ),
                ] : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              mood.getDisplayName(context),
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Color(mood.colorValue) : colorScheme.outline,
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
