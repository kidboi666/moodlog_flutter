import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/date_time.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';
import '../../widgets/pop_button.dart';
import '../viewmodel/journal_viewmodel.dart';
import 'ai_response_box.dart';
import 'content_box.dart';
import 'mood_bar.dart';

class JournalScreen extends StatelessWidget {
  final JournalViewModel viewModel;

  const JournalScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        if (viewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Color(viewModel.journal.moodType.colorValue),
            leading: PopButton(
              onTap: () => viewModel.handleBackNavigation(context),
            ),
            title: Text(
              viewModel.journal.createdAt.formatted(
                AppLocalizations.of(context)!,
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              IconButton(
                onPressed: viewModel.changeAlign,
                icon: Icon(viewModel.currentAlign.icon),
              ),
              IconButton(
                onPressed: () => viewModel.handleDelete(context),
                icon: const Icon(Icons.delete),
              ),
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
              SizedBox(height: Spacing.lg),
              FadeIn(
                delay: DelayMs.quick * 2,
                child: AiResponseBox(viewModel: viewModel),
              ),
            ],
          ),
        );
      },
    );
  }
}
