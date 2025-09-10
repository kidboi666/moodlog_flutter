import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:test/test.dart';

import 'fake_database.dart';

void main() {
  late FakeDatabase db;

  setUp(() {
    db = FakeDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
  });

  tearDown(() async {
    await db.close();
  });

  final journalToInsert = Journal(
    id: 1,
    content: 'Test journal',
    moodType: MoodType.happy,
    imageUri: ['image1.jpg', 'image2.jpg'],
    createdAt: DateTime.now(),
    aiResponseEnabled: true,
  );

  JournalsCompanion createCompanion(Journal journal) {
    return JournalsCompanion(
      id: Value(journal.id),
      content: Value(journal.content),
      moodType: Value(journal.moodType),
      imageUri: Value(journal.imageUri),
      createdAt: Value(journal.createdAt),
      aiResponseEnabled: Value(journal.aiResponseEnabled),
      latitude: Value(journal.latitude),
      longitude: Value(journal.longitude),
      address: Value(journal.address),
      temperature: Value(journal.temperature),
      weatherIcon: Value(journal.weatherIcon),
      weatherDescription: Value(journal.weatherDescription),
    );
  }

  test('데이터를 쓴뒤 저장된 값 확인하기', () async {
    await db
        .into(db.journals)
        .insertReturningOrNull(createCompanion(journalToInsert));

    final readJournal = await (db.select(
      db.journals,
    )..where((tbl) => tbl.id.equals(journalToInsert.id))).getSingle();

    expect(readJournal.id, journalToInsert.id);
    expect(readJournal.content, journalToInsert.content);
    expect(readJournal.moodType, journalToInsert.moodType);
    expect(readJournal.imageUri, journalToInsert.imageUri);
    expect(readJournal.aiResponseEnabled, journalToInsert.aiResponseEnabled);
    expect(readJournal.latitude, journalToInsert.latitude);
    expect(readJournal.longitude, journalToInsert.longitude);
    expect(readJournal.address, journalToInsert.address);
  });
}
