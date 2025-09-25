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

  Future<Result<void>> deleteAccount() async {
    try {
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
}
