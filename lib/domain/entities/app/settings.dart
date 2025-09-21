import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constants/enum.dart';

part 'settings.freezed.dart';

@freezed
abstract class Settings with _$Settings {
  const Settings._();

  const factory Settings({
    @Default(false) bool hasNotificationEnabled,
    @Default(false) bool hasAutoSyncEnabled,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(ColorTheme.blue) ColorTheme colorTheme,
    @Default(LanguageCode.ko) LanguageCode languageCode,
    @Default(AiPersonality.balanced) AiPersonality aiPersonality,
    @Default(FontFamily.restart) FontFamily fontFamily,
    @Default(SimpleTextAlign.left) SimpleTextAlign textAlign,
    @Default(false) bool isOnboardingComplete,
    @Default(false) bool isSocialOnboardingComplete,
  }) = _Settings;

  bool shouldShowOnboarding(bool isAnonymousUser) {
    if (isAnonymousUser) {
      // 익명 사용자는 기본 온보딩 완료 상태만 확인
      return !isOnboardingComplete;
    } else {
      // 소셜 로그인 사용자는 소셜 온보딩 완료 상태 확인
      // 단, 기존 사용자 호환성을 위해 기본 온보딩도 확인
      return !isSocialOnboardingComplete && !isOnboardingComplete;
    }
  }
}
