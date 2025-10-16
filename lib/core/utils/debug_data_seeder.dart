import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';

class DebugDataSeeder {
  final JournalUseCase _journalUseCase;
  final Logger _log = Logger('DebugDataSeeder');

  DebugDataSeeder(this._journalUseCase);

  Future<void> seedJournalsIfEmpty() async {
    final journalsResult = await _journalUseCase.getJournals();
    bool isEmpty = false;
    switch (journalsResult) {
      case Ok(value: final journals):
        isEmpty = journals.isEmpty;
      case Error():
        isEmpty = true;
    }

    if (isEmpty) {
      _log.info('No journals found. Seeding sample data...');
      try {
        const jsonFileName = 'assets/data/sample_journals_en.json';

        _log.info('Loading seed data from: $jsonFileName');
        final jsonString = await rootBundle.loadString(jsonFileName);
        final List<dynamic> jsonList = json.decode(jsonString);

        for (final json in jsonList) {
          final request = CreateJournalRequest(
            content: json['content'],
            createdAt: DateTime.parse(json['createdAt']),
          );
          await _journalUseCase.createJournal(request);
        }
        _log.info('Successfully seeded ${jsonList.length} sample journals.');
      } catch (e, stackTrace) {
        _log.severe('Failed to seed sample journals', e, stackTrace);
      }
    } else {
      _log.info('Journals already exist. Skipping seeding.');
    }
  }
}
