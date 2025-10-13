import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/data/data_source/local/journal_local_data_source.dart';
import 'package:moodlog/data/repositories/backup_repository_impl.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';

// Mocks using mocktail
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockJournalLocalDataSource extends Mock implements JournalLocalDataSource {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late BackupRepositoryImpl backupRepository;
  late MockFirebaseFirestore mockFirestore;
  late MockJournalLocalDataSource mockLocalDataSource;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late MockDocumentSnapshot mockDocumentSnapshot;

  setUpAll(() {
    registerFallbackValue(Timestamp.now());
  });

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockLocalDataSource = MockJournalLocalDataSource();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();

    backupRepository = BackupRepositoryImpl(
      firestore: mockFirestore,
      localDataSource: mockLocalDataSource,
    );

    // Default mock behaviors
    when(() => mockFirestore.collection(any())).thenReturn(mockCollectionReference);
    when(() => mockCollectionReference.doc(any())).thenReturn(mockDocumentReference);
    when(() => mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
  });

  group('BackupRepositoryImpl', () {
    const userId = 'test_user_id';
    final testJournal = Journal(
      id: 1,
      moodType: MoodType.happy,
      createdAt: DateTime(2024, 1, 1),
      aiResponseEnabled: false,
      content: 'Test content',
      tagNames: ['test1', 'test2'],
    );
    final testTag = Tag(id: 1, name: 'test1', createdAt: DateTime(2024, 1, 1));

    group('backup', () {
      test('should correctly serialize and send data to Firestore', () async {
        // Arrange
        when(() => mockLocalDataSource.getJournals()).thenAnswer((_) async => [testJournal]);
        when(() => mockLocalDataSource.getAllTags()).thenAnswer((_) async => [testTag]);
        when(() => mockDocumentReference.set(any())).thenAnswer((_) async {});

        // Act
        await backupRepository.backup(userId: userId);

        // Assert
        final captured = verify(() => mockDocumentReference.set(captureAny())).captured.single as Map<String, dynamic>;
        expect(captured['journals'], isA<List>());
        expect(captured['tags'], isA<List>());
        expect(captured['journals'][0]['id'], testJournal.id);
        expect(captured['tags'][0]['name'], testTag.name);
        expect(captured['backupTimestamp'], isA<FieldValue>());
      });
    });

    group('restore', () {
      test('should fetch, deserialize, and save data to local source', () async {
        // Arrange
        final backupData = {
          'journals': [
            {
              'id': testJournal.id,
              'moodType': testJournal.moodType.name,
              'createdAt': Timestamp.fromDate(testJournal.createdAt),
              'aiResponseEnabled': testJournal.aiResponseEnabled,
              'content': testJournal.content,
              'tagNames': testJournal.tagNames,
              'imageUri': null,
              'aiResponse': null,
              'latitude': null,
              'longitude': null,
              'address': null,
              'temperature': null,
              'weatherIcon': null,
              'weatherDescription': null,
            }
          ],
          'tags': [
            {
              'id': testTag.id,
              'name': testTag.name,
              'createdAt': Timestamp.fromDate(testTag.createdAt),
            }
          ],
        };
        when(() => mockDocumentSnapshot.exists).thenReturn(true);
        when(() => mockDocumentSnapshot.data()).thenReturn(backupData);
        when(() => mockLocalDataSource.clearAllData()).thenAnswer((_) async {});
        when(() => mockLocalDataSource.insertJournalsAndTags(any(), any())).thenAnswer((_) async {});
        when(() => mockLocalDataSource.linkJournalsToTags(any())).thenAnswer((_) async {});

        // Act
        await backupRepository.restore(userId: userId);

        // Assert
        verify(() => mockLocalDataSource.clearAllData()).called(1);
        final capturedInsert = verify(() => mockLocalDataSource.insertJournalsAndTags(captureAny(), captureAny())).captured;
        expect(capturedInsert[0], isA<List<JournalsCompanion>>());
        expect(capturedInsert[1], isA<List<TagsCompanion>>());
        
        final capturedLink = verify(() => mockLocalDataSource.linkJournalsToTags(captureAny())).captured.single as Map<int, List<String>>;
        expect(capturedLink[testJournal.id], testJournal.tagNames);
      });

      test('should throw an exception when no backup is found', () async {
        // Arrange
        when(() => mockDocumentSnapshot.exists).thenReturn(false);

        // Act & Assert
        expect(
          () => backupRepository.restore(userId: userId),
          throwsA(isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('No backup found'),
          )),
        );
      });
    });
  });
}
