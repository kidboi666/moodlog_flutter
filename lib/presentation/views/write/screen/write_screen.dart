import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/presentation/views/write/widgets/content_input.dart';
import 'package:moodlog/presentation/views/write/widgets/image_picking_section.dart';
import 'package:moodlog/presentation/views/write/widgets/mood_selector.dart';

import '../../../../router/routes.dart';
import '../../../view_models/write/write_viewmodel.dart';
import '../../../widgets/pop_button.dart';
import '../widgets/ai_enable_card.dart';

class WriteScreen extends StatefulWidget {
  final WriteViewModel viewModel;

  const WriteScreen({super.key, required this.viewModel});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentController.addListener(() {
      widget.viewModel.updateContent(_contentController.text);
    });
    widget.viewModel.addListener(_listener);
  }

  void _listener() {
    if (widget.viewModel.isSubmitted) {
      context.go(
        Routes.journal(widget.viewModel.submittedJournalId.toString()),
        extra: {'source': 'write'},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopButton(),
        title: Text(DateTime.now().toIso8601String().split('T')[0]),
        actions: [
          IconButton(
            onPressed: widget.viewModel.onSubmit,
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) {
            return Form(
              child: Column(
                spacing: 20,
                children: [
                  ImagePickingSection(viewModel: widget.viewModel),
                  ContentInput(
                    viewModel: widget.viewModel,
                    contentController: _contentController,
                  ),
                  AiEnableCard(viewModel: widget.viewModel),
                  MoodSelector(
                    onMoodSelected: widget.viewModel.updateMoodType,
                    selectedMood: widget.viewModel.moodType,
                    viewModel: widget.viewModel,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    widget.viewModel.removeListener(_listener);
    super.dispose();
  }
}
