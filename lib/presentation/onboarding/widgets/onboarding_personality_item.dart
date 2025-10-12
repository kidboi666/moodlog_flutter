import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/localization.dart';
import 'package:moodlog/core/extensions/widget.dart';

class OnboardingPersonalityItem extends StatelessWidget {
  final AiPersonality personality;

  const OnboardingPersonalityItem({super.key, required this.personality});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: personality,
      controlAffinity: ListTileControlAffinity.trailing,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      secondary: Text(
        personality.emoji,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      title: Text(
        personality.getTitle(context),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(),
      ),
      subtitle: Text(
        personality.getDescription(context),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
      ),
    ).scale();
  }
}
