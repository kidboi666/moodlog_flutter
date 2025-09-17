import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';

class EditDisplayNameBottomSheet extends StatefulWidget {
  final String? initialName;

  const EditDisplayNameBottomSheet({super.key, this.initialName});

  @override
  State<EditDisplayNameBottomSheet> createState() =>
      _EditDisplayNameBottomSheetState();
}

class _EditDisplayNameBottomSheetState
    extends State<EditDisplayNameBottomSheet> {
  late final TextEditingController _controller;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName ?? '');
    _controller.addListener(_validateInput);
    _validateInput();
  }

  void _validateInput() {
    setState(() {
      _isValid = _controller.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: Spacing.lg,
        right: Spacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Spacing.lg,
        children: [
          const SizedBox(height: Spacing.lg),
          Text(
            t.profile_nickname_title,
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: t.profile_nickname_hint,
              border: const UnderlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                },
                icon: Icon(Icons.cancel),
              ),
              suffixIconColor: colorScheme.outline,
            ),
            onSubmitted: _isValid ? (value) => context.pop(value) : null,
          ),
          Text(t.profile_nickname_hint, textAlign: TextAlign.center),
          FilledButton(
            onPressed: _isValid
                ? () => context.pop(_controller.text.trim())
                : null,
            child: Text(t.common_confirm_ok),
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
