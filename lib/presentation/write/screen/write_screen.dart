import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/l10n/app_localizations.dart';
import '../../core/widgets/pop_button.dart';
import '../viewmodel/write_viewmodel.dart';
import '../widgets/date_button.dart';
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

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
    _contentFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<WriteViewModel>();
      // 수정 모드일 때는 기존 내용 로드
      if (viewModel.content != null && _contentController.text.isEmpty) {
        _contentController.text = viewModel.content!;
      }
    });

    _contentController.addListener(_onContentChanged);
  }

  void _onContentChanged() {
    context.read<WriteViewModel>().updateContent(_contentController.text);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const PopButton(),
        title: Builder(
          builder: (context) {
            final isEditMode = context.select<WriteViewModel, bool>(
              (vm) => vm.isEditMode,
            );
            return Text(isEditMode ? t.write_edit_title : t.write_title);
          },
        ),
        actions: [
          const DateButton(),
          Builder(
            builder: (context) {
              final isEditMode = context.select<WriteViewModel, bool>(
                (vm) => vm.isEditMode,
              );
              final isFormValid = context.select<WriteViewModel, bool>(
                (vm) => vm.isFormValid,
              );
              final submitJournal = context
                  .read<WriteViewModel>()
                  .submitJournal;

              return IconButton(
                onPressed: isFormValid ? submitJournal : null,
                icon: Icon(isEditMode ? Icons.check : Icons.send),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          WritePageViewRest(contentController: _contentController),
          EditorBottomPanel(contentController: _contentController),
        ],
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
