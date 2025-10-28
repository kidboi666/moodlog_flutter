import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
import 'package:moodlog/presentation/widgets/selectable_chip.dart';
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
            style: Theme.of(context).textTheme.headlineMedium,
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
          const _SuggestedEmotions(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: widget.onBack,
                child: const Icon(Icons.arrow_back),
              ),
              FloatingActionButton(
                onPressed: widget.onNext,
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          CommonSizedBox.heightXl,
        ],
      ),
    );
  }
}

class _SuggestedEmotions extends StatelessWidget {
  const _SuggestedEmotions();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final selectedEmotions = context.select(
      (QuickCheckInViewModel vm) => vm.selectedEmotions,
    );

    final suggestions = SuggestedEmotions.emotions
        .map((key) {
          switch (key) {
            case 'suggested_emotion_joy':
              return t.suggested_emotion_joy;
            case 'suggested_emotion_happiness':
              return t.suggested_emotion_happiness;
            case 'suggested_emotion_peace':
              return t.suggested_emotion_peace;
            case 'suggested_emotion_satisfaction':
              return t.suggested_emotion_satisfaction;
            case 'suggested_emotion_excitement':
              return t.suggested_emotion_excitement;
            case 'suggested_emotion_gratitude':
              return t.suggested_emotion_gratitude;
            case 'suggested_emotion_love':
              return t.suggested_emotion_love;
            case 'suggested_emotion_confidence':
              return t.suggested_emotion_confidence;
            case 'suggested_emotion_anxiety':
              return t.suggested_emotion_anxiety;
            case 'suggested_emotion_worry':
              return t.suggested_emotion_worry;
            case 'suggested_emotion_sadness':
              return t.suggested_emotion_sadness;
            case 'suggested_emotion_anger':
              return t.suggested_emotion_anger;
            case 'suggested_emotion_irritation':
              return t.suggested_emotion_irritation;
            case 'suggested_emotion_tired':
              return t.suggested_emotion_tired;
            case 'suggested_emotion_loneliness':
              return t.suggested_emotion_loneliness;
            default:
              return '';
          }
        })
        .where((text) => text.isNotEmpty)
        .toList();

    final customEmotions = selectedEmotions
        .where((emotion) => !suggestions.contains(emotion))
        .toList();

    final allEmotions = [...customEmotions, ...suggestions];

    if (allEmotions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: Spacing.xs,
        runSpacing: Spacing.xs,
        alignment: WrapAlignment.start,
        children: allEmotions.map((emotion) {
        final isSelected = selectedEmotions.contains(emotion);
        return SelectableChip(
          label: emotion,
          isSelected: isSelected,
          onSelected: (selected) {
            final viewModel = context.read<QuickCheckInViewModel>();
            if (selected) {
              viewModel.addEmotion(emotion);
            } else {
              viewModel.removeEmotion(emotion);
            }
          },
        );
      }).toList(),
      ),
    );
  }
}
