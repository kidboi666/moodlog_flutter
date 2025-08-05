import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/constants/enum.dart';
import '../../../common/extensions/enum.dart';
import '../../../common/extensions/routing.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../core/widgets/fade_in.dart';
import '../viewmodel/write_viewmodel.dart';
import 'ai_enable_card.dart';
import 'bottom_sheet/mood_selection_bottom_sheet.dart';
import 'content_input.dart';
import 'image_preview_section.dart';
import 'location_button.dart';
import 'location_card.dart';
import 'tag_input_section.dart';
import 'weather_card.dart';

class WritePageViewRest extends StatefulWidget {
  final TextEditingController contentController;

  const WritePageViewRest({super.key, required this.contentController});

  @override
  State<WritePageViewRest> createState() => _WritePageViewRestState();
}

class _WritePageViewRestState extends State<WritePageViewRest> {
  late FocusNode _contentFocusNode;

  void _onContentChanged() {
    context.read<WriteViewModel>().updateContent(widget.contentController.text);
  }

  void _dismissKeyboard() {
    _contentFocusNode.unfocus();
    FocusScope.of(context).unfocus();
  }

  Future<void> _showMoodSelectionBottomSheet() async {
    final viewModel = context.read<WriteViewModel>();
    final selectedMood = await showModalBottomSheet<MoodType>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => ChangeNotifierProvider.value(
        value: viewModel,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(bottomSheetContext).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: const MoodSelectionBottomSheet(),
        ),
      ),
    );

    if (selectedMood != null && mounted) {
      viewModel.updateMoodType(selectedMood);
    }
  }

  @override
  void initState() {
    super.initState();
    _contentFocusNode = FocusNode();
    widget.contentController.addListener(_onContentChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<WriteViewModel>();
      // 수정 모드가 아닐 때만 바텀시트 표시
      if (!viewModel.isEditMode) {
        _showMoodSelectionBottomSheet();
      }

      // 수정 모드일 때는 기존 내용 로드
      if (viewModel.content != null && widget.contentController.text.isEmpty) {
        widget.contentController.text = viewModel.content!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _dismissKeyboard();
        }
      },
      child: Expanded(
        child: Padding(
          padding: Spacing.containerHorizontalPadding,
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  final isSubmitted = context.select<WriteViewModel, bool>(
                    (vm) => vm.isSubmitted,
                  );
                  final submittedJournalId = context
                      .select<WriteViewModel, int?>(
                        (vm) => vm.submittedJournalId,
                      );
                  if (isSubmitted) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.goToJournalFromWrite(submittedJournalId!);
                    });
                  }

                  return const SizedBox.shrink();
                },
              ),
              FadeIn(
                delay: DelayMs.instant,
                child: Builder(
                  builder: (context) {
                    final selectedMood = context
                        .select<WriteViewModel, MoodType>(
                          (vm) => vm.selectedMood,
                        );
                    final t = AppLocalizations.of(context)!;
                    return Card(
                      child: ListTile(
                        leading: Text(
                          selectedMood.emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                        title: Text(selectedMood.getDisplayName(context)),
                        subtitle: Text(t.write_mood_subtitle),
                        trailing: const Icon(Icons.edit),
                        onTap: () => _showMoodSelectionBottomSheet(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: Spacing.md),
              FadeIn(delay: DelayMs.quick, child: const ImagePreviewSection()),
              Column(
                children: [
                  FadeIn(
                    delay: DelayMs.quick * 1.5,
                    child: Row(
                      children: [
                        const WeatherCard(),
                        const LocationButton(),
                        const LocationCard(),
                      ],
                    ),
                  ),
                  FadeIn(
                    delay: DelayMs.quick * 2,
                    child: ContentInput(
                      contentController: widget.contentController,
                      focusNode: _contentFocusNode,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.xxl),
              FadeIn(delay: DelayMs.quick * 4, child: const TagInputSection()),
              const SizedBox(height: Spacing.md),
              FadeIn(delay: DelayMs.quick * 3, child: const AiEnableCard()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.contentController.removeListener(_onContentChanged);
    _contentFocusNode.dispose();
    super.dispose();
  }
}
