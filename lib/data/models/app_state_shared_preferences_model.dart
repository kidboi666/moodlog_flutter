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
    required bool hasNotificationEnabled,
    required bool hasAutoSyncEnabled,
    required String themeMode,
    required String colorTheme,
    required String languageCode,
    required String aiPersonality,
    required String fontFamily,
    required String textAlign,
    required bool isOnboardingComplete,
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
    );
  }

  Settings toDomain() {
    return Settings(
      hasNotificationEnabled: hasNotificationEnabled,
      hasAutoSyncEnabled: hasAutoSyncEnabled,
      themeMode: ThemeMode.values.firstWhere(
        (element) => element.toString() == themeMode,
      ),
      colorTheme: ColorTheme.values.firstWhere(
        (element) => element.toString() == colorTheme,
      ),
      languageCode: LanguageCode.values.firstWhere(
        (element) => element.toString() == languageCode,
      ),
      aiPersonality: AiPersonality.values.firstWhere(
        (element) => element.toString() == aiPersonality,
      ),
      fontFamily: FontFamily.values.firstWhere(
        (element) => element.toString() == fontFamily,
      ),
      textAlign: SimpleTextAlign.values.firstWhere(
        (element) => element.toString() == textAlign,
      ),
      isOnboardingComplete: isOnboardingComplete,
    );
  }
}
