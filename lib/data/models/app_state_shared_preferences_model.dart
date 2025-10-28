import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/font_type_serializer.dart';
import 'package:moodlog/domain/entities/app/settings.dart';

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
    @Default('local:pretendard') String fontType,
    @Default('SimpleTextAlign.left') String textAlign,
    @Default(false) bool isOnboardingComplete,
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
      fontType: FontTypeSerializer.serialize(entity.fontType),
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
      fontType: FontTypeSerializer.deserialize(fontType),
      textAlign: SimpleTextAlign.values.firstWhere(
        (element) => element.toString() == textAlign,
        orElse: () => SimpleTextAlign.left,
      ),
      isOnboardingComplete: isOnboardingComplete,
    );
  }
}
