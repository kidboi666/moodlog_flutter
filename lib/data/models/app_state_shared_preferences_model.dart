import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/constants/enum.dart';
import '../../domain/entities/app/settings.dart';

part 'app_state_shared_preferences_model.freezed.dart';
part 'app_state_shared_preferences_model.g.dart';

@freezed
abstract class AppStateSharedPreferencesModel
    with _$AppStateSharedPreferencesModel {
  const AppStateSharedPreferencesModel._();

  const factory AppStateSharedPreferencesModel({
    @Default(false) bool hasNotificationEnabled,
    @Default(false) bool hasAutoSyncEnabled,
    @Default('ThemeMode.system') String themeMode,
    @Default('ColorTheme.blue') String colorTheme,
    @Default('LanguageCode.ko') String languageCode,
    @Default('AiPersonality.balanced') String aiPersonality,
    @Default('FontFamily.restart') String fontFamily,
    @Default('SimpleTextAlign.left') String textAlign,
    @Default(false) bool isOnboardingComplete,
    @Default(false) bool isSocialOnboardingComplete,
  }) = _AppStateSharedPreferencesModel;

  factory AppStateSharedPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$AppStateSharedPreferencesModelFromJson(json);

  static AppStateSharedPreferencesModel fromDomain(Settings entity) {
    return AppStateSharedPreferencesModel(
      hasNotificationEnabled: entity.hasNotificationEnabled,
      hasAutoSyncEnabled: entity.hasAutoSyncEnabled,
      themeMode: entity.themeMode.toString(),
      colorTheme: entity.colorTheme.toString(),
      languageCode: entity.languageCode.toString(),
      aiPersonality: entity.aiPersonality.toString(),
      fontFamily: entity.fontFamily.toString(),
      textAlign: entity.textAlign.toString(),
      isOnboardingComplete: entity.isOnboardingComplete,
      isSocialOnboardingComplete: entity.isSocialOnboardingComplete,
    );
  }

  Settings toDomain() {
    return Settings(
      hasNotificationEnabled: hasNotificationEnabled,
      hasAutoSyncEnabled: hasAutoSyncEnabled,
      themeMode: ThemeMode.values.firstWhere(
        (element) => element.toString() == themeMode,
        orElse: () => ThemeMode.system,
      ),
      colorTheme: ColorTheme.values.firstWhere(
        (element) => element.toString() == colorTheme,
        orElse: () => ColorTheme.blue,
      ),
      languageCode: LanguageCode.values.firstWhere(
        (element) => element.toString() == languageCode,
        orElse: () => LanguageCode.ko,
      ),
      aiPersonality: AiPersonality.values.firstWhere(
        (element) => element.toString() == aiPersonality,
        orElse: () => AiPersonality.balanced,
      ),
      fontFamily: FontFamily.values.firstWhere(
        (element) => element.toString() == fontFamily,
        orElse: () => FontFamily.restart,
      ),
      textAlign: SimpleTextAlign.values.firstWhere(
        (element) => element.toString() == textAlign,
        orElse: () => SimpleTextAlign.left,
      ),
      isOnboardingComplete: isOnboardingComplete,
      isSocialOnboardingComplete: isSocialOnboardingComplete,
    );
  }
}
