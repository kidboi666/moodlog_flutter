import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_user.freezed.dart';

@freezed
abstract class LocalUser with _$LocalUser {
  const factory LocalUser({
    required String userId,
    required String nickname,
    String? profileImagePath,
    required DateTime createdAt,
  }) = _LocalUser;
}
