import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/presentation/widgets/spinner.dart';

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

    const disabledAlpha = 0.60;
    const disabledForegroundColorAlpha = 0.40;

    return FilledButton.styleFrom(
      backgroundColor:
          backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
      foregroundColor:
          foregroundColor ?? Theme.of(context).colorScheme.onSurface,
      disabledBackgroundColor:
          backgroundColor?.withValues(alpha: disabledAlpha) ??
          Theme.of(
            context,
          ).colorScheme.surfaceContainer.withValues(alpha: disabledAlpha),
      disabledForegroundColor:
          foregroundColor?.withValues(alpha: disabledForegroundColorAlpha) ??
          Theme.of(context).colorScheme.onSurface.withValues(
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
