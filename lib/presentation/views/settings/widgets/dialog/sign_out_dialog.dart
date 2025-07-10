import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../view_models/settings/settings_viewmodel.dart';

class SignOutDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const SignOutDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('로그아웃'),
      content: const Text('로그아웃 합니다.'),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('취소')),
        ElevatedButton(
          onPressed: () {
            // viewModel.signOut();
            context.pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}
