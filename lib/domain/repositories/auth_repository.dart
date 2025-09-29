import '../../core/utils/result.dart';
import '../entities/user/user.dart';

abstract class AuthRepository {
  Stream<User?> get userChanges;

  bool get isAuthenticated;

  bool get isAnonymousUser;

  Future<Result<User?>> getCurrentUser();

  Future<Result<User?>> signInAnonymously();

  Future<Result<void>> updateDisplayName(String displayName);

  Future<Result<User?>> signInWithGoogle();

  Future<Result<User?>> signInWithApple();

  Future<Result<User?>> linkWithCredential();

  Future<void> signOut();

  Future<Result<void>> updateProfileImage(String profileImage);

  Future<Result<void>> deleteAccountWithApple();

  Future<Result<void>> deleteAccountWithGoogle();

  Future<Result<void>> reauthenticateWithGoogle();
}
