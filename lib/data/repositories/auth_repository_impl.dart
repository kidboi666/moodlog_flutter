import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show
        FirebaseAuth,
        GoogleAuthProvider,
        AppleAuthProvider,
        AppleFullPersonName;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/extensions/firebase_extension.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({FirebaseAuth? auth})
    : _firebaseAuth = auth ?? FirebaseAuth.instance;

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

      final credential = GoogleAuthProvider.credential(
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
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      final googleUser = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        _log.severe('Failed to get Google ID token');
        throw Exception('Failed to get Google ID token');
      }

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        final user = userCredential.user!;

        if (googleUser.displayName != null &&
            googleUser.displayName!.isNotEmpty) {
          await user.updateDisplayName(googleUser.displayName!);
          _log.info('Updated display name to: ${googleUser.displayName}');
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
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.logmind.moodlog.signin',
          redirectUri: Uri.parse(
            'https://moodlog-ba790.firebaseapp.com/__/auth/handler',
          ),
        ),
      );

      if (appleCredential.identityToken == null) {
        _log.severe('Failed to get Apple credential token');
        throw Exception('Failed to get Apple credential token');
      }

      final fullname = AppleFullPersonName(
        givenName: appleCredential.givenName,
        familyName: appleCredential.familyName,
      );
      final credential = AppleAuthProvider.credentialWithIDToken(
        appleCredential.identityToken!,
        rawNonce,
        fullname,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        final user = userCredential.user!;
        final displayName = _buildDisplayName(
          appleCredential.givenName,
          appleCredential.familyName,
        );

        if (displayName != null && displayName.isNotEmpty) {
          await user.updateDisplayName(displayName);
          _log.info('Updated display name to: $displayName');
        }

        await user.reload();
        final updatedUser = _firebaseAuth.currentUser;
        return Result.ok(updatedUser?.toDomain());
      }

      return Result.ok(userCredential.user?.toDomain());
    } catch (e) {
      _log.severe('Failed to authenticate with Apple : $e');
      return Result.error(Exception(e));
    }
  }

  String? _buildDisplayName(String? givenName, String? familyName) {
    if (givenName == null && familyName == null) return null;

    final parts = <String>[];
    if (givenName?.isNotEmpty == true) parts.add(givenName!);
    if (familyName?.isNotEmpty == true) parts.add(familyName!);

    return parts.isEmpty ? null : parts.join(' ');
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<Result<void>> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Result.error(Exception('No user is currently logged in'));
      }

      await user.delete();
      return Result.ok(null);
    } catch (e) {
      _log.severe('Failed to delete account: $e');
      return Result.error(Exception(e));
    }
  }
}
