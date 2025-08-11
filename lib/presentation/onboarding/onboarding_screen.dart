import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/ui/widgets/pagination_dot.dart';
import 'onboarding_viewmodel.dart';
import 'widgets/onboarding_pageview_nickname.dart';
import 'widgets/onboarding_pageview_personality.dart';
import 'widgets/onboarding_pageview_success.dart';
import 'widgets/onboarding_pageview_welcome.dart';

part 'onboarding_screen_content.dart';

typedef PaginationDotProps = ({int current, int total});

class OnboardingScreen extends StatelessWidget {
  final LoginType loginType;
  const OnboardingScreen({super.key, required this.loginType});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingViewModel(
        totalSteps: 4,
        appStateProvider: context.read(),
        authRepository: context.read(),
        loginType: loginType,
      ),
      child: _OnboardingScreenContent(),
    );
  }
}
