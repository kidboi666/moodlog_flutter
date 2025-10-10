import 'package:flutter/material.dart';

import '../../../../core/extensions/localization.dart';
import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/widget.dart';

class PersonalityItem extends StatelessWidget {
  final AiPersonality personality;
  final bool isSelected;

  const PersonalityItem({
    super.key,
    required this.personality,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return RadioListTile(
      value: personality,
      selected: isSelected,
      selectedTileColor: colorScheme.primaryContainer,
      tileColor: colorScheme.surface,
      controlAffinity: ListTileControlAffinity.trailing,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      secondary: Text(personality.emoji, style: textTheme.titleLarge),
      title: Row(
        spacing: Spacing.md,
        children: [
          Text(
            personality.getTitle(context),
            style: textTheme.titleMedium?.copyWith(
              color: isSelected ? colorScheme.onPrimaryContainer : null,
            ),
          ),
        ],
      ),
      subtitle: Text(
        personality.getDescription(context),
        style: textTheme.bodyMedium?.copyWith(
          color: isSelected ? colorScheme.onPrimaryContainer : null,
        ),
      ),
    ).scale();
  }
}
