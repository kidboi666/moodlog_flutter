import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../view_models/settings/settings_viewmodel.dart';

class InitStorageDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const InitStorageDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('스토리지 초기화'),
      content: const Text('SharedPreferences를 초기화합니다.'),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('취소')),
        FilledButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          onPressed: () {
            viewModel.clearSharedPreferences();
            context.pop();
          },
          child: const Text('삭제'),
        ),
      ],
    );
  }
}
