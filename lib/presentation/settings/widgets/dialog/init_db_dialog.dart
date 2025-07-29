import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/data/data_source/database.dart';
import 'package:provider/provider.dart';

import '../../../../core/l10n/app_localizations.dart';

class InitDatabaseDialog extends StatelessWidget {
  const InitDatabaseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    
    return AlertDialog(
      title: Text(t.dialog_database_init_title),
      content: Text(t.dialog_database_init_content),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text(t.common_confirm_cancel)),
        FilledButton(
          onPressed: () {
            final db = context.read<MoodLogDatabase>();
            db.transaction(() async {
              for (final table in db.allTables) {
                await db.delete(table).go();
              }
            });
            context.pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.error,
            foregroundColor: theme.onError,
          ),
          child: Text(t.dialog_init_button),
        ),
      ],
    );
  }
}
