import 'package:flutter/material.dart';
import 'package:moodlog/core/ui/widgets/spinner.dart';

import '../../constants/common.dart';
import '../../constants/enum.dart';

class SubmitButton extends StatelessWidget {
  final bool isLoading;
  final Function? onPressed;
  final IconData? icon;
  final String? asset;
  final ButtonStyle? style;
  final List<Widget> children;

  const SubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    this.icon,
    this.asset,
    this.style,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDisabled = isLoading || onPressed == null;

    return FilledButton(
      style: style ??
          FilledButton.styleFrom(
            backgroundColor: isDisabled
                ? colorScheme.surfaceContainer.withValues(alpha: 0.12)
                : colorScheme.surfaceContainer,
            foregroundColor: isDisabled
                ? colorScheme.onSurface.withValues(alpha: 0.38)
                : colorScheme.onSurface,
            disabledBackgroundColor: colorScheme.surfaceContainer.withValues(alpha: 0.12),
            disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
          ),
      onPressed: isDisabled
          ? null
          : () async {
              await onPressed!();
            },
      child: isLoading
          ? const Spinner(spinnerType: SpinnerType.button)
          : Opacity(
              opacity: isDisabled ? 0.38 : 1.0,
              child: Row(
                spacing: Spacing.md,
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
    );
  }
}
