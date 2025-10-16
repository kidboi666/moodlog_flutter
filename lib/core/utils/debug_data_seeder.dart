import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/models/create_check_in_request.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/use_cases/check_in_use_case.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';

class DebugDataSeeder {
  final CheckInUseCase _checkInUseCase;
  final JournalUseCase _journalUseCase;
  final Logger _log = Logger('DebugDataSeeder');

  DebugDataSeeder(this._checkInUseCase, this._journalUseCase);

  Future<void> seedDataIfEmpty() async {
    await seedCheckInsIfEmpty();
    await seedJournalsIfEmpty();
  }

  Future<void> seedCheckInsIfEmpty() async {
    final checkInsResult = await _checkInUseCase.getAllCheckIns();
    bool isEmpty = false;
    switch (checkInsResult) {
      case Ok(value: final checkIns):
        isEmpty = checkIns.isEmpty;
      case Error():
        isEmpty = true;
    }

    if (isEmpty) {
      _log.info('No check-ins found. Seeding sample check-ins...');
      try {
        const jsonFileName = 'assets/data/sample_check_ins.json';

        _log.info('Loading check-in seed data from: $jsonFileName');
        final jsonString = await rootBundle.loadString(jsonFileName);
        final List<dynamic> jsonList = json.decode(jsonString);

        for (final json in jsonList) {
          final request = CreateCheckInRequest(
            moodType: MoodType.values.byName(json['moodType'] as String),
            createdAt: DateTime.parse(json['createdAt']),
            tagNames: (json['tagNames'] as List?)?.cast<String>(),
            emotionNames: (json['emotionNames'] as List?)?.cast<String>(),
            sleepQuality: json['sleepQuality'] as int?,
            memo: json['memo'] as String?,
          );
          await _checkInUseCase.createCheckIn(request);
        }
        _log.info('Successfully seeded ${jsonList.length} sample check-ins.');
      } catch (e, stackTrace) {
        _log.severe('Failed to seed sample check-ins', e, stackTrace);
      }
    } else {
      _log.info('Check-ins already exist. Skipping seeding.');
    }
  }

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
      _log.info('No journals found. Seeding sample journals...');
      try {
        const jsonFileName = 'assets/data/sample_journals.json';

        _log.info('Loading journal seed data from: $jsonFileName');
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
