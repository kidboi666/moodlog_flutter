import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../view_models/settings/settings_viewmodel.dart';

class InitDatabaseDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const InitDatabaseDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('데이터베이스 초기화'),
      content: const Text('SQLite 데이터베이스를 초기화합니다.'),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('취소')),
        FilledButton(
          onPressed: () {
            viewModel.clearDatabase();
            context.pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          child: const Text('초기화'),
        ),
      ],
    );
  }
}
