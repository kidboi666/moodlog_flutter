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
  static const horCalendarDateHeight = 68.0;
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
  static const aiUsage = 'ai_usage';
  static const localUserId = 'local_user_id';
  static const localUserNickname = 'local_user_nickname';
  static const localUserProfileImage = 'local_user_profile_image';
  static const localUserCreatedAt = 'local_user_created_at';
}

abstract final class DebounceKeys {
  static const aiResponse = 'ai_response';
}

const kBreakPoint = 768.0;

/// 자주 사용되는 SizedBox들을 미리 정의하여 성능 최적화
abstract final class CommonSizedBox {
  // 높이 관련
  static const heightXs = meterial.SizedBox(height: 4);
  static const heightSm = meterial.SizedBox(height: 8);
  static const heightMd = meterial.SizedBox(height: 12);
  static const heightLg = meterial.SizedBox(height: 16);
  static const heightXl = meterial.SizedBox(height: 20);

  // 너비 관련
  static const widthXs = meterial.SizedBox(width: 4);
  static const widthSm = meterial.SizedBox(width: 8);
  static const widthMd = meterial.SizedBox(width: 12);
  static const widthLg = meterial.SizedBox(width: 16);
  static const widthXl = meterial.SizedBox(width: 20);

  // 특수 케이스
  static const empty = meterial.SizedBox.shrink();
  static const expand = meterial.Expanded(child: meterial.SizedBox());
  static const homeBottomPadding = meterial.SizedBox(
    height: meterial.kBottomNavigationBarHeight * 3,
  );
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
  static const xs = meterial.EdgeInsets.all(4);
  static const sm = meterial.EdgeInsets.all(8);
  static const md = meterial.EdgeInsets.all(12);
  static const lg = meterial.EdgeInsets.all(16);
  static const xl = meterial.EdgeInsets.all(20);

  static const horizontalXs = meterial.EdgeInsets.symmetric(horizontal: 4);
  static const horizontalSm = meterial.EdgeInsets.symmetric(horizontal: 8);
  static const horizontalMd = meterial.EdgeInsets.symmetric(horizontal: 12);
  static const horizontalLg = meterial.EdgeInsets.symmetric(horizontal: 16);
  static const horizontalXl = meterial.EdgeInsets.symmetric(horizontal: 20);

  static const verticalXs = meterial.EdgeInsets.symmetric(vertical: 4);
  static const verticalSm = meterial.EdgeInsets.symmetric(vertical: 8);
  static const verticalMd = meterial.EdgeInsets.symmetric(vertical: 12);
  static const verticalLg = meterial.EdgeInsets.symmetric(vertical: 16);
  static const verticalXl = meterial.EdgeInsets.symmetric(vertical: 20);
}

/// 자주 사용되는 BorderRadius들
abstract final class CommonBorderRadius {
  static final small = meterial.BorderRadius.circular(Roundness.cardInner);
  static final medium = meterial.BorderRadius.circular(Roundness.card);
  static final large = meterial.BorderRadius.circular(20.0);
  static final circular = meterial.BorderRadius.circular(100);
}

abstract final class SuggestedActivities {
  static const activities = [
    'suggested_activity_exercise',
    'suggested_activity_study',
    'suggested_activity_work',
    'suggested_activity_cooking',
    'suggested_activity_reading',
    'suggested_activity_walking',
    'suggested_activity_cleaning',
    'suggested_activity_shopping',
    'suggested_activity_gaming',
    'suggested_activity_watching',
    'suggested_activity_music',
    'suggested_activity_travel',
    'suggested_activity_friends',
    'suggested_activity_family',
    'suggested_activity_rest',
  ];
}

abstract final class SuggestedEmotions {
  static const emotions = [
    'suggested_emotion_joy',
    'suggested_emotion_happiness',
    'suggested_emotion_peace',
    'suggested_emotion_satisfaction',
    'suggested_emotion_excitement',
    'suggested_emotion_gratitude',
    'suggested_emotion_love',
    'suggested_emotion_confidence',
    'suggested_emotion_anxiety',
    'suggested_emotion_worry',
    'suggested_emotion_sadness',
    'suggested_emotion_anger',
    'suggested_emotion_irritation',
    'suggested_emotion_tired',
    'suggested_emotion_loneliness',
  ];
}
