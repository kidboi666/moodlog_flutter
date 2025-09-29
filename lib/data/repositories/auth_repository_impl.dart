import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../extensions/firebase_extension.dart';

class AuthRepositoryImpl extends AuthRepository {
  final firebase.FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({firebase.FirebaseAuth? auth})
    : _firebaseAuth = auth ?? firebase.FirebaseAuth.instance;

  final Logger _log = Logger('AuthRepositoryImpl');

  @override
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  @override
  bool get isAnonymousUser => _firebaseAuth.currentUser?.isAnonymous ?? false;

  @override
  Stream<User?> get userChanges => _firebaseAuth.userChanges().map((user) {
    return user?.toDomain();
  });

  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      return Result.ok(user?.toDomain());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<Result<User?>> linkWithCredential() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      final googleUser = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        _log.severe('Failed to get Google ID token');
        throw Exception('Failed to get Google ID token');
      }

      final credential = firebase.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.currentUser
          ?.linkWithCredential(credential);
      return Result.ok(userCredential?.user?.toDomain());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> updateDisplayName(String displayName) async {
    try {
      await _firebaseAuth.currentUser?.updateDisplayName(displayName);
      await _firebaseAuth.currentUser?.reload();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> updateProfileImage(String profileImage) async {
    try {
      await _firebaseAuth.currentUser?.updatePhotoURL(profileImage);
      await _firebaseAuth.currentUser?.reload();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<User?>> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      return Result.ok(userCredential.user?.toDomain());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<User?>> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = firebase.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        final user = userCredential.user!;

        if (googleUser.displayName!.isNotEmpty) {
          await user.updateDisplayName(googleUser.displayName!);
        }

        await user.reload();
        final updatedUser = _firebaseAuth.currentUser;
        return Result.ok(updatedUser?.toDomain());
      }

      return Result.ok(userCredential.user?.toDomain());
    } catch (e) {
      _log.severe('Failed to authenticate with Google : $e');
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<User?>> signInWithApple() async {
    try {
      final appleProvider = firebase.AppleAuthProvider();
      appleProvider.addScope('email');
      final userCredential = await _firebaseAuth.signInWithProvider(
        appleProvider,
      );
      final user = userCredential.user;

      if (user == null) {
        _log.severe('Apple sign-in succeeded but user is null');
        return Result.error(
          Exception('Apple sign-in failed: no user returned'),
        );
      }

      final additionalUserInfo = userCredential.additionalUserInfo;

      if (additionalUserInfo?.isNewUser == true) {
        _log.info('Apple profile data: $user');

        final newEmail = user.email;
        if (newEmail != null) {
          _log.info('Apple email found: $newEmail');
          await user.verifyBeforeUpdateEmail(newEmail);
        }
      }

      await user.reload();

      return Result.ok(userCredential.user?.toDomain());
    } catch (e) {
      _log.severe('Failed to authenticate with Apple : $e');
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> deleteAccountWithApple() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Result.error(Exception('No user is currently logged in'));
      }

      final appleProvider = firebase.AppleAuthProvider();
      final userCredential = await user.reauthenticateWithProvider(
        appleProvider,
      );
      final authCode = userCredential.additionalUserInfo?.authorizationCode;

      if (authCode != null) {
        await _firebaseAuth.revokeTokenWithAuthorizationCode(authCode);
        _log.info('Apple token revoked successfully');
      } else {
        _log.warning(
          'No authorization code received from Apple reauthentication',
        );
      }

      await user.delete();
      _log.info('Apple account deleted successfully');
      return Result.ok(null);
    } catch (e) {
      _log.severe('Failed to delete Apple account: $e');
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> deleteAccountWithGoogle() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Result.error(Exception('No user is currently logged in'));
      }

      final googleProvider = firebase.GoogleAuthProvider();
      await user.reauthenticateWithProvider(googleProvider);
      await user.unlink(googleProvider.providerId);
      await user.delete();
      _log.info('Google account deleted successfully');
      return Result.ok(null);
    } catch (e) {
      _log.severe('Failed to delete Google account: $e');
      return Result.error(Exception(e));
    }
  }
}
