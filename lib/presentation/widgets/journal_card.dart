import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/router/routes.dart';

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

  void _goToJournal(BuildContext context) {
    context.push(Routes.journal(id), extra: {'source': 'home'});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.surfaceBright,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: () => _goToJournal(context),
        borderRadius: BorderRadius.circular(20.0),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
          leading: Container(
            width: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.red,
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
