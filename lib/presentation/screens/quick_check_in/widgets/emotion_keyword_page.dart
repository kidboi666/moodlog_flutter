import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
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
  State<EmotionKeywordPage> createState() => EmotionKeywordPageState();
}

class EmotionKeywordPageState extends State<EmotionKeywordPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  bool get wantKeepAlive => true;

  void requestFocus() {
    if (mounted && _focusNode.canRequestFocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    final viewModel = context.read<QuickCheckInViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonSizedBox.heightXl,
          Text(
            t.quick_check_in_emotion_question,
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          CommonSizedBox.heightXl,
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: t.quick_check_in_emotion_hint,
              border: const UnderlineInputBorder(),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                viewModel.addEmotion(value);
                _controller.clear();
              }
            },
          ),
          CommonSizedBox.heightMd,
          const _EmotionList(),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onBack,
                  child: Text(t.quick_check_in_previous),
                ).scale(),
              ),
              CommonSizedBox.widthMd,
              Expanded(
                child: FilledButton(
                  onPressed: widget.onNext,
                  child: Text(t.quick_check_in_next),
                ).scale(),
              ),
            ],
          ),
          CommonSizedBox.heightXl,
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
