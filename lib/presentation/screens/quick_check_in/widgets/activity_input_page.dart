import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
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
                viewModel.addTag(value);
                _controller.clear();
              }
            },
          ),
          CommonSizedBox.heightMd,
          const _TagList(),
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

class _TagList extends StatelessWidget {
  const _TagList();

  @override
  Widget build(BuildContext context) {
    final selectedTags = context.select(
      (QuickCheckInViewModel vm) => vm.selectedTags,
    );

    if (selectedTags.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: Spacing.xs,
      runSpacing: Spacing.xs,
      alignment: WrapAlignment.start,
      children: selectedTags
          .map(
            (tag) => Chip(
              label: Text(tag),
              onDeleted: () =>
                  context.read<QuickCheckInViewModel>().removeTag(tag),
              deleteIcon: const Icon(Icons.close, size: 16),
            ).scale(),
          )
          .toList(),
    );
  }
}
