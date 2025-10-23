import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';

class MoodBar extends StatelessWidget {
  final MoodType moodType;

  const MoodBar({super.key, required this.moodType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Spacing.md,
      decoration: BoxDecoration(
        color: Color(moodType.colorValue),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
    );
  }
}
