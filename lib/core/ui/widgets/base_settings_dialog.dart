import 'package:flutter/material.dart';

import '../../../presentation/settings/settings_view_model.dart';

class BaseSettingsDialog extends StatelessWidget {
  final SettingsViewModel viewModel;
  final String title;
  final Widget content;
  final List<Widget>? actions;

  const BaseSettingsDialog({
    super.key,
    required this.viewModel,
    required this.title,
    required this.content,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          if (viewModel.isLoading) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                content,
              ],
            );
          }

          if (viewModel.hasError) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.error,
                  size: 48,
                ),
                const SizedBox(height: 8),
                Text(
                  'Error: ${viewModel.error}',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                content,
              ],
            );
          }

          return content;
        },
      ),
      actions: actions,
    );
  }
}
