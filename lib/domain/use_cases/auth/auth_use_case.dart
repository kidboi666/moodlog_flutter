import '../../../core/utils/result.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

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
}
