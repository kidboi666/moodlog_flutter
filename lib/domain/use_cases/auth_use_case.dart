import '../../core/utils/result.dart';
import '../../data/data_source/local/database/database.dart';
import '../entities/user/user.dart';
import '../repositories/auth_repository.dart';
import '../repositories/settings_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  final SettingsRepository _settingsRepository;
  final MoodLogDatabase _database;

  AuthUseCase({
    required AuthRepository authRepository,
    required SettingsRepository settingsRepository,
    required MoodLogDatabase database,
  }) : _authRepository = authRepository,
       _settingsRepository = settingsRepository,
       _database = database;

  Future<Result<User?>> signInWithGoogle() async {
    return await _authRepository.signInWithGoogle();
  }

  Future<void> signOut() async {
    return await _authRepository.signOut();
  }

  Future<Result<void>> updateDisplayName(String displayName) async {
    return await _authRepository.updateDisplayName(displayName);
  }

  Future<Result<void>> updateProfileImage(String photoURL) async {
    return await _authRepository.updateProfileImage(photoURL);
  }

  Future<Result<void>> reauthenticateWithGoogle() async {
    return await _authRepository.reauthenticateWithGoogle();
  }

  Future<Result<void>> reauthenticateWithApple() async {
    return await _authRepository.reauthenticateWithApple();
  }

  Future<String?> getUserLoginMethod() async {
    final userResult = await _authRepository.getCurrentUser();

    switch (userResult) {
      case Ok<User?>():
        final userData = userResult.value;
        if (userData == null) return null;
        if (userData.providerData.isEmpty) return 'anonymous';

        final providerIds = userData.providerData.map((p) => p.providerId).toList();

        if (providerIds.contains('google.com')) {
          return 'google';
        } else if (providerIds.contains('apple.com')) {
          return 'apple';
        } else {
          return 'unknown';
        }
      case Error<User?>():
        return null;
    }
  }

  Future<Result<void>> deleteAccountWithReauthentication() async {
    try {
      final loginMethod = await getUserLoginMethod();
      if (loginMethod == null) {
        return Result.error(Exception('Unable to determine login method'));
      }

      if (loginMethod == 'google') {
        final reauthResult = await _authRepository.reauthenticateWithGoogle();
        if (reauthResult is Error<void>) {
          return reauthResult;
        }
      } else if (loginMethod == 'apple') {
        // Apple 사용자의 경우, deleteAccount에서 재인증과 revoke를 함께 처리
        // 중복 인증을 방지하기 위해 여기서는 재인증하지 않음
      } else if (loginMethod == 'anonymous') {
        // Anonymous users don't need reauthentication
      } else {
        return Result.error(Exception('Unsupported login method: $loginMethod'));
      }

      final result = await _authRepository.deleteAccount();
      if (result is Error<void>) {
        return result;
      }

      await _database.clearAllTables();
      await _settingsRepository.clearAllData();

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to completely delete account: $e'));
    }
  }

  Future<Result<void>> deleteAccount(String email, String password) async {
    return await deleteAccountWithReauthentication();
  }
}
