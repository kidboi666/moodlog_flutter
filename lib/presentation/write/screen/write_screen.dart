import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../widgets/pagination_dot.dart';
import '../../widgets/pop_button.dart';
import '../viewmodel/write_viewmodel.dart';
import '../widgets/date_button.dart';
import '../widgets/write_pageview_mood.dart';
import '../widgets/write_pageview_rest.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  late PageController _pageController;

  void nextPage() {
    FocusScope.of(context).unfocus();
    _pageController.nextPage(
      duration: DurationMs.medium,
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    FocusScope.of(context).unfocus();
    _pageController.previousPage(
      duration: DurationMs.medium,
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int page) {
    FocusScope.of(context).unfocus();
    context.read<WriteViewModel>().setStep(page);
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
        leading: Selector<WriteViewModel, bool>(
          selector: (context, viewModel) => viewModel.isLastStep,
          builder: (context, isLastStep, child) {
            return PopButton(onTap: isLastStep ? previousPage : null);
          },
        ),
        title: Selector<WriteViewModel, ({int current, int total})>(
          selector: (context, viewModel) =>
              (current: viewModel.currentStep, total: viewModel.totalSteps),
          builder: (context, stepData, child) {
            return PaginationDot(
              current: stepData.current,
              total: stepData.total,
            );
          },
        ),
        actions: [
          Selector<WriteViewModel, bool>(
            selector: (context, viewModel) => viewModel.isLastStep,
            builder: (context, isLastStep, child) {
              return AnimatedCrossFade(
                crossFadeState: isLastStep
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: DurationMs.quick,
                firstChild: IconButton(
                  onPressed: nextPage,
                  icon: const Icon(Icons.arrow_forward),
                ),
                secondChild: Row(
                  children: [
                    const DateButton(),
                    Selector<WriteViewModel, bool>(
                      selector: (context, viewModel) => viewModel.isFormValid,
                      builder: (context, isFormValid, child) {
                        return IconButton(
                          onPressed: isFormValid
                              ? () => context
                                    .read<WriteViewModel>()
                                    .submitJournal()
                              : null,
                          icon: const Icon(Icons.send),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      persistentFooterButtons: [],
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          WritePageViewMood(nextPage: nextPage),
          const WritePageViewRest(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
