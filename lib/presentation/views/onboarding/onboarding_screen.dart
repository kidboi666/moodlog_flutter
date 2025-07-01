import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import '../../view_models/onboarding/onboarding_viewmodel.dart';
import '../../widgets/pagination_dot.dart';
import 'onboarding_nickname_pageview.dart';
import 'onboarding_personality_pageview.dart';
import 'onboarding_success_pageview.dart';
import 'onboarding_welcome_pageview.dart';

class OnboardingScreen extends StatefulWidget {
  final OnboardingViewModel viewModel;

  const OnboardingScreen({super.key, required this.viewModel});

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
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (_, _) => PaginationDot(
            current: widget.viewModel.currentStep,
            total: widget.viewModel.totalSteps,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: widget.viewModel.setStep,
                children: [
                  OnboardingWelcomePageView(
                    viewModel: widget.viewModel,
                    onNext: onNext,
                  ),
                  OnboardingNicknamePageView(
                    viewModel: widget.viewModel,
                    onNext: onNext,
                  ),
                  OnboardingPersonalityPageView(
                    viewModel: widget.viewModel,
                    onNext: onNext,
                  ),
                  OnboardingSuccessPageView(
                    viewModel: widget.viewModel,
                    onNext: widget.viewModel.init,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
