import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/utils/result.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({FirebaseAuth? auth})
    : _firebaseAuth = auth ?? FirebaseAuth.instance;

  @override
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  @override
  bool get isAnonymousUser => _firebaseAuth.currentUser?.isAnonymous ?? false;

  @override
  Stream<User?> get userChanges => _firebaseAuth.userChanges();

  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      return Result.ok(user);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<Result<User?>> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      return Result.ok(userCredential.user);
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
      return Result.ok(userCredential.user);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<User?>> linkWithCredential() async {
    try {
      final credential = await _getGoogleCredential();
      final userCredential = await _firebaseAuth.currentUser
          ?.linkWithCredential(credential);
      return Result.ok(userCredential?.user);
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

  Future<OAuthCredential> _getGoogleCredential() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize();
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    return GoogleAuthProvider.credential(idToken: googleAuth.idToken);
  }
}
