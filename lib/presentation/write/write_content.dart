part of 'write_view.dart';

class _WriteScreenContent extends StatefulWidget {
  @override
  State<_WriteScreenContent> createState() => _WriteScreenContentState();
}

class _WriteScreenContentState extends State<_WriteScreenContent> {
  late FocusNode _contentFocusNode;

  void _onDismissPreviewImage(String imageUri) {
    context.read<WriteViewModel>().deleteImage(imageUri);
  }

  void _dismissKeyboard() {
    _contentFocusNode.unfocus();
    FocusScope.of(context).unfocus();
  }

  Future<void> _showMoodSelectionBottomSheet() async {
    showModalBottomSheet<MoodType>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => ChangeNotifierProvider.value(
        value: context.read<WriteViewModel>(),
        builder: (context, child) {
          return MoodSliderSelectionBottomSheet();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<WriteViewModel>();

    _contentFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!viewModel.isEditMode) {
        Future.delayed(DelayMS.oneSecond, _showMoodSelectionBottomSheet);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // QuillController content is now handled in WriteViewModel
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitted = context.select<WriteViewModel, bool>(
      (vm) => vm.isSubmitted,
    );
    final submittedJournalId = context.select<WriteViewModel, int?>(
      (vm) => vm.submittedJournalId,
    );
    if (isSubmitted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.goToJournalFromWrite(submittedJournalId!);
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          Positioned.fill(
            child: PopScope(
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) {
                  _dismissKeyboard();
                }
              },
              child: Padding(
                padding: Spacing.containerHorizontalPadding,
                child: Column(
                  children: [
                    Builder(
                      builder: (context) {
                        final selectedImageList = context.select(
                          (WriteViewModel vm) => vm.selectedImageList,
                        );
                        return ImagePreviewSection(
                          selectedImageList: selectedImageList,
                          onTap: _onDismissPreviewImage,
                        );
                      },
                    ),
                    Column(
                      children: [
                        const SizedBox(height: Spacing.md),
                        FadeIn(
                          delay: DelayMS.quick * 2,
                          child: Consumer<WriteViewModel>(
                            builder: (context, viewModel, child) {
                              return ContentInput(
                                quillController: viewModel.quillController,
                                focusNode: _contentFocusNode,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.xxl),
                    FadeIn(
                      delay: DelayMS.quick * 3,
                      child: const AiEnableCard(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Consumer<WriteViewModel>(
              builder: (context, viewModel, child) {
                return EditorBottomPanel(
                  quillController: viewModel.quillController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final viewModel = context.read<WriteViewModel>();
    final isEditMode = context.select<WriteViewModel, bool>(
      (vm) => vm.isEditMode,
    );
    final isFormValid = context.select<WriteViewModel, bool>(
      (vm) => vm.isFormValid,
    );
    final selectedDate = context.select<WriteViewModel, DateTime>(
      (vm) => vm.selectedDate,
    );

    return AppBar(
      leading: const PopButton(icon: Icons.close),
      title: TextButton(
        onPressed: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime.now(),
            initialDate: selectedDate,
          );

          if (pickedDate != null && context.mounted) {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(selectedDate),
            );

            if (pickedTime != null) {
              final newDate = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
              if (context.mounted) {
                viewModel.updateSelectedDate(newDate);
              }
            }
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Spacing.sm,
          children: [
            Text(
              selectedDate.formattedDotNation(),
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: isFormValid ? viewModel.submitJournal : null,
          icon: Icon(isEditMode ? Icons.check : Icons.send),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _contentFocusNode.dispose();
    super.dispose();
  }
}
