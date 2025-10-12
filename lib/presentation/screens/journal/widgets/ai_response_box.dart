import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/journal/journal_view_model.dart';

class AiResponseBox extends StatefulWidget {
  final JournalViewModel viewModel;

  const AiResponseBox({super.key, required this.viewModel});

  @override
  State<AiResponseBox> createState() => _AiResponseBoxState();
}

class _AiResponseBoxState extends State<AiResponseBox>
    with TickerProviderStateMixin {
  late AnimationController _typingController;

  @override
  void initState() {
    super.initState();
    _typingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _typingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final journal = widget.viewModel.journal;

    if (journal == null) {
      return const SizedBox.shrink();
    }

    return Offstage(
      offstage: !journal.aiResponseEnabled,
      child: Card(
        color: Color(journal.moodType.colorValue).withValues(alpha: 0.6),
        margin: const EdgeInsets.all(Spacing.md),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: AnimatedCrossFade(
            crossFadeState: journal.aiResponse != null
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: DurationMS.lazy,
            firstChild: Column(
              spacing: Spacing.xl,
              children: [
                Row(
                  spacing: Spacing.md,
                  children: [
                    Icon(Icons.psychology),
                    Text(
                      AppLocalizations.of(context)!.write_ai_title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Text(
                  journal.aiResponse ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            secondChild: Center(
              child: Column(
                spacing: Spacing.xl,
                children: [
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.journal_ai_generating_response_title,
                  ),
                  _buildTypingAnimation(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypingAnimation() {
    return AnimatedBuilder(
      animation: _typingController,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.psychology,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            ...List.generate(3, (index) {
              final delay = index * 0.3;
              final opacity = (_typingController.value + delay) % 1.0 > 0.5
                  ? 1.0
                  : 0.3;
              return AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
