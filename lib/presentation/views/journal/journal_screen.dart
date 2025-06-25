import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../view_models/journal/journal_viewmodel.dart';

class JournalScreen extends StatelessWidget {
  final JournalViewModel viewModel;

  const JournalScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final journal = viewModel.journal;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_left),
        ),
      ),
      body: Column(children: [Text(journal?.content ?? '')]),
    );
  }
}
