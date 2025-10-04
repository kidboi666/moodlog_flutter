import 'package:flutter/material.dart';
import 'package:moodlog/core/ui/widgets/spinner.dart';

import '../../constants/common.dart';
import '../../constants/enum.dart';

class SubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
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

  bool get isDisabled => isLoading || onPressed == null;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: _buildButtonStyle(context),
      onPressed: isDisabled ? null : onPressed,
      child: _buildButtonChild(context),
    );
  }

  ButtonStyle _buildButtonStyle(BuildContext context) {
    if (style != null) return style!;

    final colorScheme = Theme.of(context).colorScheme;
    const disabledAlpha = 0.12;
    const disabledForegroundColorAlpha = 0.38;

    return FilledButton.styleFrom(
      backgroundColor: colorScheme.surfaceContainer,
      foregroundColor: colorScheme.onSurface,
      disabledBackgroundColor: colorScheme.surfaceContainer.withValues(
        alpha: disabledAlpha,
      ),
      disabledForegroundColor: colorScheme.onSurface.withValues(
        alpha: disabledForegroundColorAlpha,
      ),
    );
  }

  Widget _buildButtonChild(BuildContext context) {
    if (isLoading) {
      return Spinner(spinnerType: SpinnerType.button);
    }

    return Opacity(
      opacity: isDisabled ? 0.38 : 1.0,
      child: Row(
        spacing: Spacing.md,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
