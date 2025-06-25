import 'package:flutter/material.dart';

import '../../view_models/journal/journal_viewmodel.dart';

class JournalScreen extends StatelessWidget {
  final JournalViewModel viewModel;

  const JournalScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final journal = viewModel.journal;

    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Column(children: [Text(journal?.content ?? '')]),
    );
  }
}
