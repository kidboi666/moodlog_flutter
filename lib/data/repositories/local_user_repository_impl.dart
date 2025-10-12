import 'dart:math';

import 'package:logging/logging.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/data/data_source/local/shared_preferences_local_data_source.dart';
import 'package:moodlog/domain/entities/user/local_user.dart';
import 'package:moodlog/domain/repositories/local_user_repository.dart';

class LocalUserRepositoryImpl implements LocalUserRepository {
  final SharedPreferencesLocalDataSource _prefs;

  LocalUserRepositoryImpl({
    required SharedPreferencesLocalDataSource localDataSource,
  }) : _prefs = localDataSource;

  final Logger _log = Logger('LocalUserRepositoryImpl');

  @override
  Future<LocalUser?> getUser() async {
    try {
      final userId = await _prefs.getString(PreferenceKeys.localUserId);
      if (userId == null) {
        return null;
      }

      final nickname = await _prefs.getString(PreferenceKeys.localUserNickname);
      final profileImage = await _prefs.getString(
        PreferenceKeys.localUserProfileImage,
      );
      final createdAtStr = await _prefs.getString(
        PreferenceKeys.localUserCreatedAt,
      );

      if (nickname == null || createdAtStr == null) {
        return null;
      }

      final createdAt = DateTime.parse(createdAtStr);

      return LocalUser(
        userId: userId,
        nickname: nickname,
        profileImagePath: profileImage,
        createdAt: createdAt,
      );
    } catch (e) {
      _log.severe('Failed to get user: $e');
      return null;
    }
  }

  @override
  Future<LocalUser> createUser({required String nickname}) async {
    try {
      final userId = _generateUserId();
      final createdAt = DateTime.now();

      await _prefs.setString(PreferenceKeys.localUserId, userId);
      await _prefs.setString(PreferenceKeys.localUserNickname, nickname);
      await _prefs.setString(
        PreferenceKeys.localUserCreatedAt,
        createdAt.toIso8601String(),
      );

      _log.info('Created local user with ID: $userId');

      return LocalUser(
        userId: userId,
        nickname: nickname,
        createdAt: createdAt,
      );
    } catch (e) {
      _log.severe('Failed to create user: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateUser(LocalUser user) async {
    try {
      await _prefs.setString(PreferenceKeys.localUserId, user.userId);
      await _prefs.setString(PreferenceKeys.localUserNickname, user.nickname);
      await _prefs.setString(
        PreferenceKeys.localUserCreatedAt,
        user.createdAt.toIso8601String(),
      );

      if (user.profileImagePath != null) {
        await _prefs.setString(
          PreferenceKeys.localUserProfileImage,
          user.profileImagePath!,
        );
      } else {
        await _prefs.remove(PreferenceKeys.localUserProfileImage);
      }

      _log.info('Updated user: ${user.userId}');
    } catch (e) {
      _log.severe('Failed to update user: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteAllData() async {
    try {
      await _prefs.remove(PreferenceKeys.localUserId);
      await _prefs.remove(PreferenceKeys.localUserNickname);
      await _prefs.remove(PreferenceKeys.localUserProfileImage);
      await _prefs.remove(PreferenceKeys.localUserCreatedAt);

      _log.info('Deleted all local user data');
    } catch (e) {
      _log.severe('Failed to delete user data: $e');
      rethrow;
    }
  }

  /// 간단한 UUID 생성 (timestamp + random)
  String _generateUserId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999).toString().padLeft(6, '0');
    return 'user_${timestamp}_$random';
  }
}
