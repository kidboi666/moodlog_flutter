import 'package:provider/provider.dart';

import 'core/utils/debug_data_seeder.dart';
import 'core/utils/flavor_config.dart';
import 'domain/use_cases/journal_use_case.dart';
import 'main.dart' as app;

Future<void> main() async {
  FlavorConfig(flavor: Flavor.development, showDebugBanner: true);

  return app.main(
    onAppStartedDev: (context) async {
      final journalUseCase = context.read<JournalUseCase>();
      final seeder = DebugDataSeeder(journalUseCase);
      await seeder.seedJournalsIfEmpty();
    },
  );
}
