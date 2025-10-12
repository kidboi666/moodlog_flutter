import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/ui/widgets/pagination_dot.dart';
import 'package:moodlog/presentation/onboarding/onboarding_view_model.dart';
import 'package:moodlog/presentation/onboarding/widgets/onboarding_pageview_nickname.dart';
import 'package:moodlog/presentation/onboarding/widgets/onboarding_pageview_personality.dart';
import 'package:moodlog/presentation/onboarding/widgets/onboarding_pageview_success.dart';
import 'package:moodlog/presentation/onboarding/widgets/onboarding_pageview_welcome.dart';
import 'package:provider/provider.dart';

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
