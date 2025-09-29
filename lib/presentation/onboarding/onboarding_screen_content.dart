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

  void onBack() {
    _pageController.previousPage(
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
      appBar: _buildAppBar(context),
      body: Column(
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
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final currentStep = context.select(
      (OnboardingViewModel vm) => vm.currentStep,
    );
    final totalSteps = context.select(
      (OnboardingViewModel vm) => vm.totalSteps,
    );
    final loginType = context.select((OnboardingViewModel vm) => vm.loginType);

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        padding: EdgeInsets.zero,
        onPressed: () {
          if (currentStep == 0) {
            if (loginType == LoginMethod.anonymous) {
              context.pushReplacement(Routes.signIn);
            } else {
              Navigator.of(context).pop();
            }
          } else {
            onBack();
          }
        },
      ),
      title: PaginationDot(current: currentStep, total: totalSteps),
      centerTitle: true,
      actions: [const IconButton(onPressed: null, icon: Icon(null))],
      actionsPadding: EdgeInsets.all(Spacing.lg),
    );
  }
}
