import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _auth;

  AuthRepositoryImpl({required FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<UserCredential> signInAnonymously() {
    try {
      return _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
