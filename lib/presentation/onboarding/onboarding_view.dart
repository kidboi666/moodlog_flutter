import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/ui/widgets/pagination_dot.dart';
import 'onboarding_view_model.dart';
import 'widgets/onboarding_pageview_nickname.dart';
import 'widgets/onboarding_pageview_personality.dart';
import 'widgets/onboarding_pageview_success.dart';
import 'widgets/onboarding_pageview_welcome.dart';

part 'onboarding_content.dart';

typedef PaginationDotProps = ({int current, int total});

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingViewModel(
        totalSteps: 4,
        appStateProvider: context.read(),
        localUserRepository: context.read(),
        userProvider: context.read(),
      ),
      child: _OnboardingScreenContent(),
    );
  }
}
