import 'package:drift/drift.dart';

class AddJournalRequest extends Table {
  final String? content;
  final String moodName;
  final String? imageUri;

  const AddJournalRequest({
    required this.content,
    required this.moodName,
    required this.imageUri,
  });
}
