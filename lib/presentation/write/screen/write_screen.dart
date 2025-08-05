import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/date_time.dart';
import '../../core/widgets/pop_button.dart';
import '../viewmodel/write_viewmodel.dart';
import '../widgets/editor_bottom_panel.dart';
import '../widgets/write_pageview_rest.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  late TextEditingController _contentController;
  late FocusNode _contentFocusNode;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
    _contentFocusNode = FocusNode();
    _contentController.addListener(_onContentChanged);
  }

  void _onContentChanged() {
    context.read<WriteViewModel>().updateContent(_contentController.text);
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = context.select<WriteViewModel, bool>(
      (vm) => vm.isEditMode,
    );
    final submitJournal = context.read<WriteViewModel>().submitJournal;
    final updateSelectedDate = context
        .read<WriteViewModel>()
        .updateSelectedDate;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const PopButton(icon: Icons.close),
        title: Builder(
          builder: (context) {
            final selectedDate = context.select<WriteViewModel, DateTime>(
              (vm) => vm.selectedDate,
            );

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
                      updateSelectedDate(newDate);
                    }
                  }
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
          Builder(
            builder: (context) {
              final isFormValid = context.select<WriteViewModel, bool>(
                (vm) => vm.isFormValid,
              );

              return IconButton(
                onPressed: isFormValid ? submitJournal : null,
                icon: Icon(isEditMode ? Icons.check : Icons.send),
              );
            },
          ),
        ],
      ),
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
                _isInitialized = true;
              }
            });
          }

          return Column(
            children: [
              WritePageViewRest(contentController: _contentController),
              const Spacer(),
              EditorBottomPanel(contentController: _contentController),
            ],
          );
        },
      ),
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
