import 'package:flutter/material.dart';
import 'package:moodlog/presentation/view_models/settings/settings_viewmodel.dart';

class ClearCacheDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const ClearCacheDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('캐시 삭제'),
      content: const Text('캐시를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            viewModel.clearCache(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('삭제'),
        ),
      ],
    );
  }
}
