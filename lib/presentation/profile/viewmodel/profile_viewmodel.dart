import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/repositories/auth_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  ProfileViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;

  User? _user;

  User? get user => _user;

  Future<void> fetchUserProfile() async {
    final user = _authRepository.isAuthenticated;
    notifyListeners();
    print(user);
    // if (user != null) {
    //   _user = user;
    //   notifyListeners();
    // }
  }
}
