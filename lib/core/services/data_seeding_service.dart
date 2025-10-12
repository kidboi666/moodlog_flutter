// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/services/default_data_service.dart';
import 'package:moodlog/core/services/flavor_service.dart';
import 'package:moodlog/core/utils/debug_data_seeder.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';
import 'package:provider/provider.dart';

class DataSeedingService {
  final BuildContext context;

  DataSeedingService(this.context);

  Future<void> run() async {
    // Always seed default tags if empty
    final tagUseCase = context.read<TagUseCase>();
    await DefaultDataService(tagUseCase).seedDefaultTagsIfEmpty(context);

    // Seed sample journals only in development
    if (FlavorService.isDevelopment) {
      final journalUseCase = context.read<JournalUseCase>();
      final t = AppLocalizations.of(context)!;
      final seeder = DebugDataSeeder(journalUseCase);
      await seeder.seedJournalsIfEmpty(t);
    }
  }

  Future<void> clearDatabaseForDevelopment() async {
    if (FlavorService.isDevelopment) {
      final db = context.read<MoodLogDatabase>();
      await db.clearAllTables();
    }
  }
}
