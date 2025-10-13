import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> backup() async {
    // 1. Get user ID (For now, use a placeholder)
    const userId =
        'test_user'; // TODO: Replace with actual user ID from UserProvider

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
  Future<void> restore() async {
    // TODO: Implement restore logic
  }
}
