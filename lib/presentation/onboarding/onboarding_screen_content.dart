part of 'onboarding_screen.dart';

class _OnboardingScreenContent extends StatefulWidget {
  @override
  State<_OnboardingScreenContent> createState() =>
      _OnboardingScreenContentState();
}

class _OnboardingScreenContentState extends State<_OnboardingScreenContent> {
  late PageController _pageController;

  void onNext() {
    _pageController.nextPage(
      duration: DurationMS.medium,
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OnboardingViewModel>();

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
}
