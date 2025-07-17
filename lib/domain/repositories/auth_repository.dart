import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRepository extends ChangeNotifier {
  User? get user;

  bool get isAuthenticated;

  Stream<User?> get authStateChanges;

  bool get isAnonymousUser;

  Future<void> signInAnonymously();

  Future<void> updateDisplayName(String displayName);

  Future<void> signInWithGoogle();

  Future<void> linkWithCredential();

  Future<void> signOut();
}
