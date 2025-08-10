import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../core/l10n/app_localizations.dart';
import '../ui/widgets/fade_in.dart';
import 'auth_viewmodel.dart';
import 'widgets/google_signin_button.dart';
import 'widgets/guest_signin_button.dart';
import 'widgets/kakao_signin_button.dart';
import 'widgets/sign_in_terms_message.dart';

part 'sign_in_screen_content.dart';

class SignInScreen extends StatelessWidget {
  final SignInSource? source;

  const SignInScreen({super.key, this.source});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthViewModel(
        authRepository: context.read(),
        appStateProvider: context.read(),
      ),
      child: _SignInScreenContent(source: source),
    );
  }
}
