import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/router/routes.dart';

import '../../core/constants/enum.dart';
import '../../core/l10n/app_localizations.dart';

class JournalCard extends StatelessWidget {
  final int id;
  final String content;
  final MoodType moodType;
  final String? coverImg;
  final DateTime createdAt;

  const JournalCard({
    super.key,
    required this.id,
    required this.content,
    required this.moodType,
    required this.createdAt,
    this.coverImg,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacing.xl),
      ),
      child: InkWell(
        onTap: () =>
            context.push(Routes.journal(id), extra: {'source': 'home'}),
        borderRadius: BorderRadius.circular(Spacing.xl),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
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
            createdAt.formatted(AppLocalizations.of(context)!),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          subtitle: Text(
            content.trim(),
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 4,
          ),
          trailing: Icon(Icons.keyboard_arrow_left),
        ),
      ),
    );
  }
}
