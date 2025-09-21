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
      return !isOnboardingComplete;
    } else {
      // 소셜 로그인 사용자의 경우 기존 온보딩 완료 상태도 확인
      // 기존 사용자들은 isOnboardingComplete가 true일 수 있음
      return !isSocialOnboardingComplete && !isOnboardingComplete;
    }
  }
}
