import 'package:equatable/equatable.dart';

class AddJournalRequest extends Equatable {
  final String? content;
  final String moodName;
  final String? imageUri;

  const AddJournalRequest({
    required this.content,
    required this.moodName,
    required this.imageUri,
  });

  @override
  List<Object?> get props => [content, moodName, imageUri];
}
