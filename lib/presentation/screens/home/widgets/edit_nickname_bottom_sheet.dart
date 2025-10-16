import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditNicknameBottomSheet extends StatefulWidget {
  final String currentNickname;

  const EditNicknameBottomSheet({
    super.key,
    required this.currentNickname,
  });

  @override
  State<EditNicknameBottomSheet> createState() =>
      _EditNicknameBottomSheetState();
}

class _EditNicknameBottomSheetState extends State<EditNicknameBottomSheet> {
  late TextEditingController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentNickname);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final newNickname = _controller.text.trim();

    if (newNickname.isEmpty) {
      return;
    }

    if (newNickname == widget.currentNickname) {
      if (mounted) {
        context.pop();
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<UserProvider>().updateNickname(newNickname);
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update nickname: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: Spacing.xl,
        right: Spacing.xl,
        top: Spacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            t.edit_nickname_title,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Spacing.xl),

          // Input field
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: 20,
            decoration: InputDecoration(
              labelText: t.edit_nickname_label,
              hintText: t.edit_nickname_hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Roundness.md),
              ),
              counterText: '',
            ),
            onSubmitted: (_) => _handleSave(),
          ),
          const SizedBox(height: Spacing.xl),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isLoading ? null : () => context.pop(),
                  child: Text(t.cancel),
                ),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: FilledButton(
                  onPressed: _isLoading ? null : _handleSave,
                  child: _isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : Text(t.save),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.xl),
        ],
      ),
    );
  }
}
