part of 'quick_check_in_view.dart';

class _QuickCheckInContent extends StatefulWidget {
  @override
  State<_QuickCheckInContent> createState() => _QuickCheckInContentState();
}

class _QuickCheckInContentState extends State<_QuickCheckInContent> {
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
    final viewModel = context.watch<QuickCheckInViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: viewModel.setStep,
              children: [
                MoodSelectionPage(onNext: onNext),
                ActivityInputPage(onNext: onNext, onBack: onBack),
                EmotionKeywordPage(onNext: onNext, onBack: onBack),
                QuickMemoPage(onNext: onNext, onBack: onBack),
                WeatherDateTimePage(onBack: onBack),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final currentStep = context.select(
      (QuickCheckInViewModel vm) => vm.currentStep,
    );
    final totalSteps = context.select(
      (QuickCheckInViewModel vm) => vm.totalSteps,
    );

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: PaginationDot(current: currentStep, total: totalSteps),
      centerTitle: true,
      actions: [const IconButton(onPressed: null, icon: Icon(null))],
      actionsPadding: EdgeInsets.all(Spacing.lg),
    );
  }
}
