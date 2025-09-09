part of 'write_screen.dart';

class _WriteScreenContent extends StatefulWidget {
  @override
  State<_WriteScreenContent> createState() => _WriteScreenContentState();
}

class _WriteScreenContentState extends State<_WriteScreenContent> {
  late TextEditingController _contentController;
  late FocusNode _contentFocusNode;
  bool _isInitialized = false;

  void _onContentChanged() {
    context.read<WriteViewModel>().updateContent(_contentController.text);
  }

  void _changeInitialized() {
    setState(() {
      _isInitialized = true;
    });
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
    _contentController = TextEditingController();
    _contentFocusNode = FocusNode();
    _contentController.addListener(_onContentChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<WriteViewModel>();
      if (!viewModel.isEditMode) {
        Future.delayed(DelayMs.lazy, _showMoodSelectionBottomSheet);
      }
      if (viewModel.content != null && _contentController.text.isEmpty) {
        _contentController.text = viewModel.content!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Glower(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(context),
        body: Builder(
          builder: (context) {
            final content = context.select<WriteViewModel, String?>(
              (vm) => vm.content,
            );
            final isEditMode = context.select<WriteViewModel, bool>(
              (vm) => vm.isEditMode,
            );

            if (!_isInitialized && content != null && isEditMode) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_contentController.text.isEmpty) {
                  _contentController.text = content;
                  _changeInitialized();
                }
              });
            }

            return Stack(
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
                              final isSubmitted = context
                                  .select<WriteViewModel, bool>(
                                    (vm) => vm.isSubmitted,
                                  );
                              final submittedJournalId = context
                                  .select<WriteViewModel, int?>(
                                    (vm) => vm.submittedJournalId,
                                  );
                              if (isSubmitted) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  context.goToJournalFromWrite(
                                    submittedJournalId!,
                                  );
                                });
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          const SizedBox(height: Spacing.md),
                          // FadeIn(
                          //   delay: DelayMs.quick,
                          //   child: const ImagePreviewSection(),
                          // ),
                          Column(
                            children: [
                              const SizedBox(height: Spacing.md),
                              FadeIn(
                                delay: DelayMs.quick * 2,
                                child: ContentInput(
                                  contentController: _contentController,
                                  focusNode: _contentFocusNode,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Spacing.xxl),
                          FadeIn(
                            delay: DelayMs.quick * 3,
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
                  child: EditorBottomPanel(
                    contentController: _contentController,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
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
      title: Builder(
        builder: (context) {
          return TextButton(
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
          );
        },
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
    _contentController.removeListener(_onContentChanged);
    _contentController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }
}
