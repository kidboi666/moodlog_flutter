import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../view_models/write/write_viewmodel.dart';
import '../../../widgets/pagination_dot.dart';
import '../../../widgets/pop_button.dart';
import '../widgets/write_pageview_mood.dart';
import '../widgets/write_pageview_rest.dart';

class WriteScreen extends StatefulWidget {
  final WriteViewModel viewModel;

  const WriteScreen({super.key, required this.viewModel});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  late PageController _pageController;

  void nextPage() {
    _pageController.nextPage(
      duration: DurationMs.medium,
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    _pageController.previousPage(
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
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            leading: Row(
              children: [
                PopButton(
                  onTap: widget.viewModel.isLastStep ? previousPage : null,
                ),
              ],
            ),
            title: PaginationDot(
              current: widget.viewModel.currentStep,
              total: widget.viewModel.totalSteps,
            ),
            actions: [
              AnimatedCrossFade(
                crossFadeState: widget.viewModel.isLastStep
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: DurationMs.quick,
                firstChild: IconButton(
                  onPressed: nextPage,
                  icon: Icon(Icons.arrow_forward),
                ),
                secondChild: IconButton(
                  onPressed: widget.viewModel.submitJournal,
                  icon: Icon(Icons.send),
                ),
              ),
            ],
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: widget.viewModel.setStep,
            children: [
              WritePageViewMood(viewModel: widget.viewModel),
              WritePageViewRest(viewModel: widget.viewModel),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
