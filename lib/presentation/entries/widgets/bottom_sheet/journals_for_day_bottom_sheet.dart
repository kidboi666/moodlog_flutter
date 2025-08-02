import 'package:flutter/material.dart';

import '../../../../common/constants/common.dart';
import '../../../../common/extensions/date_time.dart';
import '../../../../common/l10n/app_localizations.dart';
import '../../../../domain/entities/journal.dart';
import '../journal_tile.dart';

class JournalsForDayBottomSheet extends StatelessWidget {
  final DateTime day;
  final List<Journal> journals;

  const JournalsForDayBottomSheet({
    super.key,
    required this.day,
    required this.journals,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.6,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: Spacing.md),
            decoration: BoxDecoration(
              color: colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            child: Row(
              children: [
                Text(
                  day.formattedLocalizedFullDate(t),
                  style: textTheme.titleLarge,
                ),
                const Spacer(),
                Text(
                  t.journal_count(journals.length),
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.lg),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
              itemCount: journals.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: Spacing.md),
              itemBuilder: (context, index) {
                final journal = journals[index];
                return JournalTile(journal: journal);
              },
            ),
          ),
        ],
      ),
    );
  }
}
