import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRepository extends ChangeNotifier {
  User? get currentUser;

  bool get isAuthenticated;

  Stream<User?> get authStateChanges;

  Future<UserCredential> signInAnonymously();

  Future<void> signInWithGoogle();

  Future<void> signOut();
}
