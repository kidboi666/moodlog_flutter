import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/common/constants/enum.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/extensions/date_time.dart';
import '../../../common/extensions/widget_scale.dart';
import '../../../common/routing/routes.dart';
import '../../../domain/entities/journal.dart';
import '../../core/widgets/fade_in.dart';
import '../../core/widgets/pop_button.dart';
import '../viewmodel/journal_viewmodel.dart';
import '../widgets/ai_response_box.dart';
import '../widgets/content_box.dart';
import '../widgets/dialog/delete_confirm_dialog.dart';
import '../widgets/mood_bar.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  void _handleBackNavigation(BuildContext context, JournalViewModel viewModel) {
    if (viewModel.shouldReplaceOnPop) {
      context.replace(Routes.home);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final viewModel = context.read<JournalViewModel>();
    final isLoading = context.select<JournalViewModel, bool>(
      (vm) => vm.isLoading,
    );
    final journal = context.select<JournalViewModel, Journal>(
      (vm) => vm.journal,
    );
    final align = context.select<JournalViewModel, SimpleTextAlign>(
      (vm) => vm.currentAlign,
    );

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleBackNavigation(context, viewModel);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Color(journal.moodType.colorValue),
          leading: PopButton(
            onTap: () => _handleBackNavigation(context, viewModel),
          ),
          title: Text(
            journal.createdAt.formattedDotNation(),
            style: textTheme.titleLarge,
          ),
          actions: [
            IconButton(
              onPressed: viewModel.changeAlign,
              icon: Icon(align.icon),
            ).scale(),
            IconButton(
              onPressed: () {
                context.push('${Routes.write}?editJournalId=${viewModel.id}');
              },
              icon: const Icon(Icons.edit),
            ).scale(),
            IconButton(
              onPressed: () async {
                final shouldPopPage = await showDialog(
                  context: context,
                  builder: (context) => DeleteConfirmDialog(
                    viewModel: viewModel,
                    id: viewModel.id,
                  ),
                );
                if (shouldPopPage) {
                  if (context.mounted) {
                    _handleBackNavigation(context, viewModel);
                  }
                }
              },
              icon: const Icon(Icons.delete),
            ).scale(),
          ],
        ),
        body: ListView(
          children: [
            IntrinsicHeight(
              child: FadeIn(
                delay: DelayMs.quick,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MoodBar(moodType: journal.moodType),
                    ContentBox(viewModel: viewModel, currentAlign: align),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),
            FadeIn(
              delay: DelayMs.quick * 2,
              child: AiResponseBox(viewModel: viewModel),
            ),
          ],
        ),
      ),
    );
  }
}
