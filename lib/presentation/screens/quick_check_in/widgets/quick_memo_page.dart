import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:provider/provider.dart';

class QuickMemoPage extends StatefulWidget {
  final void Function() onNext;
  final void Function() onBack;

  const QuickMemoPage({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<QuickMemoPage> createState() => _QuickMemoPageState();
}

class _QuickMemoPageState extends State<QuickMemoPage> {
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
              t.quick_check_in_memo_question,
              style: textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Spacing.xl * 2),
          FadeIn(
            delay: DelayMS.medium,
            child: TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: t.quick_check_in_memo_hint,
                filled: true,
                fillColor: colorScheme.secondaryContainer,
                border: const OutlineInputBorder(),
              ),
              onChanged: viewModel.setMemo,
            ),
          ),
          const Spacer(),
          FadeIn(
            delay: DelayMS.medium * 2,
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
            delay: DelayMS.medium * 3,
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
