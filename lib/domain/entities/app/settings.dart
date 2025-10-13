import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/core/constants/enum.dart';

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
    @Default(false) bool isAppLockEnabled,
    @Default(LockType.none) LockType lockType,
    @Default(false) bool isProUser,
  }) = _Settings;

  bool shouldShowOnboarding() => !isOnboardingComplete;
}
