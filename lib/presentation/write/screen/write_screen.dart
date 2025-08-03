import 'package:flutter/material.dart';
import 'package:moodlog/presentation/write/widgets/editor_bottom_panel.dart';
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
  late TextEditingController _contentController;

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
    _contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                WritePageViewMood(nextPage: nextPage),
                WritePageViewRest(contentController: _contentController),
              ],
            ),
          ),
          EditorBottomPanel(contentController: _contentController),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
