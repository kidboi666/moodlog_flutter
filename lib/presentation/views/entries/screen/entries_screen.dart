import 'package:flutter/material.dart';
import 'package:moodlog/presentation/widgets/journal_card.dart';

import '../../../view_models/entries/entries_viewmodel.dart';

class EntriesScreen extends StatelessWidget {
  final EntriesViewModel viewModel;

  const EntriesScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: viewModel.entries
                    .map(
                      (e) => JournalCard(
                        id: e.id,
                        content: e.content ?? '',
                        moodName: e.moodName,
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
