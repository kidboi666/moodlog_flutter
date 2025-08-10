import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../ui/widgets/pagination_dot.dart';
import '../viewmodel/onboarding_viewmodel.dart';
import '../widgets/onboarding_pageview_nickname.dart';
import '../widgets/onboarding_pageview_personality.dart';
import '../widgets/onboarding_pageview_success.dart';
import '../widgets/onboarding_pageview_welcome.dart';

typedef PaginationDotProps = ({int current, int total});

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  void onNext() {
    _pageController.nextPage(
      duration: DurationMs.medium,
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OnboardingViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Builder(
          builder: (context) {
            final currentStep = context.select<OnboardingViewModel, int>(
              (vm) => vm.currentStep,
            );
            final totalSteps = context.select<OnboardingViewModel, int>(
              (vm) => vm.totalSteps,
            );
            return PaginationDot(current: currentStep, total: totalSteps);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: viewModel.setStep,
                children: [
                  OnboardingPageViewWelcome(onNext: onNext),
                  OnboardingPageViewNickName(onNext: onNext),
                  OnboardingPageViewPersonality(onNext: onNext),
                  const OnboardingPageViewSuccess(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
