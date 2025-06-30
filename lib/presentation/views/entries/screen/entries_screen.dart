import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import '../../../view_models/entries/entries_viewmodel.dart';
import '../../../widgets/journal_card.dart';

class EntriesScreen extends StatelessWidget {
  final EntriesViewModel viewModel;

  const EntriesScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tab_entries),
        scrolledUnderElevation: 8.0,
      ),
      body: ListView(
        children: [
          ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              return ListView(
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
              );
            },
          ),
        ],
      ),
    );
  }
}
