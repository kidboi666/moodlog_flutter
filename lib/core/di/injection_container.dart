import 'package:moodlog/data/repositories/gemini_repository_impl.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/data_source/database.dart';
import '../../data/repositories/app_state_repository_impl.dart';
import '../../data/repositories/journal_repository_impl.dart';
import '../../domain/repositories/app_state_repository.dart';
import '../../domain/repositories/journal_repository.dart';

List<SingleChildWidget> createProviders() {
  return [
    Provider<MoodLogDatabase>(
      create: (_) => MoodLogDatabase(),
      dispose: (_, db) => db.close(),
      lazy: false,
    ),
    ProxyProvider<MoodLogDatabase, JournalRepository>(
      update: (_, db, previous) => previous ?? JournalRepositoryImpl(db: db),
    ),
    ChangeNotifierProxyProvider<MoodLogDatabase, AppStateRepository>(
      create: (context) {
        final db = context.read<MoodLogDatabase>();
        return AppStateRepositoryImpl(db: db);
      },
      update: (_, db, previous) => previous ?? AppStateRepositoryImpl(db: db),
    ),
    Provider<GeminiRepository>(
      create: (_) => GeminiRepositoryImpl.instance,
      lazy: false,
    ),
  ];
}
