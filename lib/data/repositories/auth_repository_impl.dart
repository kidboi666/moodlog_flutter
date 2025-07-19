import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({FirebaseAuth? auth})
    : _firebaseAuth = auth ?? FirebaseAuth.instance {
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  User? _user;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get user => _user;

  @override
  bool get isAuthenticated => _user != null;

  @override
  bool get isAnonymousUser => _user?.isAnonymous ?? false;

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> linkWithCredential() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.currentUser
          ?.linkWithCredential(credential);
      _user = userCredential?.user;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateDisplayName(String displayName) async {
    try {
      await _user?.updateDisplayName(displayName);
      await _user?.reload();
      _user = _firebaseAuth.currentUser;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> updateProfileImage(String profileImage) async {
    try {
      await _user?.updatePhotoURL(profileImage);
      await _user?.reload();
      _user = _firebaseAuth.currentUser;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }
}
