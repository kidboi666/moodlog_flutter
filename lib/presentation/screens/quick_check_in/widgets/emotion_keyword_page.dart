import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:provider/provider.dart';

class EmotionKeywordPage extends StatefulWidget {
  final void Function() onNext;
  final void Function() onBack;

  const EmotionKeywordPage({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<EmotionKeywordPage> createState() => _EmotionKeywordPageState();
}

class _EmotionKeywordPageState extends State<EmotionKeywordPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    final viewModel = context.read<QuickCheckInViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: Spacing.xl * 2),
          FadeIn(
            child: Text(
              t.quick_check_in_emotion_question,
              style: textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Spacing.xl * 2),
          FadeIn(
            delay: DelayMS.medium,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: t.quick_check_in_emotion_hint,
                filled: true,
                fillColor: colorScheme.secondaryContainer,
                border: const UnderlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  viewModel.addEmotion(value);
                  _controller.clear();
                }
              },
            ),
          ),
          const SizedBox(height: Spacing.md),
          FadeIn(
            delay: DelayMS.medium * 2,
            child: const _EmotionList(),
          ),
          const Spacer(),
          FadeIn(
            delay: DelayMS.medium * 3,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onBack,
                    child: Text(t.quick_check_in_previous),
                  ).scale(),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: FilledButton(
                    onPressed: widget.onNext,
                    child: Text(t.quick_check_in_next),
                  ).scale(),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.md),
          FadeIn(
            delay: DelayMS.medium * 4,
            child: TextButton(
              onPressed: widget.onNext,
              child: Text(t.quick_check_in_skip),
            ),
          ),
          const SizedBox(height: Spacing.xl),
        ],
      ),
    );
  }
}

class _EmotionList extends StatelessWidget {
  const _EmotionList();

  @override
  Widget build(BuildContext context) {
    final selectedEmotions = context.select(
      (QuickCheckInViewModel vm) => vm.selectedEmotions,
    );

    if (selectedEmotions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: Spacing.xs,
      runSpacing: Spacing.xs,
      alignment: WrapAlignment.start,
      children: selectedEmotions
          .map(
            (emotion) => Chip(
              label: Text(emotion),
              onDeleted: () =>
                  context.read<QuickCheckInViewModel>().removeEmotion(emotion),
              deleteIcon: const Icon(Icons.close, size: 16),
            ).scale(),
          )
          .toList(),
    );
  }
}
