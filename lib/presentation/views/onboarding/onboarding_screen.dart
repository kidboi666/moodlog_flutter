import 'package:flutter/material.dart';

import '../../view_models/onboarding/onboarding_viewmodel.dart';
import '../../widgets/pagination_dot.dart';
import 'onboarding_nickname_pageview.dart';
import 'onboarding_personality_pageview.dart';
import 'onboarding_welcome_pageview.dart';

class OnboardingScreen extends StatefulWidget {
  final OnboardingViewModel viewModel;

  const OnboardingScreen({super.key, required this.viewModel});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
        leading: SizedBox.shrink(),
        title: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (_, _) => PaginationDot(
            current: widget.viewModel.currentStep,
            total: widget.viewModel.totalSteps,
          ),
        ),
        actions: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(onPressed: () {}, child: Text('건너뛰기')),
          ),
        ],
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
                    onPageChange: () =>
                        widget.viewModel.onPageChange(_pageController),
                  ),
                  OnboardingNicknamePageView(
                    onPageChange: () =>
                        widget.viewModel.onPageChange(_pageController),
                  ),
                  OnboardingPersonalityPageView(
                    onPageChange: () =>
                        widget.viewModel.onPageChange(_pageController),
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
