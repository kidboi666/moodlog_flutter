import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../core/utils/result.dart';

abstract class AuthRepository extends ChangeNotifier {
  Stream<User?> get userChanges;

  bool get isAuthenticated;

  bool get isAnonymousUser;

  Future<Result<User?>> getCurrentUser();

  Future<Result<User?>> signInAnonymously();

  Future<Result<void>> updateDisplayName(String displayName);

  Future<Result<User?>> signInWithGoogle();

  Future<Result<User?>> linkWithCredential();

  Future<void> signOut();

  Future<Result<void>> updateProfileImage(String profileImage);
}
