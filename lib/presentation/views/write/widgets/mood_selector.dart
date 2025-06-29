import 'package:flutter/material.dart';
import 'package:moodlog/presentation/view_models/write/write_viewmodel.dart';

import '../../../../core/constants/enum.dart';

class MoodSelector extends StatefulWidget {
  final WriteViewModel viewModel;
  final MoodType? selectedMood;
  final Function(MoodType mood) onMoodSelected;

  const MoodSelector({
    super.key,
    required this.viewModel,
    this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘 기분은 어떠신가요?',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) {
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: MoodType.values.map((mood) {
                final isSelected = widget.selectedMood == mood;
                return GestureDetector(
                  onTap: () => widget.onMoodSelected(mood),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Color(mood.colorValue).withValues(alpha: 0.2)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? Color(mood.colorValue)
                            : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(mood.emoji, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Text(
                          mood.name,
                          style: TextStyle(
                            color: isSelected
                                ? Color(mood.colorValue)
                                : Colors.grey[700],
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
