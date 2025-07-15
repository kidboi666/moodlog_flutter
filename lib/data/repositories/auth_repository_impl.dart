import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  User? _user;

  AuthRepositoryImpl({FirebaseAuth? auth})
    : _firebaseAuth = auth ?? FirebaseAuth.instance {
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get user => _user;

  @override
  bool get isAuthenticated => _user != null;

  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      if (userCredential.user != null) {
        _user = userCredential.user;
        notifyListeners();
        print('User signed in anonymously: ${_user}');
      } else {
        throw Exception('User is null');
      }
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
