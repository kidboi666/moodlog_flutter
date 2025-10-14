import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/domain/entities/user/local_user.dart';

part 'backup_user.freezed.dart';
part 'backup_user.g.dart';

@freezed
abstract class BackupUser with _$BackupUser {
  const factory BackupUser({
    required String userId,
    required String nickname,
    String? profileImagePath,
    required DateTime createdAt,
  }) = _BackupUser;

  factory BackupUser.fromJson(Map<String, dynamic> json) =>
      _$BackupUserFromJson(json);

  factory BackupUser.fromLocalUser(LocalUser user) {
    return BackupUser(
      userId: user.userId,
      nickname: user.nickname,
      profileImagePath: user.profileImagePath,
      createdAt: user.createdAt,
    );
  }
}

extension BackupUserX on BackupUser {
  LocalUser toLocalUser() {
    return LocalUser(
      userId: userId,
      nickname: nickname,
      profileImagePath: profileImagePath,
      createdAt: createdAt,
    );
  }
}
