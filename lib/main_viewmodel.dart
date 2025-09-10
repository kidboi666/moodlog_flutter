import 'package:flutter/cupertino.dart';

import 'presentation/providers/user_provider.dart';

class MainViewModel extends ChangeNotifier {
  final UserProvider _userProvider;

  MainViewModel({required UserProvider userProvider})
    : _userProvider = userProvider;

  String? get profileImage => _userProvider.user?.photoURL;

  String? get nickname =>
      _userProvider.user?.displayName ??
      _userProvider.user?.email?.split('@').first;
}
