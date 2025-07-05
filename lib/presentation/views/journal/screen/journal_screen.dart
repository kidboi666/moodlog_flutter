import 'package:flutter/material.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/extensions/date_time.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../presentation/widgets/pop_button.dart';
import '../../../view_models/journal/journal_viewmodel.dart';
import '../widgets/ai_response_box.dart';
import '../widgets/content_box.dart';
import '../widgets/mood_bar.dart';

class JournalScreen extends StatefulWidget {
  final JournalViewModel viewModel;

  const JournalScreen({super.key, required this.viewModel});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        if (widget.viewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Color(
              widget.viewModel.journal.moodType.colorValue,
            ),
            leading: PopButton(
              onTap: () => widget.viewModel.handleBackNavigation(context),
            ),
            title: Text(
              widget.viewModel.journal.createdAt.formatted(
                AppLocalizations.of(context)!,
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              IconButton(
                onPressed: widget.viewModel.changeAlign,
                icon: Icon(widget.viewModel.currentAlign.icon),
              ),
              IconButton(
                onPressed: () => widget.viewModel.handleDelete(context),
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
                      MoodBar(moodType: widget.viewModel.journal.moodType),
                      ContentBox(
                        viewModel: widget.viewModel,
                        currentAlign: widget.viewModel.currentAlign,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Spacing.lg),
              FadeIn(
                delay: DelayMs.quick * 2,
                child: AiResponseBox(viewModel: widget.viewModel),
              ),
            ],
          ),
        );
      },
    );
  }
}
