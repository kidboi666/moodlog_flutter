import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/localization.dart';

class MoodSliderWidget extends StatelessWidget {
  final MoodType selectedMood;
  final ValueChanged<MoodType> onMoodChanged;
  final bool expandContent;

  const MoodSliderWidget({
    super.key,
    required this.selectedMood,
    required this.onMoodChanged,
    this.expandContent = false,
  });

  double _getCurrentValue(MoodType mood) => mood.sliderValue;

  void _changeMood(double value) {
    final nextMood = MoodType.fromSlider(value);
    onMoodChanged(nextMood);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final emotionDisplay = AnimatedContainer(
      duration: DurationMS.quick,
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(selectedMood.colorValue).withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: DurationMS.quick,
          child: Text(
            selectedMood.getDisplayName(context),
            key: ValueKey(selectedMood),
            style: textTheme.displaySmall?.copyWith(
              color: Color(selectedMood.colorValue),
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: Color(selectedMood.colorValue).withValues(alpha: 0.3),
                  blurRadius: 4,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (expandContent)
          Expanded(child: Center(child: emotionDisplay))
        else
          emotionDisplay,
        CommonSizedBox.heightXl,
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color(selectedMood.colorValue),
            inactiveTrackColor: colorScheme.outline.withValues(alpha: 0.3),
            thumbColor: Color(selectedMood.colorValue),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16),
            overlayColor: Color(selectedMood.colorValue).withValues(alpha: 0.2),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 28),
            trackHeight: 8,
          ),
          child: Slider(
            value: _getCurrentValue(selectedMood),
            min: 0,
            max: 4,
            divisions: 4,
            onChanged: _changeMood,
          ),
        ),
      ],
    );
  }
}
