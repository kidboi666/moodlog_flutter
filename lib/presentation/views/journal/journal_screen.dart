import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/presentation/widgets/pop_button.dart';
import 'package:moodlog/router/routes.dart';

import '../../view_models/journal/journal_viewmodel.dart';

class JournalScreen extends StatelessWidget {
  final JournalViewModel viewModel;

  const JournalScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final journal = viewModel.journal;
    print(journal);
    return Scaffold(
      appBar: AppBar(
        leading: PopButton(
          onTap: viewModel.source == 'write'
              ? () => context.replace(Routes.home)
              : null,
        ),
      ),
      body: Column(children: [Text(journal?.content ?? '')]),
    );
  }
}
