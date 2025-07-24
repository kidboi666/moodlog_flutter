import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../viewmodel/profile_viewmodel.dart';

class SignOutDialog extends StatelessWidget {
  final ProfileViewModel viewModel;

  const SignOutDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return AlertDialog(
      title: const Text('로그아웃'),
      content: const Text('로그아웃 하시겠습니까?'),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('취소')),
        FilledButton(
          onPressed: () {
            viewModel.signOut();
            context.pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorTheme.error,
            foregroundColor: colorTheme.onError,
          ),
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}
