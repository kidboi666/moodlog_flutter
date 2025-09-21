import 'package:flutter/material.dart';

import '../../constants/common.dart';

/// 자주 사용되는 SizedBox들을 미리 정의하여 성능 최적화
class CommonSizedBox {
  CommonSizedBox._();

  // 높이 관련
  static const heightXs = SizedBox(height: Spacing.xs);
  static const heightSm = SizedBox(height: Spacing.sm);
  static const heightMd = SizedBox(height: Spacing.md);
  static const heightLg = SizedBox(height: Spacing.lg);
  static const heightXl = SizedBox(height: Spacing.xl);

  // 너비 관련
  static const widthXs = SizedBox(width: Spacing.xs);
  static const widthSm = SizedBox(width: Spacing.sm);
  static const widthMd = SizedBox(width: Spacing.md);
  static const widthLg = SizedBox(width: Spacing.lg);
  static const widthXl = SizedBox(width: Spacing.xl);

  // 특수 케이스
  static const empty = SizedBox.shrink();
  static const expand = Expanded(child: SizedBox());
}

/// 자주 사용되는 Divider들
class CommonDivider {
  CommonDivider._();

  static const thin = Divider(height: 1, thickness: 1);
  static const normal = Divider();
  static const thick = Divider(height: 2, thickness: 2);
  static const invisible = Divider(color: Colors.transparent);
}

/// 자주 사용되는 EdgeInsets들
class CommonPadding {
  CommonPadding._();

  static const xs = EdgeInsets.all(Spacing.xs);
  static const sm = EdgeInsets.all(Spacing.sm);
  static const md = EdgeInsets.all(Spacing.md);
  static const lg = EdgeInsets.all(Spacing.lg);
  static const xl = EdgeInsets.all(Spacing.xl);

  static const horizontalXs = EdgeInsets.symmetric(horizontal: Spacing.xs);
  static const horizontalSm = EdgeInsets.symmetric(horizontal: Spacing.sm);
  static const horizontalMd = EdgeInsets.symmetric(horizontal: Spacing.md);
  static const horizontalLg = EdgeInsets.symmetric(horizontal: Spacing.lg);
  static const horizontalXl = EdgeInsets.symmetric(horizontal: Spacing.xl);

  static const verticalXs = EdgeInsets.symmetric(vertical: Spacing.xs);
  static const verticalSm = EdgeInsets.symmetric(vertical: Spacing.sm);
  static const verticalMd = EdgeInsets.symmetric(vertical: Spacing.md);
  static const verticalLg = EdgeInsets.symmetric(vertical: Spacing.lg);
  static const verticalXl = EdgeInsets.symmetric(vertical: Spacing.xl);
}

/// 자주 사용되는 BorderRadius들
class CommonBorderRadius {
  CommonBorderRadius._();

  static final small = BorderRadius.circular(Roundness.cardInner);
  static final medium = BorderRadius.circular(Roundness.card);
  static final large = BorderRadius.circular(20.0);
  static final circular = BorderRadius.circular(100);
}

/// 로딩 인디케이터 위젯
class LoadingWidget extends StatelessWidget {
  final String? message;
  final double? size;

  const LoadingWidget({
    super.key,
    this.message,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size ?? 32,
            height: size ?? 32,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: colorScheme.primary,
            ),
          ),
          if (message != null) ...[
            CommonSizedBox.heightMd,
            Text(
              message!,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// 빈 상태를 표시하는 위젯
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: CommonPadding.xl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            CommonSizedBox.heightLg,
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              CommonSizedBox.heightSm,
              Text(
                subtitle!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              CommonSizedBox.heightLg,
              action!,
            ],
          ],
        ),
      ),
    );
  }
}