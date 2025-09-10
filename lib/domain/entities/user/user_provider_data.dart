import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_provider_data.freezed.dart';
part 'user_provider_data.g.dart';

@freezed
abstract class UserProviderData with _$UserProviderData {
  const factory UserProviderData({required String providerId}) =
      _UserProviderData;

  factory UserProviderData.fromJson(Map<String, dynamic> json) =>
      _$UserProviderDataFromJson(json);
}
