import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
abstract class AppState with _$AppState {
  const AppState._();

  const factory AppState({
    @Default(true) bool isFirstLaunch,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(LanguageCode.ko) LanguageCode languageCode,
    DateTime? lastActiveDate,
    DateTime? firstLaunchedDate,
    required String nickname,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
}

enum ThemeMode { system, dark, light }

enum LanguageCode { ko, en }
