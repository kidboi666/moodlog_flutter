import 'package:flutter/material.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';

class MoodMarkers extends StatelessWidget {
  final List<Journal> journals;

  const MoodMarkers({super.key, required this.journals});

  @override
  Widget build(BuildContext context) {
    if (journals.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: journals
          .take(3)
          .map(
            (journal) => Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(journal.moodType.colorValue),
              ),
            ),
          )
          .toList(),
    );
  }
}
