import 'package:flutter/material.dart';

import '../../../../core/extensions/localization.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/widget.dart';

class OnboardingPersonalityItem extends StatelessWidget {
  final AiPersonality personality;

  const OnboardingPersonalityItem({super.key, required this.personality});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return RadioListTile<AiPersonality>(
      value: personality,
      tileColor: colorScheme.surfaceContainer,
      controlAffinity: ListTileControlAffinity.trailing,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      secondary: Text(personality.emoji, style: textTheme.titleLarge),
      title: Text(
        personality.getTitle(context),
        style: textTheme.titleMedium?.copyWith(),
      ),
      subtitle: Text(
        personality.getDescription(context),
        style: textTheme.bodyMedium?.copyWith(),
      ),
    ).scale();
  }
}
