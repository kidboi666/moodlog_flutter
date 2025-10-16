import 'package:drift/drift.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';

class EmotionLocalDataSource {
  final MoodLogDatabase _database;

  EmotionLocalDataSource(this._database);

  Future<List<Emotion>> getAllEmotions() async {
    return await (_database.select(_database.emotions)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future<Emotion> createEmotion(String name) async {
    final id = await _database.into(_database.emotions).insert(
          EmotionsCompanion.insert(
            name: name,
          ),
        );

    final emotion = await (_database.select(_database.emotions)
          ..where((t) => t.id.equals(id)))
        .getSingle();

    return emotion;
  }

  Future<void> deleteEmotion(int id) async {
    await (_database.delete(_database.emotions)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<Emotion?> getEmotionByName(String name) async {
    final result = await (_database.select(_database.emotions)
          ..where((t) => t.name.equals(name)))
        .getSingleOrNull();
    return result;
  }

  Future<List<int>> getOrCreateEmotions(List<String> emotionNames) async {
    final emotionIds = <int>[];

    for (final emotionName in emotionNames) {
      final trimmedName = emotionName.trim();
      if (trimmedName.isEmpty) continue;

      final existing = await getEmotionByName(trimmedName);

      if (existing != null) {
        emotionIds.add(existing.id);
      } else {
        final newEmotion = await createEmotion(trimmedName);
        emotionIds.add(newEmotion.id);
      }
    }

    return emotionIds;
  }

  Future<void> createJournalEmotion(int journalId, int emotionId) async {
    await _database.into(_database.journalEmotions).insert(
          JournalEmotionsCompanion.insert(
            journalId: journalId,
            emotionId: emotionId,
          ),
        );
  }

  Future<List<Emotion>> getEmotionsByJournalId(int journalId) async {
    final query = _database.select(_database.emotions).join([
      innerJoin(
        _database.journalEmotions,
        _database.journalEmotions.emotionId.equalsExp(_database.emotions.id),
      ),
    ])
      ..where(_database.journalEmotions.journalId.equals(journalId));

    final results = await query.get();
    return results.map((row) => row.readTable(_database.emotions)).toList();
  }

  Future<void> deleteJournalEmotions(int journalId) async {
    await (_database.delete(_database.journalEmotions)
          ..where((t) => t.journalId.equals(journalId)))
        .go();
  }
}
