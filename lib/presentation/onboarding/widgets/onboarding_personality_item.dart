import 'package:flutter/material.dart';
import 'package:moodlog/common/extensions/widget_scale.dart';

import '../../../../common/constants/enum.dart';
import '../../../../common/extensions/enum.dart';

class PersonalityItem extends StatelessWidget {
  final AiPersonality personality;
  final bool isSelected;
  final AiPersonality? selectedPersonality;
  final Function setPersonality;

  const PersonalityItem({
    super.key,
    required this.personality,
    required this.isSelected,
    required this.selectedPersonality,
    required this.setPersonality,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      color: isSelected ? colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: () => setPersonality(personality),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 20,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 20.0,
                ),
                child: Text(personality.emoji, style: textTheme.titleLarge),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      personality.getTitle(context),
                      style: textTheme.titleMedium,
                    ),
                    Text(personality.getDescription(context)),
                  ],
                ),
              ),
              Radio(
                value: personality,
                groupValue: selectedPersonality,
                onChanged: (Object? value) => setPersonality(value),
              ),
            ],
          ),
        ),
      ),
    ).scale();
  }
}
