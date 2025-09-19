import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show
        FirebaseAuth,
        GoogleAuthProvider,
        OAuthCredential,
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
      final credential = await _getGoogleCredential();
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
      final credential = await _getGoogleCredential();
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return Result.ok(userCredential.user?.toDomain());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<User?>> signInWithApple() async {
    try {
      final credential = await _getAppleCredential();
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return Result.ok(userCredential.user?.toDomain());
    } catch (e) {
      _log.severe('Failed to authenticate with Apple : $e');
      rethrow;
    }
  }

  Future<OAuthCredential> _getGoogleCredential() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      final googleUser = await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        _log.severe('Failed to get Google ID token');
        throw Exception('Failed to get Google ID token');
      }
      return GoogleAuthProvider.credential(idToken: googleAuth.idToken);
    } catch (e) {
      _log.severe('Failed to authenticate with Google : $e');
      rethrow;
    }
  }

  Future<OAuthCredential> _getAppleCredential() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.logmind.moodlog.signin',
          redirectUri: Uri.parse(
            'https://moodlog-75131.firebaseapp.com/__/auth/handler',
          ),
        ),
      );

      if (credential.identityToken == null) {
        _log.severe('Failed to get Apple credential token');
        throw Exception('Failed to get Apple credential token');
      }

      final fullname = AppleFullPersonName(
        givenName: credential.givenName,
        familyName: credential.familyName,
      );
      final appleCredential = AppleAuthProvider.credentialWithIDToken(
        credential.identityToken!,
        nonce,
        fullname,
      );

      return appleCredential;
    } catch (e) {
      _log.severe('Failed to authenticate with Apple : $e');
      rethrow;
    }
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
}
