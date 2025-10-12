import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:provider/provider.dart';

import 'core/services/default_data_service.dart';
import 'core/services/flavor_service.dart';
import 'core/utils/debug_data_seeder.dart';
import 'domain/use_cases/journal_use_case.dart';
import 'domain/use_cases/tag_use_case.dart';
import 'main.dart' as app;

Future<void> main() async {
  FlavorService(flavor: Flavor.development, showDebugBanner: true);

  return app.main(
    onAppStartedDev: (context) async {
      final db = context.read<MoodLogDatabase>();
      final tagUseCase = context.read<TagUseCase>();
      final journalUseCase = context.read<JournalUseCase>();
      final t = AppLocalizations.of(context)!;

      await db.clearAllTables();

      await DefaultDataService(tagUseCase).seedDefaultTagsIfEmpty(t);

      // 4. Seed sample journals
      final seeder = DebugDataSeeder(journalUseCase);
      await seeder.seedJournalsIfEmpty(t);
    },
  );
}
