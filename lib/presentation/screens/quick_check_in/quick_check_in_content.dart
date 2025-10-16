part of 'quick_check_in_view.dart';

class _QuickCheckInContent extends StatefulWidget {
  @override
  State<_QuickCheckInContent> createState() => _QuickCheckInContentState();
}

class _QuickCheckInContentState extends State<_QuickCheckInContent> {
  late PageController _pageController;
  final GlobalKey<ActivityInputPageState> _activityKey = GlobalKey();
  final GlobalKey<EmotionKeywordPageState> _emotionKey = GlobalKey();
  final GlobalKey<QuickMemoPageState> _memoKey = GlobalKey();

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

  void _requestFocusForPage(int index, bool hasSleedPage) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (hasSleedPage) {
        // With sleep page: mood(0), sleep(1), activity(2), emotion(3), memo(4)
        switch (index) {
          case 2:
            _activityKey.currentState?.requestFocus();
            break;
          case 3:
            _emotionKey.currentState?.requestFocus();
            break;
          case 4:
            _memoKey.currentState?.requestFocus();
            break;
        }
      } else {
        // Without sleep page: mood(0), activity(1), emotion(2), memo(3)
        switch (index) {
          case 1:
            _activityKey.currentState?.requestFocus();
            break;
          case 2:
            _emotionKey.currentState?.requestFocus();
            break;
          case 3:
            _memoKey.currentState?.requestFocus();
            break;
        }
      }
    });
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

    // Wait for first check-in check to complete
    if (viewModel.isCheckingFirstCheckIn) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final isFirstCheckIn = viewModel.isFirstCheckInToday;
    final totalSteps = isFirstCheckIn ? 5 : 4;

    // Update total steps if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.totalSteps != totalSteps) {
        viewModel.initStep(totalSteps);
      }
    });

    // Build pages dynamically
    final pages = <Widget>[
      MoodSelectionPage(onNext: onNext),
      if (isFirstCheckIn)
        SleepQualityPage(
          onNext: onNext,
          onBack: onBack,
        ),
      ActivityInputPage(
        key: _activityKey,
        onNext: onNext,
        onBack: onBack,
      ),
      EmotionKeywordPage(
        key: _emotionKey,
        onNext: onNext,
        onBack: onBack,
      ),
      QuickMemoPage(
        key: _memoKey,
        onBack: onBack,
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                FocusScope.of(context).unfocus();
                viewModel.setStep(index);
                _requestFocusForPage(index, isFirstCheckIn);
              },
              children: pages,
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
    final createdAt = context.select(
      (QuickCheckInViewModel vm) => vm.createdAt,
    );
    final temperature = context.select(
      (QuickCheckInViewModel vm) => vm.temperature,
    );
    final weatherDescription = context.select(
      (QuickCheckInViewModel vm) => vm.weatherDescription,
    );
    final isLoadingWeather = context.select(
      (QuickCheckInViewModel vm) => vm.isLoadingWeather,
    );

    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: PaginationDot(current: currentStep, total: totalSteps),
      centerTitle: true,
      actions: [
        IconButton(
          icon: isLoadingWeather
              ? const SizedBox(child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.wb_sunny_outlined),
          onPressed: temperature != null && weatherDescription != null
              ? () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          CommonSizedBox.widthSm,
                          Text(DateFormat.yMMMd().format(createdAt)),
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.Hm().format(createdAt),
                            style: textTheme.titleMedium,
                          ),
                          CommonSizedBox.heightMd,
                          const Divider(),
                          CommonSizedBox.heightMd,
                          Row(
                            children: [
                              const Icon(Icons.wb_sunny),
                              CommonSizedBox.widthSm,
                              Text(
                                '${temperature.toStringAsFixed(1)}°C',
                                style: textTheme.titleMedium,
                              ),
                            ],
                          ),
                          CommonSizedBox.heightSm,
                          Text(weatherDescription, style: textTheme.bodyMedium),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('확인'),
                        ),
                      ],
                    ),
                  );
                }
              : null,
        ),
      ],
    );
  }
}
