import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/repositories/auth_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  ProfileViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    _user = _authRepository.user;
  }

  User? _user;

  User? get user => _user;
}
