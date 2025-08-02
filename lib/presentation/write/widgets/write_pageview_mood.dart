import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/common.dart';
import '../../../common/constants/enum.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';
import 'mood_button.dart';

class WritePageViewMood extends StatelessWidget {
  final Function nextPage;

  const WritePageViewMood({super.key, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: Spacing.containerHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.xxl,
        children: [
          FadeIn(
            delay: DelayMs.quick,
            child: Text(t.write_mood_title, style: textTheme.headlineMedium),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                spacing: Spacing.lg,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: MoodType.values.mapIndexed((index, mood) {
                  return FadeIn(
                    delay: DelayMs.quick * index + DelayMs.quick,
                    duration: DurationMs.lazy,
                    child: MoodButton(
                      mood: mood,
                      index: index,
                      nextPage: nextPage,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
