import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class ActivityItem extends StatelessWidget {
  final String date;
  final String note;
  final String emoji;

  const ActivityItem({
    super.key,
    required this.date,
    required this.note,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Display emoji instead of icon
          Text(emoji, style: TextStyle(fontSize: 24)),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(note, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
