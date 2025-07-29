import 'package:flutter/material.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../core/extensions/date_time.dart';
import '../../core/extensions/widget_scale.dart';
import '../../core/l10n/app_localizations.dart';

class JournalCard extends StatelessWidget {
  final int id;
  final String content;
  final MoodType moodType;
  final String? coverImg;
  final DateTime createdAt;
  final void Function() onTap;
  final void Function() onDismissed;

  const JournalCard({
    super.key,
    required this.id,
    required this.content,
    required this.moodType,
    required this.createdAt,
    required this.onTap,
    required this.onDismissed,
    this.coverImg,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        onDismissed();
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: InkResponse(
          containedInkWell: true,
          child: ListTile(
            onTap: onTap,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Spacing.xxl,
              vertical: Spacing.md,
            ),
            leading: Container(
              width: Spacing.sm,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Spacing.xl),
                color: Color(moodType.colorValue),
              ),
            ),
            title: Text(
              createdAt.formatted(t),
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            ),
            subtitle: Text(
              content.trim(),
              style: textTheme.bodyLarge,
              maxLines: 4,
            ),
            trailing: Icon(Icons.keyboard_arrow_left),
          ),
        ),
      ).scale(),
    );
  }
}
