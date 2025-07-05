import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/date_time.dart';

import '../../../view_models/entries/entries_viewmodel.dart';
import '../../../widgets/journal_card.dart';

class EntriesScreen extends StatelessWidget {
  final EntriesViewModel viewModel;

  const EntriesScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(viewModel.selectedMonth.formattedDotNationWithMonth()),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => viewModel.setPreviousMonth(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => viewModel.setNextMonth(),
              ),
            ],
          ),
          body: ListView(
            children: [
              ListView(
                shrinkWrap: true,
                children: viewModel.entries
                    .map(
                      (e) => JournalCard(
                        id: e.id,
                        content: e.content ?? '',
                        moodType: e.moodType,
                        createdAt: e.createdAt,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
