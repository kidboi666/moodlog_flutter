import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import '../../../../core/utils/result.dart';
import '../../profile_viewmodel.dart';

class DeleteAccountFormDialog extends StatefulWidget {
  final ProfileViewModel viewModel;

  const DeleteAccountFormDialog({super.key, required this.viewModel});

  @override
  State<DeleteAccountFormDialog> createState() =>
      _DeleteAccountFormDialogState();
}

class _DeleteAccountFormDialogState extends State<DeleteAccountFormDialog> {
  String? _loginMethod;
  bool _isLoadingLoginMethod = true;

  @override
  void initState() {
    super.initState();
    _loadLoginMethod();
  }

  Future<void> _loadLoginMethod() async {
    final loginMethod = await widget.viewModel.getUserLoginMethod();
    setState(() {
      _loginMethod = loginMethod;
      _isLoadingLoginMethod = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    if (_isLoadingLoginMethod) {
      return const AlertDialog(
        content: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: colorScheme.error, size: 24),
          const SizedBox(width: 8),
          Text(
            t.profile_delete_account_dialog_title,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.profile_delete_account_reauthentication_required),
          const SizedBox(height: 16),
          if (_loginMethod == 'google')
            _buildReauthButton(
              context,
              t.profile_delete_account_reauthentication_google,
              Icons.login,
            )
          else if (_loginMethod == 'apple')
            _buildReauthButton(
              context,
              t.profile_delete_account_reauthentication_apple,
              Icons.login,
            )
          else
            Text('Anonymous user - no reauthentication needed'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(t.common_confirm_cancel, style: textTheme.labelLarge),
        ),
      ],
    );
  }

  Widget _buildReauthButton(BuildContext context, String text, IconData icon) {
    return SizedBox(
      width: double.infinity,
      child: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return ElevatedButton.icon(
            onPressed: widget.viewModel.isLoading
                ? null
                : () => _handleDeleteAccount(context, widget.viewModel),
            icon: widget.viewModel.isLoading
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                : Icon(icon),
            label: Text(text),
          );
        },
      ),
    );
  }

  Future<void> _handleDeleteAccount(
    BuildContext context,
    ProfileViewModel viewModel,
  ) async {
    final result = await viewModel.deleteAccount('');
    if (context.mounted) {
      context.pop();

      switch (result) {
        case Ok<void>():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.profile_delete_account_success),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          context.go('/auth');
        case Error<void>():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.profile_delete_account_reauthentication_failed,
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
          break;
      }
    }
  }
}
