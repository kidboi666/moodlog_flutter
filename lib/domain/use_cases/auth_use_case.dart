import '../../core/constants/enum.dart';
import '../../core/utils/result.dart';
import '../entities/user/user.dart';
import '../repositories/auth_repository.dart';
import '../repositories/settings_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  final SettingsRepository _settingsRepository;

  AuthUseCase({
    required AuthRepository authRepository,
    required SettingsRepository settingsRepository,
  }) : _authRepository = authRepository,
       _settingsRepository = settingsRepository;

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

  Future<Result<void>> deleteAccount(LoginMethod loginMethod) async {
    try {
      if (loginMethod == LoginMethod.google) {
        await _authRepository.deleteAccountWithGoogle();
      } else if (loginMethod == LoginMethod.apple) {
        await _authRepository.deleteAccountWithApple();
      } else {
        return Result.error(
          Exception('Unsupported login method: ${loginMethod.value}'),
        );
      }

      await _settingsRepository.clearAllData();

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to completely delete account: $e'));
    }
  }
}
