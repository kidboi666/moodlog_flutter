import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/widget.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final TextStyle? labelStyle;

  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style:
            labelStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
      side: isSelected
          ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
          : null,
    ).scale();
  }
}
