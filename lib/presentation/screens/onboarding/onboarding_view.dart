import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/presentation/screens/onboarding/onboarding_view_model.dart';
import 'package:moodlog/presentation/screens/onboarding/widgets/onboarding_pageview_success.dart';
import 'package:moodlog/presentation/screens/onboarding/widgets/onboarding_pageview_welcome.dart';
import 'package:moodlog/presentation/widgets/pagination_dot.dart';
import 'package:provider/provider.dart';

part 'onboarding_content.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingViewModel(
        totalSteps: 2,
        appStateProvider: context.read(),
        localUserUseCase: context.read(),
        userProvider: context.read(),
      ),
      child: _OnboardingScreenContent(),
    );
  }
}
