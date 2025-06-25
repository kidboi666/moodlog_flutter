import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../router/routes.dart';
import '../../view_models/write/write_viewmodel.dart';
import '../../widgets/pop_button.dart';

class WriteScreen extends StatefulWidget {
  final WriteViewModel viewModel;

  const WriteScreen({super.key, required this.viewModel});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  bool light = true;

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
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: PopButton(),
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
                fillColor: Theme.of(context).colorScheme.surfaceContainer,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelText: t.write_input_placeholder,
              ),
              onChanged: widget.viewModel.onContentChange,
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(Icons.radio),
                    Column(
                      children: [
                        Text('AI 위로 메시지'),
                        Text('일기 작성 후 AI가 위로와 격려의 메시지를 보내드려요.'),
                      ],
                    ),
                    Switch(
                      value: light,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        setState(() {
                          light = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
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
