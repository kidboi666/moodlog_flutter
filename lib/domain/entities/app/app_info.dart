import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_info.freezed.dart';
part 'app_info.g.dart';

@freezed
abstract class AppInfo with _$AppInfo {
  const AppInfo._();

  const factory AppInfo({
    required String appName,
    required String packageName,
    required String version,
    required String buildNumber,
  }) = _AppInfo;

  factory AppInfo.fromJson(Map<String, dynamic> json) =>
      _$AppInfoFromJson(json);
}
