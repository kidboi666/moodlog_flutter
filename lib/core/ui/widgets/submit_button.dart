import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/ui/widgets/spinner.dart';

class SubmitButton extends StatelessWidget {
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? asset;
  final ButtonStyle? style;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final List<Widget> children;

  const SubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.isDisabled,
    this.icon,
    this.asset,
    this.style,
    this.backgroundColor,
    this.foregroundColor,
    required this.children,
  });

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
    const disabledAlpha = 0.60;
    const disabledForegroundColorAlpha = 0.40;

    return FilledButton.styleFrom(
      backgroundColor: backgroundColor ?? colorScheme.surfaceContainer,
      foregroundColor: foregroundColor ?? colorScheme.onSurface,
      disabledBackgroundColor:
          backgroundColor?.withValues(alpha: disabledAlpha) ??
          colorScheme.surfaceContainer.withValues(alpha: disabledAlpha),
      disabledForegroundColor:
          foregroundColor?.withValues(alpha: disabledForegroundColorAlpha) ??
          colorScheme.onSurface.withValues(alpha: disabledForegroundColorAlpha),
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
