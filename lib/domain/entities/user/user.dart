import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/domain/entities/user/user_metadata.dart';
import 'package:moodlog/domain/entities/user/user_provider_data.dart';

part 'user.freezed.dart';

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
}
