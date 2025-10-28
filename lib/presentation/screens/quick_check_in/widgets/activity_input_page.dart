import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
import 'package:moodlog/presentation/widgets/selectable_chip.dart';
import 'package:provider/provider.dart';

class ActivityInputPage extends StatefulWidget {
  final void Function() onNext;
  final void Function() onBack;

  const ActivityInputPage({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<ActivityInputPage> createState() => ActivityInputPageState();
}

class ActivityInputPageState extends State<ActivityInputPage>
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
            t.quick_check_in_activity_question,
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          CommonSizedBox.heightXl,
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: t.quick_check_in_activity_hint,
              border: const UnderlineInputBorder(),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                viewModel.addActivity(value);
                _controller.clear();
              }
            },
          ),
          CommonSizedBox.heightMd,
          const _SuggestedActivities(),
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

class _SuggestedActivities extends StatelessWidget {
  const _SuggestedActivities();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final selectedTags = context.select(
      (QuickCheckInViewModel vm) => vm.selectedTags,
    );

    final suggestions = SuggestedActivities.activities
        .map((key) {
          switch (key) {
            case 'suggested_activity_exercise':
              return t.suggested_activity_exercise;
            case 'suggested_activity_study':
              return t.suggested_activity_study;
            case 'suggested_activity_work':
              return t.suggested_activity_work;
            case 'suggested_activity_cooking':
              return t.suggested_activity_cooking;
            case 'suggested_activity_reading':
              return t.suggested_activity_reading;
            case 'suggested_activity_walking':
              return t.suggested_activity_walking;
            case 'suggested_activity_cleaning':
              return t.suggested_activity_cleaning;
            case 'suggested_activity_shopping':
              return t.suggested_activity_shopping;
            case 'suggested_activity_gaming':
              return t.suggested_activity_gaming;
            case 'suggested_activity_watching':
              return t.suggested_activity_watching;
            case 'suggested_activity_music':
              return t.suggested_activity_music;
            case 'suggested_activity_travel':
              return t.suggested_activity_travel;
            case 'suggested_activity_friends':
              return t.suggested_activity_friends;
            case 'suggested_activity_family':
              return t.suggested_activity_family;
            case 'suggested_activity_rest':
              return t.suggested_activity_rest;
            default:
              return '';
          }
        })
        .where((text) => text.isNotEmpty)
        .toList();

    final customTags = selectedTags
        .where((tag) => !suggestions.contains(tag))
        .toList();

    final allTags = [...customTags, ...suggestions];

    if (allTags.isEmpty) {
      return CommonSizedBox.empty;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: Spacing.xs,
        runSpacing: Spacing.xs,
        alignment: WrapAlignment.start,
        children: allTags.map((tag) {
        final isSelected = selectedTags.contains(tag);

        return SelectableChip(
          label: tag,
          isSelected: isSelected,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
          onSelected: (selected) {
            if (selected) {
              context.read<QuickCheckInViewModel>().addActivity(tag);
            } else {
              context.read<QuickCheckInViewModel>().removeTag(tag);
            }
          },
        );
      }).toList(),
      ),
    );
  }
}
