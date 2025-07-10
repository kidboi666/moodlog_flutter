import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/constants/enum.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
abstract class AppState with _$AppState {
  const AppState._();

  const factory AppState({
    @Default(true) bool isFirstLaunch,
    @Default(false) bool hasNotificationEnabled,
    @Default(false) bool hasAutoSyncEnabled,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(ColorTheme.teal) ColorTheme colorTheme,
    @Default(LanguageCode.ko) LanguageCode languageCode,
    DateTime? lastActiveDate,
    DateTime? firstLaunchedDate,
    @Default(AiPersonality.balanced) AiPersonality aiPersonality,
    @Default('') String nickname,
    @Default(FontFamily.pretendard) FontFamily fontFamily,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
}
