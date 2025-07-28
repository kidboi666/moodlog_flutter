import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../../core/extensions/widget_scale.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../widgets/fade_in.dart';
import '../../widgets/pop_button.dart';
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
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Consumer<JournalViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
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
              surfaceTintColor: Color(viewModel.journal.moodType.colorValue),
              leading: PopButton(
                onTap: () => _handleBackNavigation(context, viewModel),
              ),
              title: Text(
                viewModel.journal.createdAt.formatted(t),
                style: textTheme.titleMedium,
              ),
              actions: [
                IconButton(
                  onPressed: viewModel.changeAlign,
                  icon: Icon(viewModel.currentAlign.icon),
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
                        MoodBar(moodType: viewModel.journal.moodType),
                        ContentBox(
                          viewModel: viewModel,
                          currentAlign: viewModel.currentAlign,
                        ),
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
      },
    );
  }
}
