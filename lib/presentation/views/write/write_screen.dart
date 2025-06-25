import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes.dart';
import '../../view_models/write/write_viewmodel.dart';

class WriteScreen extends StatefulWidget {
  final WriteViewModel viewModel;

  const WriteScreen({super.key, required this.viewModel});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_listener);
  }

  void _listener() {
    if (widget.viewModel.isSubmitted) {
      context.go(
        Routes.journal(widget.viewModel.submittedJournalId.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Write'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'content',
              ),
              onChanged: widget.viewModel.onContentChange,
            ),
            TextField(onChanged: widget.viewModel.onMoodNameChange),
            ElevatedButton(
              onPressed: widget.viewModel.onSubmit,
              child: Text('submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_listener);
    super.dispose();
  }
}
