import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/date_time.dart';

import '../../../view_models/entries/entries_viewmodel.dart';
import '../../../widgets/journal_card.dart';

class EntriesScreen extends StatefulWidget {
  final EntriesViewModel viewModel;

  const EntriesScreen({super.key, required this.viewModel});

  @override
  State<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  DateTime _selectedMonth = DateTime.now();

  void _setPreviousMonth() {
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month - 1,
        1,
      );
    });
  }

  void _setNextMonth() {
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month + 1,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedMonth.formattedDotNationWithMonth()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _setPreviousMonth(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () => _setNextMonth(),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              return ListView(
                shrinkWrap: true,
                children: widget.viewModel.entries
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
