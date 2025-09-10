import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/domain/entities/user/user_provider_data.dart';

import 'user_metadata.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String uid,
    String? email,
    required bool isAnonymous,
    String? displayName,
    String? photoURL,
    required UserMetadata metadata,
    required List<UserProviderData> providerData,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
