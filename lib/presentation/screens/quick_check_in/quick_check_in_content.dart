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
    Future.delayed(DurationMS.quick, () {
      if (hasSleedPage) {
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
    final (:isCheckingFirstCheckIn, :isFirstCheckInToday, :totalSteps) = context
        .select(
          (QuickCheckInViewModel vm) => (
            isCheckingFirstCheckIn: vm.isCheckingFirstCheckIn,
            isFirstCheckInToday: vm.isFirstCheckInToday,
            totalSteps: vm.totalSteps,
          ),
        );

    if (isCheckingFirstCheckIn) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final localTotalSteps = isFirstCheckInToday ? 5 : 4;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (totalSteps != localTotalSteps) {
        context.read<QuickCheckInViewModel>().initStep(totalSteps);
      }
    });

    final pages = <Widget>[
      MoodSelectionPage(onNext: onNext),
      if (isFirstCheckInToday) SleepQualityPage(onNext: onNext, onBack: onBack),
      ActivityInputPage(key: _activityKey, onNext: onNext, onBack: onBack),
      EmotionKeywordPage(key: _emotionKey, onNext: onNext, onBack: onBack),
      QuickMemoPage(key: _memoKey, onBack: onBack),
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
                context.read<QuickCheckInViewModel>().setStep(index);
                _requestFocusForPage(index, isFirstCheckInToday);
              },
              children: pages,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final (
      :currentStep,
      :totalSteps,
      :createdAt,
      :temperature,
      :weatherDescription,
      :isLoadingWeather,
    ) = context.select(
      (QuickCheckInViewModel vm) => (
        currentStep: vm.currentStep,
        totalSteps: vm.totalSteps,
        createdAt: vm.createdAt,
        temperature: vm.temperature,
        weatherDescription: vm.weatherDescription,
        isLoadingWeather: vm.isLoadingWeather,
      ),
    );
    final t = AppLocalizations.of(context)!;

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        padding: EdgeInsets.zero,
        onPressed: () => context.pop(),
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
                            style: Theme.of(context).textTheme.titleMedium,
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
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          CommonSizedBox.heightSm,
                          Text(
                            weatherDescription,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: Text(t.common_confirm_ok),
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
