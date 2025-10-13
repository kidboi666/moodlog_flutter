import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/data/data_source/local/journal_local_data_source.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/domain/repositories/backup_repository.dart';

class BackupRepositoryImpl implements BackupRepository {
  final FirebaseFirestore _firestore;
  final JournalLocalDataSource _localDataSource;

  BackupRepositoryImpl({
    required FirebaseFirestore firestore,
    required JournalLocalDataSource localDataSource,
  }) : _firestore = firestore,
       _localDataSource = localDataSource;

  Map<String, dynamic> _journalToMap(Journal journal) {
    return {
      'id': journal.id,
      'moodType': journal.moodType.name,
      'createdAt': Timestamp.fromDate(journal.createdAt),
      'aiResponseEnabled': journal.aiResponseEnabled,
      'content': journal.content,
      'imageUri': journal.imageUri,
      'aiResponse': journal.aiResponse,
      'latitude': journal.latitude,
      'longitude': journal.longitude,
      'address': journal.address,
      'temperature': journal.temperature,
      'weatherIcon': journal.weatherIcon,
      'weatherDescription': journal.weatherDescription,
      'tagNames': journal.tagNames,
    };
  }

  Map<String, dynamic> _tagToMap(Tag tag) {
    return {
      'id': tag.id,
      'name': tag.name,
      'createdAt': Timestamp.fromDate(tag.createdAt),
    };
  }

  @override
  Future<void> backup({required String userId}) async {
    // 1. Get user ID
    // const userId = 'test_user'; // Replaced with parameter

    // 2. Fetch all local data
    final journals = await _localDataSource.getJournals();
    final tags = await _localDataSource.getAllTags();
    // TODO: Fetch other data if necessary (e.g., settings)

    // 3. Serialize data
    final backupData = {
      'journals': journals.map(_journalToMap).toList(),
      'tags': tags.map(_tagToMap).toList(),
      'backupTimestamp': FieldValue.serverTimestamp(),
    };

    // 4. Write to Firestore
    final backupDocRef = _firestore.collection('backups').doc(userId);
    await backupDocRef.set(backupData);
  }

  @override
  Future<void> restore({required String userId}) async {
    // 1. Fetch data from Firestore
    final backupDocRef = _firestore.collection('backups').doc(userId);
    final backupSnapshot = await backupDocRef.get();

    if (!backupSnapshot.exists) {
      throw Exception('No backup found for the user.');
    }

    final backupData = backupSnapshot.data() as Map<String, dynamic>;

    // 2. Deserialize data
    final journalsData = backupData['journals'] as List<dynamic>;
    final tagsData = backupData['tags'] as List<dynamic>;

    final journals = journalsData.map((data) {
      final map = data as Map<String, dynamic>;
      return JournalsCompanion(
        id: Value(map['id']),
        moodType: Value(MoodType.values.byName(map['moodType'])),
        createdAt: Value((map['createdAt'] as Timestamp).toDate()),
        aiResponseEnabled: Value(map['aiResponseEnabled']),
        content: Value(map['content']),
        imageUri: Value.absentIfNull(map['imageUri'] as List<String>?),
        aiResponse: Value(map['aiResponse']),
        latitude: Value(map['latitude']),
        longitude: Value(map['longitude']),
        address: Value(map['address']),
        temperature: Value(map['temperature']),
        weatherIcon: Value(map['weatherIcon']),
        weatherDescription: Value(map['weatherDescription']),
        tagNames: Value.absentIfNull(map['tagNames'] as List<String>?),
      );
    }).toList();

    final tags = tagsData.map((data) {
      final map = data as Map<String, dynamic>;
      return TagsCompanion(
        id: Value(map['id']),
        name: Value(map['name']),
        createdAt: Value((map['createdAt'] as Timestamp).toDate()),
      );
    }).toList();

    // 3. Clear local database
    await _localDataSource.clearAllData();

    // 4. Insert restored data
    await _localDataSource.insertJournalsAndTags(journals, tags);

    // 5. Rebuild journal-tag relationships
    final journalToTagsMap = <int, List<String>>{};
    for (final data in journalsData) {
      final map = data as Map<String, dynamic>;
      final journalId = map['id'] as int;
      final tagNames = (map['tagNames'] as List<dynamic>?)?.cast<String>();
      if (tagNames != null && tagNames.isNotEmpty) {
        journalToTagsMap[journalId] = tagNames;
      }
    }
    await _localDataSource.linkJournalsToTags(journalToTagsMap);
  }
}
