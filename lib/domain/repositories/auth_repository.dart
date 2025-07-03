import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  User? get currentUser;

  bool get isAuthenticated;

  Stream<User?> get authStateChanges;

  Future<void> signInAnonymously();

  Future<void> signInWithGoogle();

  Future<void> signOut();
}
