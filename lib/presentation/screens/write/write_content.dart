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

  @override
  void initState() {
    super.initState();
    _contentFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (:isSubmitted, :submittedJournalId) = context.select(
      (WriteViewModel vm) => (
        isSubmitted: vm.isSubmitted,
        submittedJournalId: vm.submittedJournalId,
      ),
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
                        CommonSizedBox.heightMd,
                        FadeIn(
                          delay: DelayMS.quick * 2,
                          child: Builder(
                            builder: (context) {
                              final textEditingController = context.select(
                                (WriteViewModel vm) => vm.textEditingController,
                              );
                              return ContentInput(
                                textEditingController: textEditingController,
                                focusNode: _contentFocusNode,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    CommonSizedBox.heightXxl,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Builder(
              builder: (context) {
                final textEditingController = context.select(
                  (WriteViewModel vm) => vm.textEditingController,
                );
                return EditorBottomPanel(
                  textEditingController: textEditingController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final (:isEditMode, :isFormValid, :selectedDate) = context.select(
      (WriteViewModel vm) => (
        isEditMode: vm.isEditMode,
        isFormValid: vm.isFormValid,
        selectedDate: vm.selectedDate,
      ),
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
                context.read<WriteViewModel>().updateSelectedDate(newDate);
              }
            }
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Spacing.sm,
          children: [
            Text(
              DateFormat('yyyy.MM.dd').format(selectedDate),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: isFormValid
              ? context.read<WriteViewModel>().submitJournal
              : null,
          icon: Icon(isEditMode ? Icons.check : Icons.send),
        ),
      ],
    );
  }
}
