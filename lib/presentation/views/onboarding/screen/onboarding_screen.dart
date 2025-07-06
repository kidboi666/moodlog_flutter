import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../view_models/onboarding/onboarding_viewmodel.dart';
import '../../../widgets/pagination_dot.dart';
import '../widgets/onboarding_pageview_nickname.dart';
import '../widgets/onboarding_pageview_personality.dart';
import '../widgets/onboarding_pageview_success.dart';
import '../widgets/onboarding_pageview_welcome.dart';

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
    _pageController = PageController(initialPage: 0);
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: widget.viewModel.setStep,
                children: [
                  OnboardingPageViewWelcome(
                    viewModel: widget.viewModel,
                    onNext: onNext,
                  ),
                  OnboardingPageViewNickName(
                    viewModel: widget.viewModel,
                    onNext: onNext,
                  ),
                  OnboardingPageViewPersonality(
                    viewModel: widget.viewModel,
                    onNext: onNext,
                  ),
                  OnboardingPageViewSuccess(
                    viewModel: widget.viewModel,
                    onNext: widget.viewModel.init,
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
