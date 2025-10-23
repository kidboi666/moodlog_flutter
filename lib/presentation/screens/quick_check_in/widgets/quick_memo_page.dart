import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
import 'package:provider/provider.dart';

class QuickMemoPage extends StatefulWidget {
  final void Function() onBack;

  const QuickMemoPage({super.key, required this.onBack});

  @override
  State<QuickMemoPage> createState() => QuickMemoPageState();
}

class QuickMemoPageState extends State<QuickMemoPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isInitialized = false;

  @override
  bool get wantKeepAlive => true;

  void requestFocus() {
    if (mounted && _focusNode.canRequestFocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final viewModel = context.read<QuickCheckInViewModel>();
      _controller.text = viewModel.memo;
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submitCheckIn() async {
    final viewModel = context.read<QuickCheckInViewModel>();
    final t = AppLocalizations.of(context)!;

    final success = await viewModel.submitCheckIn();

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(t.quick_check_in_success)));
        context.pop();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(t.quick_check_in_error)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final t = AppLocalizations.of(context)!;
    final viewModel = context.watch<QuickCheckInViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonSizedBox.heightXl,
          Text(
            t.quick_check_in_memo_question,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          CommonSizedBox.heightXl,
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: t.quick_check_in_memo_hint,
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              context.read<QuickCheckInViewModel>().setMemo(value);
            },
          ),
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
                  onPressed: viewModel.isLoading ? null : _submitCheckIn,
                  child: viewModel.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(t.quick_check_in_submit),
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
