import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../core/routing/routes.dart';
import '../../core/ui/widgets/pagination_dot.dart';
import 'onboarding_view_model.dart';
import 'widgets/onboarding_pageview_nickname.dart';
import 'widgets/onboarding_pageview_personality.dart';
import 'widgets/onboarding_pageview_success.dart';
import 'widgets/onboarding_pageview_welcome.dart';

part 'onboarding_content.dart';

typedef PaginationDotProps = ({int current, int total});

class OnboardingScreen extends StatelessWidget {
  final LoginMethod loginType;

  const OnboardingScreen({super.key, required this.loginType});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingViewModel(
        totalSteps: 4,
        appStateProvider: context.read(),
        authUseCase: context.read(),
        authRepository: context.read(),
        loginType: loginType,
      ),
      child: _OnboardingScreenContent(),
    );
  }
}
