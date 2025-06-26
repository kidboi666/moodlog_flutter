import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/onboarding/onboarding_viewmodel.dart';
import '../../widgets/pagination_dot.dart';
import 'onboarding_nickname_pageview.dart';
import 'onboarding_personality_pageview.dart';
import 'onboarding_welcome_pageview.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Consumer<OnboardingViewModel>(
          builder: (_, viewModel, _) => PaginationDot(
            current: viewModel.currentStep,
            total: viewModel.totalSteps,
          ),
        ),
        actions: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(onPressed: () {}, child: Text('건너뛰기')),
          ),
        ],
      ),
      body: Consumer<OnboardingViewModel>(
        builder: (_, viewModel, _) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: viewModel.pageController,
                  onPageChanged: viewModel.setStep,
                  children: [
                    OnboardingWelcomePageView(),
                    OnboardingNicknamePageView(),
                    OnboardingPersonalityPageView(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SafeArea(
                child: viewModel.isLastStep
                    ? ElevatedButton(onPressed: () {}, child: Text('시작하기'))
                    : ElevatedButton(
                        onPressed: viewModel.nextStep,
                        child: Text('다음'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
