import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants/enum.dart';
import '../../../../common/l10n/app_localizations.dart';
import '../mood_button.dart';

class MoodSelectionBottomSheet extends StatelessWidget {
  const MoodSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(t.write_mood_title, style: textTheme.headlineSmall),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: MoodType.values.length,
            itemBuilder: (context, index) {
              final mood = MoodType.values[index];
              return MoodButton(
                mood: mood,
                index: index,
                nextPage: () => context.pop(mood),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
