import 'package:flutter/material.dart' as meterial;

abstract final class Roundness {
  static const none = 0.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 24.0;

  static const card = 24.0;
  static const cardInner = 20.0;
  static const chip = 16.0;
  static const button = 12.0;
}

abstract final class Spacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 24.0;

  static const containerHorizontalPadding = meterial.EdgeInsets.symmetric(
    horizontal: 16.0,
  );
  static const paddingVertical = meterial.EdgeInsets.symmetric(vertical: 16.0);
  static const containerMarginTop = meterial.EdgeInsets.only(top: 28.0);
  static const containerPaddingTop = meterial.EdgeInsets.only(top: 80.0);
  static const containerPaddingBottom = meterial.EdgeInsets.only(bottom: 180.0);
  static const headerVerticalPadding = meterial.EdgeInsets.symmetric(
    vertical: 12.0,
  );
  static const imagePickerBoxInnerPadding = meterial.EdgeInsets.only(
    right: 8.0,
  );
  static const calendarScrollSize = 44.0;
  static const aiResponseGap = 26.0;
  static const horCalendarDateHeight = 60.0;
}

abstract final class DelayMS {
  static const oneSecond = Duration(milliseconds: 1000);
  static const medium = Duration(milliseconds: 500);
  static const quick = Duration(milliseconds: 300);
  static const instant = Duration(milliseconds: 150);
}

abstract final class DurationMS {
  static const debounceMedium = Duration(milliseconds: 4000);
  static const lazy = Duration(milliseconds: 900);
  static const medium = Duration(milliseconds: 600);
  static const quick = Duration(milliseconds: 300);
  static const instant = Duration(milliseconds: 150);
}

abstract final class PreferenceKeys {
  static const appSettings = 'app_settings';
  static const onboardingCompleted = 'onboarding_completed';
  static const lastAiUsageDate = 'last_ai_usage_date';
}

abstract final class DebounceKeys {
  static const aiResponse = 'ai_response';
}

const kBreakPoint = 768.0;

/// 자주 사용되는 SizedBox들을 미리 정의하여 성능 최적화
abstract final class CommonSizedBox {
  // 높이 관련
  static const heightXs = meterial.SizedBox(height: Spacing.xs);
  static const heightSm = meterial.SizedBox(height: Spacing.sm);
  static const heightMd = meterial.SizedBox(height: Spacing.md);
  static const heightLg = meterial.SizedBox(height: Spacing.lg);
  static const heightXl = meterial.SizedBox(height: Spacing.xl);

  // 너비 관련
  static const widthXs = meterial.SizedBox(width: Spacing.xs);
  static const widthSm = meterial.SizedBox(width: Spacing.sm);
  static const widthMd = meterial.SizedBox(width: Spacing.md);
  static const widthLg = meterial.SizedBox(width: Spacing.lg);
  static const widthXl = meterial.SizedBox(width: Spacing.xl);

  // 특수 케이스
  static const empty = meterial.SizedBox.shrink();
  static const expand = meterial.Expanded(child: meterial.SizedBox());
}

/// 자주 사용되는 Divider들
abstract final class CommonDivider {
  static const thin = meterial.Divider(height: 1, thickness: 1);
  static const normal = meterial.Divider();
  static const thick = meterial.Divider(height: 2, thickness: 2);
  static const invisible = meterial.Divider(color: meterial.Colors.transparent);
}

/// 자주 사용되는 EdgeInsets들
abstract final class CommonPadding {
  static const xs = meterial.EdgeInsets.all(Spacing.xs);
  static const sm = meterial.EdgeInsets.all(Spacing.sm);
  static const md = meterial.EdgeInsets.all(Spacing.md);
  static const lg = meterial.EdgeInsets.all(Spacing.lg);
  static const xl = meterial.EdgeInsets.all(Spacing.xl);

  static const horizontalXs = meterial.EdgeInsets.symmetric(horizontal: Spacing.xs);
  static const horizontalSm = meterial.EdgeInsets.symmetric(horizontal: Spacing.sm);
  static const horizontalMd = meterial.EdgeInsets.symmetric(horizontal: Spacing.md);
  static const horizontalLg = meterial.EdgeInsets.symmetric(horizontal: Spacing.lg);
  static const horizontalXl = meterial.EdgeInsets.symmetric(horizontal: Spacing.xl);

  static const verticalXs = meterial.EdgeInsets.symmetric(vertical: Spacing.xs);
  static const verticalSm = meterial.EdgeInsets.symmetric(vertical: Spacing.sm);
  static const verticalMd = meterial.EdgeInsets.symmetric(vertical: Spacing.md);
  static const verticalLg = meterial.EdgeInsets.symmetric(vertical: Spacing.lg);
  static const verticalXl = meterial.EdgeInsets.symmetric(vertical: Spacing.xl);
}

/// 자주 사용되는 BorderRadius들
abstract final class CommonBorderRadius {
  static final small = meterial.BorderRadius.circular(Roundness.cardInner);
  static final medium = meterial.BorderRadius.circular(Roundness.card);
  static final large = meterial.BorderRadius.circular(20.0);
  static final circular = meterial.BorderRadius.circular(100);
}
