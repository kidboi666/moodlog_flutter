import 'package:flutter/material.dart';
import 'package:moodlog/presentation/view_models/settings/settings_viewmodel.dart';

class AppInfoDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const AppInfoDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('앱 정보'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('버전: 1.0.0'),
          SizedBox(height: 8),
          Text('빌드: 100'),
          SizedBox(height: 8),
          Text('개발자: Your Name'),
          SizedBox(height: 8),
          Text('© 2024 All rights reserved'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('확인'),
        ),
      ],
    );
  }
}
