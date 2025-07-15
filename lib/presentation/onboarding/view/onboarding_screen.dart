import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../widgets/pagination_dot.dart';
import '../viewmodel/onboarding_viewmodel.dart';
import 'onboarding_pageview_nickname.dart';
import 'onboarding_pageview_personality.dart';
import 'onboarding_pageview_success.dart';
import 'onboarding_pageview_welcome.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: PaginationDot(
          current: context.watch<OnboardingViewModel>().currentStep,
          total: context.watch<OnboardingViewModel>().totalSteps,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: context.read<OnboardingViewModel>().setStep,
                children: [
                  OnboardingPageViewWelcome(onNext: onNext),
                  OnboardingPageViewNickName(onNext: onNext),
                  OnboardingPageViewPersonality(onNext: onNext),
                  OnboardingPageViewSuccess(
                    onNext: context.read<OnboardingViewModel>().init,
                  ),
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
