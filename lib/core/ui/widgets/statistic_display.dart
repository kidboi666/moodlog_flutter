import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

/// 통계 수치를 표시하는 공통 위젯
class StatisticDisplay extends StatelessWidget {
  final String value;
  final String unit;
  final Color? valueColor;
  final Color? unitColor;
  final TextStyle? valueStyle;
  final TextStyle? unitStyle;

  const StatisticDisplay({
    super.key,
    required this.value,
    required this.unit,
    this.valueColor,
    this.unitColor,
    this.valueStyle,
    this.unitStyle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          value,
          style:
              valueStyle ??
              textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: valueColor ?? colorScheme.primary,
              ),
        ),
        Text(
          unit,
          style:
              unitStyle ??
              textTheme.bodyLarge?.copyWith(
                color: unitColor ?? colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}

/// 상태를 표시하는 공통 위젯 (상태, 아이콘, 색상)
class StatusIndicator extends StatelessWidget {
  final String status;
  final IconData? icon;
  final Color color;

  const StatusIndicator({
    super.key,
    required this.status,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.sm,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: color, size: 16),
            const SizedBox(width: Spacing.xs),
          ],
          Text(
            status,
            style: textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// 정보 행을 표시하는 공통 위젯
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? labelColor;
  final Color? valueColor;
  final FontWeight? valueFontWeight;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelColor,
    this.valueColor,
    this.valueFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: labelColor ?? colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: valueFontWeight ?? FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

/// 정보 컨테이너를 표시하는 공통 위젯
class InfoContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const InfoContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: padding ?? const EdgeInsets.all(Spacing.lg),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(Roundness.cardInner),
      ),
      child: child,
    );
  }
}
