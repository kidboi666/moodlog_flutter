import 'package:flutter/material.dart';

import '../../../core/constants/enum.dart';
import '../../../core/extensions/enum.dart';

class PersonalityItem extends StatelessWidget {
  final AiPersonality personality;
  final bool isSelected;
  final AiPersonality? selectedPersonality;
  final Function onPersonalityChanged;

  const PersonalityItem({
    super.key,
    required this.personality,
    required this.isSelected,
    required this.selectedPersonality,
    required this.onPersonalityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: () => onPersonalityChanged(personality),
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
                child: Text(
                  personality.getEmoji(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      personality.getTitle(context),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(personality.getDescription(context)),
                  ],
                ),
              ),
              Radio(
                value: personality,
                groupValue: selectedPersonality,
                onChanged: (Object? value) => onPersonalityChanged(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
