import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/data/data_source/database.dart';
import 'package:provider/provider.dart';

class InitDatabaseDialog extends StatelessWidget {
  const InitDatabaseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AlertDialog(
      title: const Text('데이터베이스 초기화'),
      content: const Text('SQLite 데이터베이스를 초기화합니다.'),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('취소')),
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
          child: const Text('초기화'),
        ),
      ],
    );
  }
}
